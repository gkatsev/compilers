structure MipsFrame : FRAME = 
struct

  (* Memory access - Where the variable can be found. *)
  datatype access = InFrame of int | InReg of Temp.temp

  type frame = {name : Temp.label, formals: access list}

  datatype frag = PROC of {body: Tree.stm, frame: frame}
                | STRING of Temp.label * string

  type register = (string * Temp.temp)

  fun string(lab, str) = 
    Symbol.name(lab) ^ ": .asciiz \"" ^ str ^ "\""

(* MIPS Registers
    Name      Number     Use                Callee must preserve?
    $zero     $0         constant 0               N/A
    $at       $1         assembler temporary      No
    $v0–$v1   $2–$3      values for function 
                         returns and 
                         expression evaluation    No
*    $a0–$a3   $4–$7      function arguments       No
*    $t0–$t7   $8–$15     temporaries              No
*    $s0–$s7   $16–$23    saved temporaries        Yes
*    $t8–$t9   $24–$25    temporaries              No
    $k0–$k1   $26–$27    reserved for OS kernel   No
    $gp       $28        global pointer           Yes
    $sp       $29        stack pointer            Yes
    $fp       $30        frame pointer            Yes
    $ra       $31        return address           N/A 

  Source: wikipedia
*)
  val registerNames = 
    ["$zero", "$at", "$v0", "$v1", 
     "$a0", "$a1", "$a2", "$a3",
     "$t0", "$t1", "$t2", "$t3", "$t4", "$t5", "$t6", "$t7", "$t8", "$t9",
     "$s0", "$s1", "$s2", "$s3", "$s4", "$s5", "$s6", "$s7",
     "$k0", "$k1", 
     "$gp", "$sp", "$fp", "$ra"]

  val registers = 
    (map (fn (regnam) => (regnam, Temp.newtemp())) registerNames)

  val tempMap = 
    (List.foldl 
      (fn (reg, regTbl) => Temp.Table.enter(regTbl,(#2 reg), reg))  
      Temp.Table.empty registers)

  fun tempToS(temp) = 
    (case Temp.Table.look(tempMap, temp)
      of SOME(reg) => (#1 reg)
       | NONE => Temp.makestring(temp))


  fun getRegByName(reg, registers) =
    let val (name, temp) = hd(List.filter (fn (regname, temp) => regname = reg) 
                              registers)
    in temp end

  (* Register that holds the address of the current Frame Pointer *)
  val FP = getRegByName("$fp", registers)

  (* Register that holds the address of the return value *)
  val RV = getRegByName("$v0", registers)
  val RA = getRegByName("$ra", registers)
  val ZERO = getRegByName("$zero", registers)
  val SP = getRegByName("$sp", registers)

  val tempregs = (List.filter (fn (nam, tmp) => String.sub(nam, 1) = #"t") registers)
  val savedtempregs = (List.filter (fn (nam, tmp) => String.sub(nam, 1) = #"s") registers)


  val argregs = (List.filter (fn (nam, tmp) => String.sub(nam,1) = #"a") registers)
  val calleesaves = savedtempregs 
  val callersaves = tempregs @ argregs
  val specialregs = (List.filter (fn (nam, tmp) => 
                                let val nth = String.sub(nam, 1)
                                in nth <> #"t" orelse nth <> #"a" orelse nth <> #"s"
                                end)
                            registers)

  (* list of temps *)
  val calldefs = (map #2 callersaves) @ [RA, RV]



  (* Wordsize of the Architecture we're compiling towards *)
  val wordSize = 4

  
  (* translateFormals : (bool list) -> access list
   * Translates a list of boolean offsets into their appropriate accesses
   *)
  fun translateFormals(formals) = 
  let 
    val currentOffset = ref 0 

    fun incrementOffset() = currentOffset := !currentOffset - wordSize

    fun trFormal(true) = 
        let val myOffset = !currentOffset
        in (incrementOffset(); InFrame(myOffset))
        end
      | trFormal(false) = InReg(Temp.newtemp())
        
  in
    (map trFormal formals)
  end

  (* newFrame : {Temp.label, bool list} -> Frame.frame
   * Returns a new frame, translating all of variable escapes (represented by
   * the bool list; true means in-frame/mem, false means in-reg) into the
   * appropriate Frame.access
   *)
  fun newFrame({name, formals}) = 
    {name=name, formals=translateFormals(formals)}

  (* name : Frame.frame -> Temp.label
   * Returns the name of a frame.
   *)
  fun name({name, formals}) = name

  (* formals : Frame.frame -> access list
   * Returns a list of the accesses for all of the formal parameters for the
   * frame.
   *)
  fun formals({name, formals}) = formals

  (* staticLink : frame -> access
   * Returns the access to the previous frame
   *)
  fun staticlink(frame) = 
    (case hd(formals(frame))
       of InFrame(k) => k
        | InReg(tmp) => 
            ErrorMsg.impossible(
            "Static Links will never live in a"
            ^ "register. What hath god wrought?"))

  (* findMinOffset : access list -> int
   * Finds the lowest offset in the given list of accesses. 
   * Offsets get consecutively more negative, according to wordSize. *)
  fun findMinOffset([]) = 0
    | findMinOffset(InFrame(offset)::xs) = Int.min(offset, findMinOffset(xs))
    | findMinOffset(InReg(_)::xs) = findMinOffset(xs)

  (* allocLocal : Frame.frame -> (bool -> access)
   * Given a frame, returns a function that translates bools to the appropriate
   * access.
   * true -> InFrame
   * false -> InReg
   *)
  fun allocLocal({name, formals}) = 
    let val minOffset = findMinOffset(formals)
        val currentOffset = ref minOffset

        (* nextOffset : unit -> int
         * Returns the next offset for a frame, and increments the currentOffset
         * pointer
         *)
        fun nextOffset() = 
          let val offset = currentOffset
          in
            ((currentOffset := !currentOffset - wordSize);
             !offset)
          end

        fun findAccess(true) = InFrame(nextOffset())
          | findAccess(false) = InReg(Temp.newtemp())
    in
      findAccess
    end

  fun procEntryExit1(frame,body: Tree.stm) = body
  fun procEntryExit2(frame,body) =
    body @ [Assem.OPER{assem="", 
                       src=[ZERO, RA, SP]@(map #2 calleesaves),
                       dst=[], jump=SOME[]}]
  fun procEntryExit3({name,formals}, body) =
    {prolog = "### PROCEDURE " ^ Symbol.name name ^ " ###\n",
     body = body,
     epilog = "### END " ^ Symbol.name name ^ " ###\n"}

  (* exp : Frame.access -> (Tree.exp -> Tree.exp)
   * access := The access (memory address) of the variable we would like to
   *           obtain the value of
   * fp := The frame pointer of for where the variable was declared. 
   * returns the complete Tree.exp expression that will obtain the value of the
   * variable requested.  
   *)
  fun exp(access) =
    (case access
       of InFrame(k) => 
            (fn(fpExp) => Tree.MEM(Tree.BINOP(Tree.PLUS, fpExp, Tree.CONST(k))))
        | InReg(reg) => 
            (fn(fpExp) => Tree.TEMP(reg)))

  (* callExternal : String (Tree.exp list) -> Tree.exp
   * Calls the externally defined function, func, with the args whose values are
   * the result of the expressions in args.
   *)
  fun callExternal(func, args) = 
    Tree.CALL(Tree.NAME(Temp.namedlabel(func)), args)

end

structure Frame : FRAME = MipsFrame

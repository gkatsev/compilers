structure MipsFrame : FRAME = 
struct

  (* Memory access - Where the variable can be found. *)
  datatype access = InFrame of int | InReg of Temp.temp
  type frame = {name : Temp.label, formals: access list}
  datatype frag = PROC of {body: Tree.stm, frame: frame}
                | STRING of Temp.label * string

  (* Register that holds the address of the current Frame Pointer *)
  val FP = Temp.newtemp()

  (* Register that holds the address of the return value *)
  val RV = Temp.newtemp()

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

  fun procEntryExit1(frame,body) = body

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

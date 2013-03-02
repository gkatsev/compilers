signature TRANSLATE =
sig
  type level
  type access (* not the same as Frame.access *)
  type exp

  val outermost : level
  val newLevel : {parent: level,
                  name: Temp.label,
                  formals: bool list} -> level
  val formals : level -> access list
  val allocLocal : level -> bool -> access
  val procEntryExit : {level: level, body: exp} -> unit
  val getResult : unit -> Frame.frag list
end

structure Tr = Tree

structure Translate = 
struct
  (* Represents the current stack frame level, where
   * frame := the frame for this level
   * unit ref := pointer used for unique frame comparisons *)
  datatype level = Toplevel
                 | ChildLevel of {frame: Frame.frame, 
                                  parent: level, 
                                  uniq: unit ref}

  (* Represents how to access a variable 
   * level := the frame in which this variable was declared
   * Frame.access := how to access the variable in reference to the level it is
   * declared in. *)
  type access = level * Frame.access

  (* Translate.exp is a datastructure to encapsulate the Tree.exp datastructure
   * and so maintain a data separation between Semant & Absyn, and the
   * low level machine language represented in Tree *)
  datatype exp = Ex of Tr.exp
               | Nx of Tr.stm
               | Cx of Temp.label * Temp.label -> Tr.stm


  (* Represents the outermost frame, in which the main function of a tiger
  * program lives, as well as top-level stdlib functions *)
  val outermost = ChildLevel(
                    {frame = Frame.newFrame({name=Temp.newlabel(), formals=[]}), 
                    parent = Toplevel,
                    uniq = ref ()})

  (* As we process Absyn translations, some code, especially function
   * declarations, does not directly produce or return an IR expression.
   * Rather, the code is added to the fraglist to be processed later on in the
   * IR code translation
   *)
  val fraglist = ref [] : Frame.frag list ref
  
  fun addToFrags(newFrag : Frame.frag) = fraglist := newFrag::(!fraglist)
  
  fun getResult() = !fraglist

  (*********** Helper Functions ***********)
  
  fun notImplemented() = ErrorMsg.impossible "not implemented"

  (* seq : [Tree.stm list] -> Tree.stm *)
  fun seq([]) = Tr.EXP(Tr.CONST(0))
    | seq([s]) = s
    | seq(s::ss) = Tr.SEQ(s, seq(ss))

  (* unEx : Translate.exp -> Tr.exp
   * convert Nx and Cx into a corresponding Ex *)
  fun unEx (Ex e) = e
    | unEx (Cx genstm) = 
        let val r = Temp.newtemp()
            val t = Temp.newlabel() and f = Temp.newlabel()
        in  Tr.ESEQ(seq[Tr.MOVE(Tr.TEMP r, Tr.CONST 1),
                          genstm(t,f),
                          Tr.LABEL f,
                          Tr.MOVE(Tr.TEMP r, Tr.CONST 0),
                          Tr.LABEL t],
                      Tr.TEMP r)
        end
    | unEx (Nx s) = Tr.ESEQ(s, Tr.CONST 0)

  (* unNx : Translate.exp -> Tree.stm
   * convert Ex and Cx into a correspoding Nx *)
  fun unNx (Ex e) = Tr.EXP(e) 
    | unNx (Cx genstm) = 
        let val t = Temp.newlabel() and f = Temp.newlabel()
        in genstm(t,f) 
        end
    | unNx (Nx s) = s

  (* unCx : Translate.exp -> (Temp.label * Temp.label -> Tree.stm)
   * convert Ex into a correspoding Cx. Nx should never be passed here*)
  fun unCx(Ex(Tr.CONST(0))) = (fn (t,f) => Tr.JUMP(Tr.NAME(f), [f]))
    | unCx(Ex(Tr.CONST(1))) = (fn (t,f) => Tr.JUMP(Tr.NAME(t), [t]))
    | unCx(Ex e) = 
      let val r = Temp.newtemp()  (* temporary register r *)
      in (fn (t,f) => Tr.SEQ(Tr.MOVE(Tr.MEM(Tr.TEMP r), e),
                           (Tr.CJUMP(Tr.EQ, Tr.TEMP r, Tr.CONST 0, f, t))))
      end
    | unCx(Cx genstm) = genstm
    | unCx(Nx s) = ErrorMsg.impossible("this should never happen either")

  (* prependVarInit : (Translate.exp list) Translate.exp -> Translate.exp
   * Given a list of variable initialization expressions, as created by variable
   * declarations in a let expressions, prepends those initializations onto 
   * the given body expression.
   *)
  fun prependVarInit(varExps, body) =
    Ex(Tr.ESEQ(seq(map unNx varExps), unEx(body))) 

  (*********** Frame Manipulation ***********)

  (* val newLevel : {level, label, bool list} -> Translate.level
   * Create a new nesting level.
   *)
  fun newLevel({parent, name, formals}) =
    ChildLevel(
      {frame = Frame.newFrame({name=name, formals=true::formals}),
       parent = parent,
       uniq = ref ()})

  (* allocLocal : Translate.level -> (bool -> Translate.access)
   * Given a frame, returns a function that translates bools to the appropriate
   * access.
   *)
  fun realAllocLocal({frame,parent,uniq}) =  (* please stand up *)
        fn (b) => (ChildLevel({frame=frame, parent=parent, uniq=uniq}), 
                   Frame.allocLocal(frame)(b))

  fun allocLocal(ChildLevel(level)) = realAllocLocal(level)
    | allocLocal(TopLevel) = ErrorMsg.impossible
                              "Cannot allocate vars in the toplevel"

  fun procEntryExit{level, body} = 
    case level 
      of ChildLevel(level) => 
          let val frame = (#frame level)
              val bodystm = Frame.procEntryExit1(frame, body)
          in
            addToFrags(Frame.PROC({body = bodystm, frame = frame}))
          end
       | TopLevel =>  ErrorMsg.impossible 
                        "no funs defined in top level"


  (* formals : level -> access list
   * returns the suitably converted access list from Frame.formals minus the
   * static link formal. *)
  fun realFormals({frame, parent, uniq}) =
        let 
          val formals = Frame.formals(frame)
          
          fun tupelize(formal) = 
            (ChildLevel({frame=frame, parent=parent, uniq=uniq}), formal)

          val cFormals = map tupelize formals
        in 
          tl(cFormals)
        end

  fun formals(ChildLevel(level)) = realFormals(level)
    | formals(TopLevel) = ErrorMsg.impossible
                            "cannot get formals of the TopLevel"

  (*********** AST Translation Functions ***********)

  fun nilExp() = Ex(Tr.CONST(0))

  fun intExp(n:int) = Ex(Tr.CONST(n))

  (* stringLit : String -> Translate.exp
   * For each string literal lit, the Translate module makes a new label lab,
   * and returns the tree Tree.NAME(lab). It also puts the assembly-language
   * fragment Frame.STRING(lab,lit) onto a global list of such fragments to be
   * handed to the code emitter.
   *)
  fun stringExp(str:string) = 
    let val strlabel = Temp.newlabel()
    in
      (addToFrags(Frame.STRING(strlabel, str));
       Ex(Tr.NAME(strlabel)))
    end

  fun opExp(left, Absyn.PlusOp, right) = 
        Ex(Tr.BINOP(Tr.PLUS, unEx(left), unEx(right)))

    | opExp(left, Absyn.MinusOp, right) = 
        Ex(Tr.BINOP(Tr.MINUS, unEx(left), unEx(right)))

    | opExp(left, Absyn.TimesOp, right) =
        Ex(Tr.BINOP(Tr.MUL, unEx(left), unEx(right)))
      
    | opExp(left, Absyn.DivideOp, right) = 
        Ex(Tr.BINOP(Tr.DIV, unEx(left), unEx(right)))

    | opExp(left, Absyn.EqOp, right) =
        Cx(fn (t,f) => Tr.CJUMP(Tr.EQ, unEx(left), unEx(right), t, f))

    | opExp(left, Absyn.NeqOp, right) = 
        Cx(fn (t,f) => Tr.CJUMP(Tr.NE, unEx(left), unEx(right), t, f))

    | opExp(left, Absyn.LtOp, right) = 
        Cx(fn (t,f) => Tr.CJUMP(Tr.LT, unEx(left), unEx(right), t, f))

    | opExp(left, Absyn.LeOp, right) = 
        Cx(fn (t,f) => Tr.CJUMP(Tr.LE, unEx(left), unEx(right), t, f))

    | opExp(left, Absyn.GtOp, right) = 
        Cx(fn (t,f) => Tr.CJUMP(Tr.GT, unEx(left), unEx(right), t, f))

    | opExp(left, Absyn.GeOp, right) = 
        Cx(fn (t,f) => Tr.CJUMP(Tr.GE, unEx(left), unEx(right), t, f))


  (* seqExp : [Translate.exp list] -> Translate.exp 
   * Empty sequence expressions "()" will translate as the CONST(0), because
   * they represent nothing. () is a valid program, and is essentially
   * equivalent to
   * int main(int argc, cha** argv) { return 0; }
   *)
  fun seqExp(seqs) = Nx(seq(map unNx seqs))
  
  (* funcall : Symbol, level, Temp.label, Translate.exp list -> Translate.exp
   * Translates a function call into the appropriate IR representation
   * 
   *)
  fun funcall(name,ChildLevel(level),label,args) =  
        let val sl = Tr.CONST(Frame.staticlink(#frame level))
        in Ex(Tr.CALL(Tr.NAME(label), sl::(map unEx args)))
        end
    | funcall(name, TopLevel, label, args) = ErrorMsg.impossible "boo!"

  fun ifExp(test, thenExp, elseExpOpt) = 
    case elseExpOpt
      of NONE => 
          (* Create labels t and ifend
           * turn test into a Jump / Cx and give it t and ifend for t/f branches
           * for label t, put thenExp code
           * Label ifend at bottom *)
           let
             val t = Temp.newlabel()
             val ifend = Temp.newlabel()
           in
            Nx(seq[Tr.CJUMP(Tr.EQ, Tr.CONST(1), unEx(test), t, ifend),
                   Tr.LABEL(t),
                   unNx(thenExp),
                   Tr.LABEL(ifend)])
           end

       | SOME(elseExp) => 
          (* Create labels t,f, ifend and register retVal
           * Turn test into a jump / Cx and give it labels t and f
           * For label T, Move result of IR code for thenExp in retVal, 
           *   Jump to ifend
           * For label F, Move result of IR code for elseExp into retVal,
           * Label ifend at bottom *)
           let
             val t = Temp.newlabel() and f = Temp.newlabel()
             val ifend = Temp.newlabel()
             val retVal = Temp.newtemp()
           in
             Nx(seq[Tr.CJUMP(Tr.EQ, Tr.CONST(1), unEx(test), t, ifend),
                    Tr.LABEL(t),
                      Tr.MOVE(Tr.TEMP(retVal), unEx(thenExp)),
                      Tr.JUMP(Tr.NAME(ifend), [ifend]),
                    Tr.LABEL(f),
                      Tr.MOVE(Tr.TEMP(retVal), unEx(elseExp)),
                    Tr.LABEL(ifend)])
           end

  (* breakExp : Temp.label -> Translate.exp 
   * translates a break exp into the appropriate IR representation 
   *)
  fun breakExp(break) = Nx(Tr.JUMP(Tr.NAME(break), [break]))

  (* whileExp : Translate.exp Translate.exp Temp.label -> Translate.exp
   * translates while exp into the appropriate IR representation
   *)
  fun whileExp(test, body, break) =
    let
      val test_lbl= Temp.newlabel()
      val body_lbl = Temp.newlabel()
    in
      Nx(seq[Tr.LABEL(test_lbl),
             unCx(test)(body_lbl, break),
             Tr.LABEL(body_lbl),
                unNx(body),
                Tr.JUMP(Tr.NAME(test_lbl), [test_lbl]),
             Tr.LABEL(break)])
    end

  (* forExp : exp exp exp label -> exp
   * translates a for exp into the appropriate IR representation. p.166
   *)
  fun forExp(lo_exp, hi_exp, body_exp, break) = 
    let
      val body_lbl = Temp.newlabel()
      val test_lbl = Temp.newlabel()
      val index = Temp.newtemp()
      val limit = Temp.newtemp()

      fun increment(idx) = 
        Tr.MOVE(Tr.TEMP(idx), Tr.BINOP(Tr.PLUS, Tr.TEMP(idx), Tr.CONST(1)))
    in
      Nx(seq[Tr.MOVE(Tr.TEMP index, unEx(lo_exp)),
             Tr.MOVE(Tr.TEMP limit, unEx(hi_exp)),
             
             Tr.CJUMP(Tr.LE, unEx(lo_exp), unEx(hi_exp), body_lbl, break),
            
             Tr.LABEL(body_lbl),
               unNx(body_exp),
               increment(index),

             Tr.LABEL(test_lbl),
             Tr.CJUMP(Tr.LE, Tr.TEMP(index), Tr.TEMP(limit), body_lbl, break),

             Tr.LABEL(break)])
    end

  (* frameOffset : level level -> Tree.exp
   * Return the tree.exp that represents how to access the beginning of a frame
   * defined from the frame in curlvl 
   *)
  fun frameOffset(ChildLevel(curlvl), ChildLevel(deflvl)) = 
        if (#uniq curlvl) = (#uniq deflvl) 
        then Tr.TEMP(Frame.FP)
        else 
          let 
            (* slOffset is the address of the beginnning of the previous frame 
             * We can access it through staticlink(#frame curlvl)
             *)
            val slOffset = Frame.staticlink(#frame curlvl)
          in
            Tr.MEM(Tr.BINOP(Tr.PLUS, Tr.CONST(slOffset), 
                              frameOffset((#parent curlvl), ChildLevel(deflvl))))
          end
    | frameOffset(_, _) = ErrorMsg.impossible("Lucy in the sky with diamonds.")

  (* Cases:
   * 1. Variable defined within our scope (curlvl = deflvl)
   *    Then, return the current value of the frame pointer register.
   *
   *    First time calling => Want the FP
   *    N-Time Calling => B/c this is the final offset, want the FP.
   * 
   * 2. Variable defined in outer scope (curlvl != deflvl) & curlvl is the 
   *    level var X is used in.
   *    Then, return Tr.MEM( +(Frame.FP, findFrameOffset(#parent, deflvl)) )
   *
   * 3. Variable defined in outer scope (curlvl != deflvl) & curlvl is some
   *    intermediate level between where var X is accessed and where it is
   *    defined.
   *    Then, return Tr.MEM( +(myFP, findFrameOffset(#parent, deflvl)) )
   *)


  (* simpleVar : Translate.access Translate.level -> exp 
   * translates a simple var exp into the appropriate IR representation
   * access := How to access the variable in reference to its declared frame,
   *           plus what frame it was declared in.
   * level := The current stack frame level.
   *          The level of the function in which a var is used.
   *)
  fun simpleVar(access, curlvl) =
    let
      (* deflvl := Level of definition
       * fraccess := Frame.access of how to get at the variable in its 
       *             declared frame 
       *)
      val (deflvl, fraccess) = access 
    in
      Ex(Frame.exp(fraccess)(frameOffset(curlvl, deflvl)))
    end

  (* fieldVar : Translate.exp int acccess level -> exp
   * varexp tells us how to get the variable in respect to the record's frame
   * which is located inside of access *)
  fun fieldVar(varexp, idx) = 
      Ex(Tr.MEM(Tr.BINOP(Tr.PLUS, unEx(varexp), Tr.CONST(idx*Frame.wordSize))))

  fun subscriptVar(varexp, offsetexp) =
    Ex(Tr.MEM(Tr.BINOP(Tr.PLUS, unEx(varexp), unEx(offsetexp))))

  fun assignExp(varexp, exp) =
    Nx(Tr.MOVE(unEx(varexp), unEx(exp)))

  (* arrayExp : Translate.exp Translate.exp -> Translate.exp *)
  fun arrayExp(size, init) = 
    Nx(Tr.MOVE(Tr.TEMP(Temp.newtemp()), 
               Frame.callExternal("initArray", [unEx(size), unEx(init)])))

  (* recordExp : (list Translate.exp) -> Translate.exp
   * Given a series of initialization expressions for all fields in a record, 
   * initializes the memory area for the record and returns a pointer to the
   * beginning of the record memory area.
   * Note that records are defined to have a flat layout. All records for a
   * given record type will have the same layout. 
   *)
  fun recordExp(fields) = 
    (* 1. Call External Memory-Management to get pointer to block of memory with
     *    size (size(fields) * Frame.wordSize)
     * 2. Series of MOVE statements to initialize offsets at 0, 1W, 2W, ... nW
     *    with each value in the fields array
     * 3. Return Temp(r), where r is the address of the record memory block
     *)
    let 
      val r = Temp.newtemp()
      val recSize = length(fields) * Frame.wordSize

      (* compute initialization expressions for each field *)
      val idx = ref (~1)
      fun initExp(exp) = 
        (idx := !idx + 1; 
         Tr.MOVE(Tr.MEM(Tr.BINOP(Tr.PLUS, 
                                  Tr.TEMP(r), 
                                  Tr.CONST(!idx * Frame.wordSize))),
                 unEx(exp)))
        
      val initializationExprs = (map initExp fields)
    in
      Ex(Tr.ESEQ(
          seq(Tr.MOVE(Tr.TEMP(r),
                      Frame.callExternal("malloc", [Tr.CONST(recSize)]))
              ::initializationExprs),
          Tr.TEMP(r)))
    end


  fun assignExp(varExp, init) = Nx(Tr.MOVE(unEx(varExp), unEx(init)))

  (* varDec : Translate.exp -> Translate.exp
   * Creates space for and initialize a variable inside a frame.
   *)
  fun varDec(exp) = Nx(Tr.MOVE(Tr.TEMP(Temp.newtemp()), unEx(exp)))

  fun funDec(label, level : level, body) = 
    procEntryExit({level = level,
                   body = Tr.SEQ(Tr.LABEL(label), unNx(body))})
    
end

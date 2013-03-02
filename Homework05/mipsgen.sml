signature CODEGEN =
sig
  val codegen : Frame.frame -> Tree.stm -> Assem.instr list
end

structure Mipsgen  : CODEGEN = 
struct
  fun codegen(frame)(stm: Tree.stm) : Assem.instr list =
    let 
      val ilist = ref (nil: Assem.instr list)
      fun emit x = (ilist := x :: (!ilist))
      fun result(gen) = let val t = Temp.newtemp() in (gen t; t) end
      
      (* munchArgs  : int (exp list) -> Temp.temp list
       * Given a list of expressions representing the arguments for a function
       * call, Creates a series of MOVE asm statements, and returns a list of
       * the Temp.temps where the result of each statement can be found.
       *)
      fun munchArgs(idx, args) = 
        if (idx = length(args))
        then []
        else munchExp(List.nth(args, idx))::munchArgs(idx+1, args)

      (* munchStm : Tree.stm -> () *)
      and munchStm(Tree.SEQ(a,b)) = (munchStm a; munchStm b)
        | munchStm(Tree.MOVE(Tree.MEM(
                                Tree.BINOP(Tree.PLUS, e1, Tree.CONST i)), 
                             Tree.NAME(lbl))) =
            emit(Assem.MOVE{assem=("la "  ^ Int.toString(i) ^ "(`d0), "
                                   ^ Symbol.name(lbl) ),
                            src=Temp.newtemp(),
                            dst=munchExp e1})
        | munchStm(Tree.MOVE(Tree.MEM(
                      Tree.BINOP(Tree.PLUS,e1, Tree.CONST i)), e2)) =
            emit(Assem.MOVE{assem="sw `s0, " ^ Int.toString(i) ^ " (`d0)",
                            src=munchExp e2,
                            dst=munchExp e1})
        | munchStm(Tree.MOVE(Tree.MEM(
                      Tree.BINOP(Tree.PLUS, Tree.CONST i, e1)), e2)) =
            emit(Assem.MOVE{assem="sw `s0, " ^ Int.toString(i) ^ " (`d0)",
                            src=munchExp e2,
                            dst=munchExp e1})
        | munchStm(Tree.MOVE(Tree.MEM(Tree.CONST i), e1)) =
            emit(Assem.MOVE{assem="sw `s0, `d0",
                            src=munchExp e1,
                            dst=i})
        | munchStm(Tree.MOVE(Tree.MEM(e1), e2)) =
            emit(Assem.MOVE{assem="sw `s0, (`d0)",
                            src=munchExp e2, dst=munchExp e1})
        | munchStm(Tree.MOVE(Tree.TEMP(t), e1)) =
            emit(Assem.MOVE{assem="sw `s0, (`d0)",
                            src=munchExp e1, dst=t})
        | munchStm(Tree.MOVE(e1, e2)) =
            emit(Assem.MOVE{assem="sw `s0, (`d0)",
                            src=munchExp e2, dst=munchExp e1})
        | munchStm(Tree.JUMP(Tree.NAME(lbl), lbllist)) =
            emit(Assem.OPER{assem="j `j0",
                            src=[], dst=[], jump=SOME(lbllist)})
        | munchStm(Tree.JUMP(Tree.CONST i, lbllist)) =
            emit(Assem.OPER{assem="j `j0",
                            src=[], dst=[], jump=SOME(lbllist)})
        | munchStm(Tree.JUMP(e1, lbllist)) =
            emit(Assem.OPER{assem="j `s0",
                            src=[munchExp e1], dst=[], jump=SOME(lbllist)})
        (* Appell Says: 
         * """
         * Conditional jumps, which may branch away or fall through, typically
         * have two labels in the jump list but refer to only one of them in the
         * assem string. """ (p. 203)
         * Meaning: Don't worry about lbl2
         *)
        | munchStm(Tree.CJUMP(Tree.EQ, e1, e2, lbl1, lbl2)) =
            emit(Assem.OPER{assem="beq `s0, `s1, " ^ Symbol.name(lbl1),
                            src=[munchExp e1, munchExp e2],
                            dst=[], jump=SOME([lbl1, lbl2])})
        | munchStm(Tree.CJUMP(Tree.NE, e1, e2, lbl1, lbl2)) =
            emit(Assem.OPER{assem="bne `s0, `s1, " ^ Symbol.name(lbl1),
                            src=[munchExp e1, munchExp e2],
                            dst=[], jump=SOME([lbl1, lbl2])})
        | munchStm(Tree.CJUMP(Tree.LT, e1, e2, lbl1, lbl2)) =
            emit(Assem.OPER{assem="blt `s0, `s1, " ^ Symbol.name(lbl1),
                            src=[munchExp e1, munchExp e2],
                            dst=[], jump=SOME([lbl1, lbl2])})
        | munchStm(Tree.CJUMP(Tree.GT, e1, e2, lbl1, lbl2)) =
            emit(Assem.OPER{assem="bgt `s0, `s1, " ^ Symbol.name(lbl1),
                            src=[munchExp e1, munchExp e2],
                            dst=[], jump=SOME([lbl1, lbl2])})
        | munchStm(Tree.CJUMP(Tree.LE, e1, e2, lbl1, lbl2)) =
            emit(Assem.OPER{assem="ble `s0, `s1, " ^ Symbol.name(lbl1),
                            src=[munchExp e1, munchExp e2],
                            dst=[], jump=SOME([lbl1, lbl2])})
        | munchStm(Tree.CJUMP(Tree.GE, e1, e2, lbl1, lbl2)) =
            emit(Assem.OPER{assem="bge `s0, `s1, " ^ Symbol.name(lbl1),
                            src=[munchExp e1, munchExp e2],
                            dst=[], jump=SOME([lbl1, lbl2])})
        | munchStm(Tree.CJUMP(Tree.ULT, e1, e2, lbl1, lbl2)) =
            emit(Assem.OPER{assem="bltu `s0, `s1, " ^ Symbol.name(lbl1),
                            src=[munchExp e1, munchExp e2],
                            dst=[], jump=SOME([lbl1, lbl2])})
        | munchStm(Tree.CJUMP(Tree.UGT, e1, e2, lbl1, lbl2)) =
            emit(Assem.OPER{assem="bgtu `s0, `s1, " ^ Symbol.name(lbl1),
                            src=[munchExp e1, munchExp e2],
                            dst=[], jump=SOME([lbl1, lbl2])})
        | munchStm(Tree.CJUMP(Tree.ULE, e1, e2, lbl1, lbl2)) =
            emit(Assem.OPER{assem="bleu `s0, `s1, " ^ Symbol.name(lbl1),
                            src=[munchExp e1, munchExp e2],
                            dst=[], jump=SOME([lbl1, lbl2])})
        | munchStm(Tree.CJUMP(Tree.UGE, e1, e2, lbl1, lbl2)) =
            emit(Assem.OPER{assem="bgeu `s0, `s1, " ^ Symbol.name(lbl1),
                            src=[munchExp e1, munchExp e2],
                            dst=[], jump=SOME([lbl1, lbl2])})
        | munchStm(Tree.LABEL l) =
            emit(Assem.LABEL{assem= Symbol.name(l) ^ ":\n",
                             lab=l})
        | munchStm(Tree.EXP(Tree.CALL(e,args))) =
            emit(Assem.OPER{assem="jal `s0",
                            src=(munchExp e)::munchArgs(0,args),
                            dst=Frame.calldefs, jump=NONE})
        | munchStm(Tree.EXP(e)) = (munchExp e; ())


      (* munchStm : Tree.exp -> Temp.temp *)
      and munchExp(Tree.ESEQ(s, e)) = (munchStm s; munchExp e)
        | munchExp(Tree.MEM(Tree.BINOP(Tree.PLUS, e1, Tree.CONST i))) =
            result(fn r => emit(Assem.OPER{
                              assem=("lw `d0, " ^ Int.toString(i) ^ "(`s0)"),
                              src=[munchExp e1],
                              dst=[r], jump=NONE}))
        | munchExp(Tree.MEM(Tree.BINOP(Tree.PLUS, Tree.CONST i, e1))) =
            result(fn r => emit(Assem.OPER{
                              assem=("lw `d0, " ^ Int.toString(i) ^ "(`s0)"),
                              src=[munchExp e1],
                              dst=[r], jump=NONE}))
        | munchExp(Tree.MEM(Tree.CONST i)) =
            result(fn r => emit(Assem.OPER{
                              assem=("lw `d0, " ^ Int.toString(i) ^ "(r0)"),
                              src=[], dst=[r], jump=NONE}))
        | munchExp(Tree.MEM(e1)) =
            result(fn r => emit(Assem.OPER{
                              assem="lw `d0, 0(`s0)",
                              src=[munchExp e1],
                              dst=[r], jump=NONE}))

        | munchExp(Tree.BINOP(Tree.PLUS,Tree.CONST i, e1)) =
            result(fn r => emit(Assem.OPER{
                              assem=("addi `d0, `s0, " ^ Int.toString(i)),
                              src=[munchExp e1],
                              dst=[r], jump=NONE}))
        | munchExp(Tree.BINOP(Tree.PLUS,e1, Tree.CONST i)) =
            result(fn r => emit(Assem.OPER{
                              assem=("addi `d0, `s0, " ^ Int.toString(i)),
                              src=[munchExp e1],
                              dst=[r], jump=NONE}))
        | munchExp(Tree.CONST i) =
            result(fn r => emit(Assem.OPER{
                              assem=("addi `d0, r0, " ^ Int.toString(i)),
                              src=[], dst=[r], jump=NONE}))
        | munchExp(Tree.BINOP(Tree.PLUS, e1, e2)) =
            result(fn r => emit(Assem.OPER{
                              assem="add `d0, `s0, `s1",
                              src=[munchExp e1, munchExp e2],
                              dst=[r], jump=NONE}))
        | munchExp(Tree.BINOP(Tree.MUL, e1, e2)) =
            result(fn r => emit(Assem.OPER{
                              assem="mult `d0, `s0, `s1",
                              src=[munchExp e1, munchExp e2],
                              dst=[r], jump=NONE}))
        | munchExp(Tree.BINOP(Tree.MINUS, e1, e2)) =
            result(fn r => emit(Assem.OPER{
                              assem="sub `d0, `s0, `s1",
                              src=[munchExp e1, munchExp e2],
                              dst=[r], jump=NONE}))
        | munchExp(Tree.BINOP(Tree.DIV, e1, e2)) =
            result(fn r => emit(Assem.OPER{
                              assem="div `d0, `s0, `s1",
                              src=[munchExp e1, munchExp e2],
                              dst=[r], jump=NONE}))
        | munchExp(Tree.BINOP(Tree.AND, e1, e2)) = 
            result(fn r => emit(Assem.OPER{
                              assem="and `d0, `s0, `s1",
                              src=[munchExp e1, munchExp e2],
                              dst=[r], jump=NONE}))
        | munchExp(Tree.BINOP(Tree.OR, e1, e2)) = 
            result(fn r => emit(Assem.OPER{
                              assem="or `d0, `s0, `s1",
                              src=[munchExp e1, munchExp e2],
                              dst=[r], jump=NONE}))
        | munchExp(Tree.BINOP(Tree.LSHIFT, e1, e2)) = 
            result(fn r => emit(Assem.OPER{
                              assem="sll `d0, `s0, `s1",
                              src=[munchExp e1, munchExp e2],
                              dst=[r], jump=NONE}))
        | munchExp(Tree.BINOP(Tree.RSHIFT, e1, e2)) = 
            result(fn r => emit(Assem.OPER{
                              assem="srl `d0, `s0, `s1",
                              src=[munchExp e1, munchExp e2],
                              dst=[r], jump=NONE}))
        | munchExp(Tree.BINOP(Tree.ARSHIFT, e1, e2)) = 
            result(fn r => emit(Assem.OPER{
                              assem="sra `d0, `s0, `s1",
                              src=[munchExp e1, munchExp e2],
                              dst=[r], jump=NONE}))
        | munchExp(Tree.BINOP(Tree.XOR, e1, e2)) = 
            result(fn r => emit(Assem.OPER{
                              assem="xor `d0, `s0, `s1",
                              src=[munchExp e1, munchExp e2],
                              dst=[r], jump=NONE}))
        | munchExp(Tree.CALL(Tree.NAME(lbl), args)) = 
            result(fn r => emit(Assem.OPER{
                              assem="jal `j0",
                              src=munchArgs(0,args), 
                              dst=Frame.calldefs,
                              jump=SOME([lbl])}))
        | munchExp(Tree.CALL(e, args)) =
            result(fn r => emit(Assem.OPER{assem="jal `s0",
                              src=(munchExp e)::munchArgs(0,args),
                              dst=Frame.calldefs, jump=NONE}))
        | munchExp(Tree.NAME lbl) = 
            result(fn r =>  emit(Assem.LABEL{
                              assem=Symbol.name(lbl) ^ "\n",
                              lab=lbl}))
        | munchExp(Tree.TEMP t) = t
    in
      (munchStm stm; rev(!ilist))
    end
end

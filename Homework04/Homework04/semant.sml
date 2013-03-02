structure A = Absyn

signature SEMANT =
sig
  type venv
  type tenv

  type expty

  val transProg : A.exp -> expty
end

structure Semant =
struct
  (* A Variable environment is a Symbol Table mapping Symbols (var names) 
   * to  Env.enventries *)
  type venv = Env.enventry Symbol.table

  (* A Type Environment is a Symbol Table mapping Symbols (type names) 
   * to Types.ty *)
  type tenv = Types.ty Symbol.table

  (* The return type of intermediate functions like trexp *)
  type expty = {exp : Translate.exp, ty : Types.ty}

  (* Used to manage whether or not an A.BreakExp is valid *)
  val breakLevel = ref 0
  fun incrementBreakLevel() = (breakLevel := !breakLevel + 1)
  fun decrementBreakLevel() = (breakLevel := !breakLevel - 1)

  (* checkInt : expty  int -> unit
   * Checks whether the given type, ty, is an int. If it is not, an error
   * message is written to stdOut *)
  fun checkInt({exp,ty}, pos) = 
    case ty of Types.INT => ()
            |  _         => ErrorMsg.error pos "expr must be of type int"

  (* checkUnit : {A.exp, Types.ty}, int -> unit
   * Checks whether the given type, ty, is unit. If it is not, an error
   * message is written to stdOut *)
  fun checkUnit({exp,ty}, pos) = 
    case ty of Types.UNIT => ()
             | _          => ErrorMsg.error pos "expr must be of type unit"
  
  (* canTestEquality : {A.exp, Types.ty} int -> unit
   * Checks whether the type given can be tested with the equality binop, =.
   * If it cannot, an error message is written to stdOut. *)
  fun canTestEquality({exp, ty}, pos) = 
      case ty 
        of Types.INT => ()
         | Types.RECORD(flds, uniq) => ()
         | Types.ARRAY(typ, uniq) => ()
         | Types.NIL => ()
         | _ => (ErrorMsg.error pos
                  ("Equal and Not equal ops can only compare integers, " ^
                   " record and array types."); ())

  (* indexOf : 'a ('a list) -> int
   * Returns the index of the element 'a inside a list of 'a 
   *)
  fun indexOf(a, lst) =
    let
      fun indexOfAcc(a, [], acc) = ~1
        | indexOfAcc(a, x::xs, acc) =
            if (a = x) then acc else indexOfAcc(a, xs, acc+1)
    in
      indexOfAcc(a, lst, 0)
    end

  (* sameType : expty expty -> bool
   * Returns true if the type of the first expty is the same as the type of the
   * second expty
   *)
  fun sameType(ty1 : Types.ty, ty2 : Types.ty) = 
    (case ty1
      of Types.RECORD(flds1, uniq1) =>
           (case ty2
              of Types.RECORD(flds2, uniq2) => (uniq1 = uniq2)
               | Types.NIL => true
               | _ => false)

       | Types.ARRAY(arrtyp1 ,uniq1) => 
           (case ty2
              of Types.ARRAY(arrtyp2, uniq2) => (uniq1 = uniq2)
               | _ => false)

      | _ => (ty1 = ty2))

  (* checkSameType :  expty expty int -> unit
   * Checks whether the two types are the same type. If they are not, an error
   * message is written to stdOut *)
  fun checkSameType(exp1 : expty, exp2 : expty, pos) =
    if sameType((#ty exp1), (#ty exp2))
    then ()
    else (ErrorMsg.error pos ("Exprs must be of the same type. " ^
            "Exp1 is " ^ Types.toS(#ty exp1) ^ ", " ^
            "Exp2 is " ^ Types.toS(#ty exp2)))

  (* actual_ty : Types.ty -> Types.ty
   * Given a type, returns the type's "true" type. For most types, this just
   * evaluates to the type itself. Types.NAME, however, must be followed until
   * it refers to a basic type. 
   *
   * Types.ARRAY ???
   *)
  fun actual_ty(ty) =
    (case ty
      of Types.NAME(sym, typOpt) =>
          (case !typOpt
             of NONE => Types.UNIT
              | SOME(typ) => actual_ty(typ))
       | x => x)

  (* findType : Symbol.table Symbol pos -> Types.ty
   * Finds the symbol styp in the type environment tenv. If styp is not found,
   * prints an error message and returns Types.UNIT. Otherwise, returns the
   * actual type of styp.
   *)
  fun findType(tenv, styp, pos) =
    (case Symbol.look(tenv, styp)
       of NONE => (ErrorMsg.error pos 
                    ("undeclared type identifier " ^ Symbol.name(styp));
                   Types.UNIT)
        | SOME(res_ty) => actual_ty(res_ty))



  (* transTy : Symbol.Table A.ty -> Types.ty
   * translates a type definition from the AST into an equivalent Types.ty. 
   *
   * NameTy behavior
   *  type foo = int    -> Types.INT
   *             ^ sym
   *  type bar = foo    -> Types.NAME(foo, ref(SOME(type of foo)))
   *)
  fun transTy(tenv, A.NameTy(sym, pos)) = 
        (case Symbol.look(tenv, sym)
          of NONE => (ErrorMsg.error pos 
                        ("Type " ^ Symbol.name(sym) ^ " is not defined."); 
                      Types.UNIT)
           | SOME(typ) => typ) 

    | transTy(tenv, A.RecordTy(fields)) =
        let
          (* transField : field {symbol,bool ref,symbol,pos} -> Types.ty
           * Translates a field into its Type. 
           * Look up the typ of the field, and return it if found, o/w UNIT
           *)
          fun transField({name,escape,typ,pos}) = 
            (case Symbol.look(tenv, typ)
               of NONE => (ErrorMsg.error pos 
                            ("Type " ^ Symbol.name(typ) ^ " is not defined.");
                           (name, Types.UNIT))
                | SOME(typ') => (name, typ'))
        in
          Types.RECORD((map transField fields), ref ())
        end

    | transTy(tenv, A.ArrayTy(sym, pos)) = 
        (case Symbol.look(tenv, sym)
          of NONE => (ErrorMsg.error pos 
                        ("Type " ^ Symbol.name(sym) ^ " is not defined.");
                      Types.UNIT)
          | SOME(typ) => Types.ARRAY(typ, ref()))

  (* transDecs : Symbol.table Symbol.table Translate.level 
  *             Temp.label (A.dec list) 
  *             -> {venv:Symbol.table, tenv:Symbol.table, exp:Translate.exp}
  * Given a variable environment venv, type environment tenv, the current frame
  * level, a label to jump to if a break statement is encountered, and finally, 
  * a list of declarations, returns a record containing the augmented variable
  * environment, type environment, and an IR representation for the asm
  * expressions that ...
  *)
  fun transDecs(venv, tenv, lev, break, decs) = 
    let 
      (* to enable us to fold over the dec list, we declare three mutable
       * variables that represent the new environments and its initialization
       * code as they're being built up.
       *)
      val venv' = ref venv
      val tenv' = ref tenv
      val varexps = ref [] : Translate.exp list ref

      (* trdec : Symbol.table Symbol.table (Translate.exp list) -> ()
       * Mutates venv', tenv' and varexps to build up the new environment. 
       *)
      fun trdec(A.VarDec(vardec)) = trvardec(vardec)
        | trdec(A.FunctionDec(fundecs)) = ((map trfundec fundecs); ())
        | trdec(A.TypeDec(typedecs)) = ((map trtypedec typedecs); ())
        
      (* trfundec : {Symbol, (field list), Symbol, A.exp, pos} -> unit
       * Performs semantic analysis and IR translation on a single function
       * declaration.
       * Currently, mutually recursive function decs are not supported. FIXME
       *)
      and trfundec({name, params, result, body, pos}) =
      let
        (* transParame : A.field -> {Symbol, Types.ty, bool ref}
         * Translates a function's parameters, represented individual as an
         * A.field, into a Record containing the field's name, and it's type,
         * as found in the type environment tenv.
         *
         * This is a one-off function, used directly below.
         *)
        fun transParam {name,escape,typ,pos} = 
            case Symbol.look(!tenv', typ)
              of NONE => (ErrorMsg.error pos ("undeclared type identifier " ^
                          Symbol.name(typ));
                          {name=name, ty=Types.UNIT, escape=escape})
               | SOME t => {name=name, ty=t, escape=escape}

        (* Translate all params in this function dec into {name, type, escape} 
         * records *)
        val params' = map transParam params

        val result_ty = 
          (case result
            of NONE => Types.UNIT
             | SOME(styp,pos) => findType(!tenv', styp, pos))

        val funEntry =  {label = Temp.newlabel(),
                         level = Translate.newLevel({
                            parent = lev, name=name,
                            formals = (map (fn p => true) params)}),
                         formals = (map #ty params'), 
                         result = result_ty}

        (* Mutuate the global variable scope that's currently in production,
         * venv', with the definition of the function being declared. *)
        val _ = (venv' := Symbol.enter((!venv'), name, Env.FunEntry(funEntry)))

        (* enterParams : {Symbol, Types.ty} Symbol.Table -> Symbol.Table
         * Enters a function parameter {name, type} into the variable symbol
         * table, and returns the augmented symbol table.
         *)
        fun enterParam({name, ty, escape}, venv) = S.enter(venv, name,
                        Env.VarEntry{access=Translate.allocLocal(lev)(!escape),
                                     ty=ty})

        (* Fold over all of this functions params and augment the newly 
         * created variable environment that contains this function's 
         * definition, venv',  with all of its parameters. 
         * venv'' is declared as a separate var env, because it is used only in
         * the evaluation of the body.
         *)
        val venv'' = (List.foldl enterParam) (!venv') params'

        (* Evaluate the body of the function definition, with respect to
        * venv'', containing all of the parameters and the function's def, 
        * and calculate its IR representation and its type. *)
        val body_expty = transExp(venv'', !tenv', lev, break)(body)

      in
        if (result_ty = (#ty body_expty))
        then (Translate.funDec((#label funEntry), (#level funEntry), 
                               (#exp body_expty)))
        else (ErrorMsg.error pos 
               ("In Function " ^ Symbol.name(name) ^ 
                ", function is defined as " ^ Types.toS(result_ty) ^ 
                ", but body is a " ^ Types.toS(#ty body_expty)))
      end

      (* trvardec : {Symbol, (Symbol,pos) opt, exp, pos, bool ref} -> unit
       * Performs semantic analysis and IR translation on a variable dec.
       *)
      and trvardec({name,typ,init,pos,escape}) = 
        (case typ
          (* Variable declaration without a type specified.
           * i.e. val foo = 5 *)
          of NONE =>
              let val {exp, ty} = transExp(!venv', !tenv', lev, break)(init)
              in (venv' := S.enter(!venv', name,
                            Env.VarEntry({
                              access = Translate.allocLocal(lev)(!escape),
                              ty = ty}));
                  varexps := Translate.varDec(exp)::(!varexps))
              end

           (* Variable declaration with a type specified.
            * i.e. val foo : int = 5.
            * styp is the specified type, a tuple containing the name of the
            * type as a symbol, and its stream position*)
           | SOME(styp) => 
               let 
                 (* ty contains the type of the initialization expression. 
                  * We'll need to check to ensure this is the same as what
                  * this variable is specified as, styp *)
                 val {exp,ty} = transExp(!venv', !tenv', lev, break)(init)
                 val (sym, pos1) = styp

                 (* Look up the specified (declared) type's name, sym, in 
                  * the current type environment *) 
                 val dectyp = (case Symbol.look(!tenv', sym)
                                 of NONE => (ErrorMsg.error pos 
                                              ("unknown type " ^ 
                                               Symbol.name(sym));
                                             Types.UNIT)
                                  | SOME(ty) => actual_ty(ty))
               in 
                 if sameType(dectyp, ty)
                 then (venv' := S.enter(!venv', name, 
                                  Env.VarEntry(
                                  {access = Translate.allocLocal(lev)(!escape),
                                   ty = ty}));
                       varexps := Translate.varDec(exp)::(!varexps))
                 else (ErrorMsg.error pos
                        ("var init expression must evaluate to specified type. "
                         ^ "Want: " ^ Types.toS(dectyp) 
                         ^ ", Got: " ^ Types.toS(ty)))
               end)

      (* trtypedec : {Symbol, A.ty, pos} -> unit
       * Performs semantic analysis and IR translation on type declarations.
       * Augment tenv' with the new type.
       *)
      and trtypedec({name, ty, pos}) =
            tenv' := S.enter((!tenv'), name, transTy((!tenv'), ty))
        
    in
      ((map trdec decs);
       {venv = !venv', 
        tenv = !tenv', 
        exp = !varexps})
    end


  (* transExp: ven tenv Translate.level Temp.label -> (A.exp -> expty)
   * 
   * Given variable and type environments venv and tenv, and an evaluation 
   * level/depth, returns a function that, given an AST, performs semantic 
   * analysis on the AST and translates the Expression into the appropriate 
   * IR representation.
            let val {venv=venv', tenv=tenv'} = transDecs(venv, tenv, lev, decs)
            in transExp(venv', tenv', lev) body
            end
   *)
  and transExp(venv, tenv, lev, break) = 
    let
      (* trexp: A.exp -> {Translate.exp, Types.ty} (expty)
       * Takes a A.exp and produces a structure containg Translate.exp and the
       * type of the expression. Also runs any appropriate type error-checking
       * routines.  *)
      fun trexp(A.VarExp(var)) = trvar(var)
        | trexp(A.NilExp) = 
            {exp = Translate.nilExp(), 
             ty = Types.NIL}
        | trexp(A.IntExp(n)) = 
            {exp = Translate.intExp(n), 
             ty = Types.INT}
        | trexp(A.StringExp(lit, pos)) =
            {exp = Translate.stringExp(lit), 
             ty = Types.STRING}
        | trexp(A.CallExp(funcall)) = trfun(funcall)
        | trexp(A.OpExp binop) = trOpExp(binop)
        | trexp(A.RecordExp(recexp)) = trrecord(recexp)
        | trexp(A.SeqExp(seqexp)) = trseq(seqexp)
        | trexp(A.AssignExp(assignexp)) = trassign(assignexp)
        | trexp(A.IfExp(ifexp)) = trif(ifexp)
        | trexp(A.WhileExp(while')) = trwhile(while')
        | trexp(A.ForExp(for)) = trfor(for) 
        | trexp(A.BreakExp(kitkat)) = trbreak(kitkat) 
        | trexp(A.LetExp(letexp)) = trlet(letexp)
        | trexp(A.ArrayExp(arrexp)) = trarray(arrexp)
      
      (* trassign : var exp pos -> expty
       * TODO special case for records and arrays *)
      and trassign({var, exp, pos}) =
        let val varty = trvar var
            val expty = trexp exp
        in
          (checkSameType(varty, expty, pos);
           {exp = Translate.assignExp((#exp varty), (#exp expty)),
            ty = Types.UNIT})
        end


      (* trrecord : field list Types.ty pos -> expty *) 
      and trrecord({fields, typ, pos}) = 
        let 
          (* transforms fields into initialization expressions *)
          fun trfield(sym, exp, pos) = trexp exp
          val initExps = (map #exp (map trfield fields))

          (* look up the Types.RECORD for this record *)
          val recordType = findType(tenv, typ, pos)
        in
          {exp = Translate.recordExp(initExps),
           ty = recordType}
        end

      (* trarray : Types.ty A.exp A.exp pos -> expty
       * Perform semantic analysis and IR translation on Array creation
       * statements.
       *
       * typ := the type the array is defined as
       *)
      and trarray({typ,size,init,pos}) = 
        let
          val size_expty = trexp size
          val init_expty = trexp init

          (* Returns the Types.ty that individual elements of the array are 
           * supposed to be. *)
          fun getType() = 
            (case Symbol.look(tenv, typ)
              of NONE => (ErrorMsg.error pos 
                           ("no such type " ^ Symbol.name(typ));
                          Types.UNIT)
               | SOME(atyp) => atyp)

          (* checkInitType : Symbol Types.ty -> unit
           * Ensures that the type of the initialization expression
           * matches the type of the values the array is supposed to hold.
           *)
          (* typ is the type of the array itself, (array of ____)
           * we want to evaluate the init expressions against ____
           * So, look up typ in tenv to get Types.ARRAY(setyp, uniq)
           * Then, look up setyp in tenv to get the Types.ty that the
           * individual elements should be. 
           * Finally, compare that to the type of the initialization expr;
           * they should match.
           *)
          fun checkInitType() = 
              (case Symbol.look(tenv, typ)
                 of NONE => (ErrorMsg.error pos 
                              ("no such type " ^ Symbol.name(typ)))
                  | SOME(arrtyp) =>
                      (case arrtyp
                         of Types.ARRAY(etyp, uniq) =>
                              if sameType(actual_ty(etyp), (#ty init_expty))
                              then ()
                              else (ErrorMsg.error pos 
                                      ("Array init expression must match " ^
                                       "declared type "
                                       ^ Types.toS(etyp)))
                            
                          | _ => (ErrorMsg.error pos
                                   (Symbol.name(typ) 
                                    ^ " is not an array type"))))
        in
          (checkInt(size_expty, pos);
           checkInitType();
           {exp = Translate.arrayExp((#exp size_expty), (#exp init_expty)),
            ty = getType()})
        end

      (* trlet : (dec list) A.exp pos -> expty
       * Performs semantic analysis and IR translation on let stmts.
       * 
       * Let expressions do not create a new frame level.
       *)
      and trlet({decs, body, pos}) = 
            let 
              (* Create the new environments augmented with 
               * the let expressions type, val and function decs. *)
              val {venv=venv', tenv=tenv', exp=varInitIR} =
                transDecs(venv, tenv, lev, break, decs)

              (* Evaluate the body of the let inside those new envs *)
              val body_expty = transExp(venv', tenv', lev, break)(body)
            in 
              {exp = Translate.prependVarInit(varInitIR, (#exp body_expty)), 
               ty = (#ty body_expty)}
            end

      (* trvar : A.var -> expty
       * Performs semantic analysis and IR translation on variables expressions.
       *)
      and trvar (A.SimpleVar(var)) = trSimpleVar(var)
        | trvar (A.FieldVar(var, symbol, pos)) = trFieldVar(var, symbol, pos)
        | trvar(A.SubscriptVar(var, exp, pos)) = trSubscriptVar(var, exp, pos)


      (* trSimpleVar : Symbol pos -> expty 
       * Performs semantic analysis and IR translation on SimpleVar variables
       *)
      and trSimpleVar(id,pos) = 
            (case Symbol.look(venv, id)
               of NONE => 
                    (ErrorMsg.error pos ("undef variable " ^ Symbol.name(id));
                     {exp = Translate.nilExp(),
                      ty = Types.UNIT})

                | SOME(Env.FunEntry{level,label,formals,result}) => 
                    (ErrorMsg.error pos 
                      (Symbol.name(id) ^ 
                       " is declared as a function, not a var.");
                     {exp = Translate.nilExp(), 
                      ty = Types.UNIT})

                | SOME(Env.VarEntry{access,ty}) => 
                   {exp = Translate.simpleVar(access,lev),
                    ty = actual_ty(ty)})

      (* trFieldVar : Absyn.Var Symbol pos -> expty
       * var := The record variable
       * sym := Which field inside the record to access
       * 
       * Perform semantic analysis and IR translation on FieldVars
       *)
      and trFieldVar(var, sym, pos) =
            let
              val {exp = var_exp, ty = var_ty} = trvar(var)
            in
              case var_ty
                of Types.RECORD(fields, uniq) =>
                    let val fldNames = (map #1 fields)
                        val idx = indexOf(sym, fldNames)
                    in
                      {exp = Translate.fieldVar(var_exp, idx),
                       ty = var_ty}
                    end

                 | Types.NIL => 
                    ((ErrorMsg.error pos 
                      "Cannot access fields inside a nil record");
                     {exp = Translate.nilExp(), ty = Types.NIL})

                 | _ => 
                    ((ErrorMsg.error pos "variable is not a record");
                     {exp = Translate.nilExp(), ty = Types.UNIT})
            end

      (* trSubscriptVar : Absyn.var Absyn.exp pos -> expty
       * var := the array variable
       * exp := the index offset
       *)
      and trSubscriptVar(var, exp, pos) =
            let 
              val expty = trexp exp
              val varexpty = trvar var
            in
              (checkInt(expty, pos);
               {exp = Translate.subscriptVar((#exp varexpty), (#exp expty)),
                ty = (#ty varexpty)})
            end

      (* trOpExp : A.OpExp -> expty
       * Performs semantic analysis and IR transformation of Binary Operators.
       *)
      and trOpExp({left,oper,right,pos}) = 
        let
          (* logic for math operators +,-,*,/ *)
          fun trMathOp() = 
            let val expLeft = trexp left
                val expRight = trexp right
            in
              (checkInt(expLeft, pos);
               checkInt(expRight, pos);
               {exp = Translate.opExp(#exp expLeft, oper, #exp expRight), 
                ty = Types.INT})
            end

          (* logic for conditional operator >,<,>=,<= *)
          fun trCondOp() = 
            let val expLeft = trexp left
                val expRight = trexp right
            in
              (checkInt(expLeft, pos);
               checkInt(expRight, pos);
               {exp = Translate.opExp(#exp expLeft, oper, #exp expRight),
                ty = Types.INT})
            end

          (* logic for equality operators =,<> *)
          fun trEqOp() = 
            let
              val expLeft = trexp left
              val expRight = trexp right
            in  
              (canTestEquality(expLeft, pos);
               canTestEquality(expRight, pos);
               checkSameType(expLeft, expRight, pos);
               {exp = Translate.opExp(#exp expLeft, oper, #exp expRight),
                ty = Types.INT})
            end
        in
          (case oper
            of A.EqOp => trEqOp()
             | A.NeqOp => trEqOp()
             | A.PlusOp => trMathOp()
             | A.MinusOp => trMathOp()
             | A.TimesOp => trMathOp()
             | A.DivideOp => trMathOp()
             | _ => trCondOp())         (* A.LE, A.LT, A.GE, A.GT *)
        end
      (* trbreak : int > expty
       * Performs semantic analysis and IR translation on break expressions.
       *)
      and trbreak(pos) = 
            (if !breakLevel = 0 
             then (ErrorMsg.error pos "break outside of while or for loop ")
             else ();
            
             {exp = Translate.breakExp(break),
              ty = Types.UNIT})

      (* trif : A.exp A.exp (A.exp option) pos -> expty
       * Performs semantic analysis and IR translation on IF statements.
       * The test branch of an if stmt must have type INT. Single-branch
       * if stmts return unit, but double-branch if stmts return a value, 
       * of the type of both the then and else branches, which must be
       * the same type.
       *)
      and trif({test, then', else', pos}) =
        let 
          val trtest = trexp test
          val trthen = trexp then'
        in 
          case else'
            of NONE =>
                (checkInt(trtest, pos);
                 checkUnit(trthen, pos);
                 {exp = Translate.ifExp(
                          (#exp trtest), (#exp trthen), NONE),
                  ty = Types.UNIT})
             | SOME(else_exp) => 
                 let val trelse = trexp else_exp
                 in (checkInt(trexp test, pos);
                     checkSameType(trthen, trelse, pos);
                     {exp = Translate.ifExp(
                              (#exp trtest), (#exp trthen), SOME(#exp trelse)),
                      ty = (#ty trthen)})
                 end
        end

      (* trwhile : {exp, exp, pos} -> expty
       * Performs semantic analysis and IR translation on While Expressions.
       * For while expressions, the test expressions must have type int,
       * and the body must have type unit. 
       * Additionally, the while expression has to recursive translate its body
       * such that it increments the break level.
       *)
      and trwhile({test,body,pos}) = 
        let
          val newBreak = Temp.newlabel()
          val test_expty = trexp test
          val body_expty = transExp(venv, tenv, lev, newBreak)(body)
        in
          (checkInt(test_expty, pos);
           incrementBreakLevel();
           checkUnit(body_expty, pos);
           decrementBreakLevel();
           {exp = Translate.whileExp((#exp test_expty), 
                    (#exp body_expty), newBreak),
            ty = Types.UNIT})
        end

      (* trfor : Symbol (bool ref) exp exp exp pos -> expty
       * Performs semantic analysis and IR translation on For expressions. 
       * Ensures that the low and high expressions both evaluate to int,
       * and that the body evaluates to type unit. Additionally, sets the
       * break level appropriately.
       *)
      and trfor({var=name, escape, lo, hi, body, pos}) = 
        let
          val done = Temp.newlabel()
          val {exp=lo_exp, ty=lo_ty} = trexp lo
          val {exp=hi_exp, ty=hi_ty} = trexp hi
          val {exp=body_exp, ty=body_ty} =
            transExp(S.enter(venv, name,
                             Env.VarEntry(
                               {access = Translate.allocLocal(lev)(!escape),
                                ty = Types.INT})),
                    tenv, lev, done)(body)
        in
          (checkInt({exp=lo_exp, ty=lo_ty}, pos);
           checkInt({exp=hi_exp, ty=hi_ty}, pos);
           incrementBreakLevel();
           checkUnit({exp=body_exp, ty=body_ty}, pos);
           decrementBreakLevel();
           {exp=Translate.forExp(lo_exp, hi_exp, body_exp, done), ty=Types.UNIT})
        end

      (* trseq : (exp*pos) list -> expty
       * Performs semantic analysis and IR translation on Sequence Expressions
       *)
      and trseq(exprs) = 
        if not(List.null(exprs))
        then
          let
            (* extract exps from (exp*pos) tuples *)
            val (expList, posList) = ListPair.unzip exprs
            (* map over the list, trexping each exp *)
            val trexperedList = (map (fn (exp) => trexp exp) expList)
            (* extract exps from the exptys returned by the trexping*)
            val seqExps = (map (fn {exp, ty} => exp) trexperedList)
          in 
            {exp = Translate.seqExp(seqExps), 
             ty = (#ty (List.last(trexperedList)))}
          end
        else
            {exp = Translate.seqExp([]), 
             ty = Types.UNIT}

      (* trfun : {func, args, pos} -> expty
       * Performs semantic analysis and IR translation on Function Calls
       *)
      and trfun({func, args, pos}) = 
            let
              (* translated args; this is built up in matchArgs *)
              val tr_args = ref [] : Translate.exp list ref

              (* matchArgs : (Types.ty list) (A.exp list) int -> unit
               * Ensures that argument expressions (a) match the type of the
               * argument it is given for, and (b) there are the correct number
               * of arguments
               *)
              fun matchArgs(formals, arg_exps, pos) = 
              let 
                fun matchArg(formal_ty, exp) = 
                  let 
                    val {exp,ty} = (trexp exp)
                  in 
                    (tr_args := exp::(!tr_args);
                     if (formal_ty = ty)
                     then ()
                     else (ErrorMsg.error pos "argument is incorrect type"))
                  end
              in
                if (length(formals) = length(arg_exps))
                then 
                  ((map matchArg (ListPair.zip(formals, arg_exps))); ())
                else (ErrorMsg.error pos 
                        ("Wrong number of arguments to " ^ Symbol.name(func) ^ 
                         ". want " ^ Int.toString(length(formals)) ^ 
                         ", got " ^ Int.toString(length(arg_exps))))
              end
            in
              (case Symbol.look(venv, func)
                of NONE => 
                    (ErrorMsg.error pos ("undefined function " ^ 
                        Symbol.name(func));
                     {exp = Translate.nilExp(), 
                      ty = Types.UNIT})

                 | SOME(Env.VarEntry{access,ty}) => 
                    (ErrorMsg.error pos (Symbol.name(func) ^ 
                          " is a variable, not a function.");
                      {exp = Translate.nilExp(), 
                       ty = Types.UNIT})

                 | SOME(Env.FunEntry({level,label,formals,result})) =>
                     (matchArgs(formals, args, pos); 
                      {exp = Translate.funcall(func, level, label, !tr_args),
                       ty = actual_ty(result)}))
            end
     in
      trexp
    end


  (* transProg : Absyn.exp -> Translate.frag list
   * The entry point for the Semantic Analysis and IR construction.
   *)
  (* GIANT TODO: INCORPORATE FINDESCAPE *)
  fun transProg(prog) = (transExp(Env.base_venv, Env.base_tenv,
                                 Translate.outermost, 
                                 Temp.newlabel())
                            (prog))
end

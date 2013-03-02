structure A = Absyn

signature SEMANT =
sig
  type venv
  type tenv

  val transVar: venv * tenv * A.var -> Translate.expty
  val transExp: venv * tenv * A.exp -> Translate.expty
  val transDec: venv * tenv * A.dec -> {venv: venv, tenv: tenv}
  val transTy:         tenv * A.ty  -> Types.ty

  val transProg : A.exp -> unit 
end

structure Semant =
struct
  type venv = Env.enventry S.table
  type tenv = Types.ty S.table

  fun typeToS(Types.NIL) = "nil"
    | typeToS(Types.INT) = "int"
    | typeToS(Types.STRING) = "string"
    | typeToS(Types.UNIT) = "unit"
    | typeToS(Types.NAME(sym, typOpt)) = "Name " ^ Symbol.name(sym)
    | typeToS(Types.ARRAY(typ, uniq)) = "Array of " ^ typeToS(typ)
    | typeToS(Types.RECORD(flds, uniq)) = "Record " 
         List.foldl(op ^) 

  fun recordTyFields(

  fun checkInt({exp,ty}, pos) = 
    case ty of Types.INT => ()
            |  _         => ErrorMsg.error pos "expr must be of type int"

  fun checkUnit({exp,ty}, pos) = 
    case ty of Types.UNIT => ()
             | _          => ErrorMsg.error pos "expr must be of type unit"

  fun checkSame({exp=exp1,ty=ty1}, {exp=exp2,ty=ty2}, pos) = 
    if ty1 = ty2
    then ()
    else ErrorMsg.error pos ("Exprs must be of the same type. " ^
            "Exp1 is " ^ typeToS(ty1) ^ ", " ^
            "Exp2 is " ^ typeToS(ty2))

  fun actual_ty(ty) =
    case ty
      of Types.NIL => Types.NIL
       | Types.INT => Types.INT
       | Types.STRING => Types.STRING
       | Types.UNIT => Types.UNIT
       | Types.NAME(sym, typOpt) => 
           (case !typOpt
            of NONE => Types.UNIT
             | SOME(typ) => actual_ty(typ))
       | Types.RECORD(recs, uniq) => Types.RECORD(recs, uniq)
       | Types.ARRAY(typ, uniq) => actual_ty(typ)

  fun transTy(tenv, A.NameTy(sym, pos)) = 
        (case Symbol.look(tenv, sym)
          of NONE => (ErrorMsg.error pos ("Type " ^ Symbol.name(sym) ^ 
                        " is not defined."); Types.UNIT)
           | SOME(typ) => Types.NAME(sym, ref(SOME(typ))))
    | transTy(tenv, A.RecordTy(fields)) =
         Types.RECORD(collateRecfields(tenv, fields), ref ())
  and collateRecfields(tenv, []) = []
    | collateRecfields(tenv, {name, escape, typ, pos}::fields) =
        case Symbol.look(tenv, typ)
          of NONE => (ErrorMsg.error pos ("Type " ^ Symbol.name(typ) ^ 
                                          " is not defined.");
                     (name, Types.UNIT)::collateRecfields(tenv, fields))
           | SOME(ty) =>
              (name, ty)::collateRecfields(tenv, fields)
    (*
    | transTy(tenv, A.ArrayTy(sym, pos)) = 
    *)


  fun transDecs(venv, tenv, []) = {venv = venv, tenv = tenv}
    | transDecs(venv, tenv, dec::rst) = 
      let val {tenv=tenv', venv=venv'} = transDec(venv, tenv, dec)
      in transDecs(venv', tenv', rst)
      end

  (* TODO: VarDec does not support records *) 
  and transDec(venv, tenv, A.VarDec{name, typ=NONE, init, pos, escape}) =
      let val {exp, ty} = transExp(venv, tenv) init
      in {tenv = tenv,
          venv = S.enter(venv, name, Env.VarEntry{ty=ty})}
      end 
    | transDec(venv, tenv, A.VarDec{name, typ=SOME(styp), init, pos, escape}) =
      let 
        val {exp, ty} = transExp(venv, tenv) init
        val (sym, pos1) = styp
        val dectyp = (case Symbol.look(tenv, sym)
                        of NONE => (ErrorMsg.error pos "no such type";
                                    Types.UNIT)
                         | SOME(ty) => actual_ty(ty))
      in if dectyp = ty 
         then {tenv = tenv, 
               venv = S.enter(venv, name, Env.VarEntry{ty=ty})}
         else (ErrorMsg.error pos ("var init expr evals to incorrect type. " ^
                  "Want: " ^ typeToS(dectyp) ^ ", Have: " ^ typeToS(ty));
              {tenv = tenv, 
               venv = S.enter(venv, name, Env.VarEntry{ty=dectyp})})
      end
    | transDec(venv, tenv, A.TypeDec([])) = {tenv = tenv, venv = venv}
    | transDec(venv, tenv, A.TypeDec[{name,ty,pos}]) = 
        {tenv = S.enter(tenv, name, transTy(tenv,ty)),
         venv = venv}
    | transDec(venv, tenv, A.TypeDec({name, ty, pos}::typs)) = 
        transDec(venv, S.enter(tenv, name, transTy(tenv, ty)), A.TypeDec(typs))
    | transDec(venv, tenv, A.FunctionDec([])) = {tenv = tenv, venv = venv}
    | transDec(venv, tenv, 
        A.FunctionDec({name,params,result=NONE,body,pos}::restfun)) = 
        let fun transParam {name,escape,typ,pos} = 
              case S.look(tenv, typ)
                of NONE => (ErrorMsg.error pos ("undeclared type identifier " ^
                            Symbol.name(typ));
                            {name=name, ty=Types.UNIT})
                 | SOME t => {name=name, ty=t}
            val params' = map transParam params
            val venv' = S.enter(venv, name, 
                                Env.FunEntry{formals = map #ty params', 
                                             result = Types.UNIT})
            fun enterParam({name, ty}, venv) = S.enter(venv, name,
                                                       Env.VarEntry{ty=ty})
            val venv'' = (List.foldl enterParam) venv' params'
            val {exp, ty} = transExp(venv'', tenv) body
        in
          if (ty = Types.UNIT)
          then transDec(venv', tenv, A.FunctionDec(restfun))
          else (ErrorMsg.error pos "procedure cannot return a value.";
                transDec(venv', tenv, A.FunctionDec(restfun)))
        end
    | transDec(venv, tenv, 
        A.FunctionDec({name,params,result=SOME(rt,rpos),body,pos}::restfun)) = 
        let val result_ty = 
              case S.look(tenv, rt)
                of NONE => (ErrorMsg.error pos ("undeclared type identifier " ^
                            Symbol.name(rt));
                            Types.UNIT)
                 | SOME(result_ty) => result_ty
            fun transParam {name,escape,typ,pos} = 
              case S.look(tenv, typ)
                of NONE => (ErrorMsg.error pos ("undeclared type identifier " ^
                            Symbol.name(typ));
                            {name=name, ty=Types.UNIT})
                 | SOME t => {name=name, ty=t}
            val params' = map transParam params
            val venv' = S.enter(venv, name, 
                                Env.FunEntry{formals = map #ty params', 
                                             result = result_ty})
            fun enterParam({name, ty}, venv) = S.enter(venv, name,
                                                       Env.VarEntry{ty=ty})
            val venv'' = (List.foldl enterParam) venv' params'
            val {exp, ty} = transExp(venv'', tenv) body;
        in
          if (ty = result_ty)
          then transDec(venv', tenv, A.FunctionDec(restfun))
          else (ErrorMsg.error pos ("function " ^ Symbol.name(name) ^ 
                  " should return " ^ typeToS(result_ty) ^ " but returns " ^
                  typeToS(ty));
                transDec(venv', tenv, A.FunctionDec(restfun)))
        end

  and transExp(venv, tenv) = 
    let fun trexp(A.OpExp{left, oper=A.PlusOp, right, pos}) = 
              (checkInt(trexp left, pos);
               checkInt(trexp right, pos);
               {exp=(), ty=Types.INT})
          | trexp(A.OpExp{left, oper=A.MinusOp, right, pos}) = 
              (checkInt(trexp left, pos);
               checkInt(trexp right, pos);
               {exp=(), ty=Types.INT})
          | trexp(A.OpExp{left, oper=A.TimesOp, right, pos}) = 
              (checkInt(trexp left, pos);
               checkInt(trexp right, pos);
               {exp=(), ty=Types.INT})
          | trexp(A.OpExp{left, oper=A.DivideOp, right, pos}) = 
              (checkInt(trexp left, pos);
               checkInt(trexp right, pos);
               {exp=(), ty=Types.INT})
          | trexp(A.OpExp{left, oper=A.EqOp, right, pos}) = 
              (checkInt(trexp left, pos);
               checkInt(trexp right, pos);
               {exp=(), ty=Types.INT})
          | trexp(A.OpExp{left, oper=A.NeqOp, right, pos}) = 
              (checkInt(trexp left, pos);
               checkInt(trexp right, pos);
               {exp=(), ty=Types.INT})
          | trexp(A.OpExp{left, oper=A.LtOp, right, pos}) = 
              (checkInt(trexp left, pos);
               checkInt(trexp right, pos);
               {exp=(), ty=Types.INT})
          | trexp(A.OpExp{left, oper=A.LeOp, right, pos}) = 
              (checkInt(trexp left, pos);
               checkInt(trexp right, pos);
               {exp=(), ty=Types.INT})
          | trexp(A.OpExp{left, oper=A.GtOp, right, pos}) = 
              (checkInt(trexp left, pos);
               checkInt(trexp right, pos);
               {exp=(), ty=Types.INT})
          | trexp(A.OpExp{left, oper=A.GeOp, right, pos}) = 
              (checkInt(trexp left, pos);
               checkInt(trexp right, pos);
               {exp=(), ty=Types.INT})
          | trexp(A.IntExp(n)) = {exp=(), ty=Types.INT}
          | trexp(A.NilExp) = {exp=(), ty=Types.NIL}
          | trexp(A.BreakExp(pos)) = {exp=(), ty=Types.UNIT}
                            (* TODO only valid inside while and for expressions*)
          | trexp(A.StringExp(str)) = {exp=(), ty=Types.STRING}
          | trexp(A.SeqExp(exprs)) = 
              let fun checkSeq [] = {exp=(), ty=Types.UNIT}
                    | checkSeq ((exp, pos)::nil) = trexp exp
                    | checkSeq ((exp, pos)::rst) = (trexp exp; checkSeq rst)
              in checkSeq(exprs) 
              end
          | trexp(A.VarExp(var)) = trvar var
          | trexp(A.CallExp{func,args,pos}) = trfun(func,args,pos)
          | trexp(A.LetExp{decs, body, pos}) = 
              let val {venv=venv', tenv=tenv'} = transDecs(venv, tenv, decs)
              in transExp(venv', tenv') body
              end
          | trexp(A.WhileExp{test,body,pos}) = 
                (checkInt(trexp test, pos);
                 checkUnit(trexp body, pos);
                 {exp=(), ty=Types.UNIT})
          | trexp(A.ForExp{var=name, escape, lo, hi, body, pos}) =
                (checkInt(trexp lo, pos);
                 checkInt(trexp hi, pos);
                 checkUnit(transExp(S.enter(venv, name,
                                            Env.VarEntry{ty=Types.INT}),
                                    tenv) body,
                           pos);
                 {exp=(), ty=Types.UNIT})
          | trexp(A.RecordExp{fields, typ, pos}) =
              {exp=(), ty=Types.RECORD(trrecfields fields, ref ())}
          | trexp(A.IfExp{test, then', else', pos}) = 
              case else'
                of NONE => (checkInt(trexp test, pos); 
                            checkUnit(trexp then', pos);
                            {exp=(), ty=Types.UNIT})
                 | SOME(else_exp) => 
                     let val then_ty = trexp then'
                         val else_ty = trexp else_exp
                     in
                        (checkInt(trexp test, pos);
                         checkSame(then_ty, else_ty, pos);
                         then_ty)
                     end
          (* TODO Array and record creation. Assignment.
          | trexp(A.ArrayExp{typ, size, init, pos}) =
          | trexp(A.AssignExp{var, exp, pos}) =
          *)
      and trvar (A.SimpleVar(id, pos)) = 
              (case Symbol.look(venv, id)
                of SOME(Env.VarEntry {ty}) => {exp=(), ty=actual_ty(ty)}
                 | NONE => (ErrorMsg.error pos ("undefined variable " ^ 
                                                 Symbol.name(id));
                                                 {exp=(), ty=Types.INT}))
          (* TODO fieldVar and subscriptVar
        | trvar(A.FieldVar(var, symbol, pos)) = 
              let
                val {exp=expvar, ty=varty} = travar(var)
              in
                (case Symbol.look(venv, symbol)
                  of SOME(Env.VarEntry {ty}) => {exp=(), ty=actual_ty(ty)}
                  | NONE => (ErrorMsg.error pos ("undefined variable " ^ 
                                                   Symbol.name(id));
                                                   {exp=(), ty=Types.INT}))
              end
        | trvar(A.SubscriptVar(var, exp, pos)) =
          *)
      and trrecfields([]) = []
        | trrecfields((sym, exp, pos)::rest) =
          let val {exp, ty=typ} = trexp exp 
          in  (sym, typ)::trrecfields(rest)
          end

      and trfun (func, args, pos) = 
            let 
              fun matchArgs([], [], pos) = ()
                | matchArgs([], args, pos) = ErrorMsg.error pos "too many args"
                | matchArgs(formals, [], pos) = ErrorMsg.error pos "not enough args"
                | matchArgs(formal::formals, arg::args, pos) = 
                  (let val {exp, ty} = trexp arg
                   in if formal = ty
                      then ()
                      else ErrorMsg.error pos "argument is incorrect type"
                   end;
                   matchArgs(formals, args, pos))
            in
              (case Symbol.look(venv, func)
                of NONE => (ErrorMsg.error pos ("undefined function " ^
                                                Symbol.name(func));
                            {exp=(), ty=Types.UNIT})
                 | SOME(Env.FunEntry {formals, result}) =>
                     (matchArgs(formals, args, pos); {exp=(), ty=actual_ty(result)}))
            end
   in
      trexp
    end
 


  fun transProg(prog) = (transExp(Env.base_venv, Env.base_tenv)(prog))
end

structure FindEscape:
sig val findEscape: Absyn.exp -> unit end =
struct
  type depth = int
  type escEnv = (depth * bool ref) Symbol.table

  val baseDepth : depth = 0
  val baseEscEnv : escEnv = Symbol.empty

  (* traverseVar : escEnv depth Absyn.var -> unit
   * Given a AST variable reference, s, traverses the tree and 
   * calculates the escapes for required nodes. This function
   * mutates the escape ref inside each AST node, and so returns
   * unit but causes side-effects.
   *)
  fun traverseVar(env:escEnv, d:depth, s:Absyn.var):unit =
    case s
      of A.SimpleVar(sym, pos) => 
          (case S.look(env,sym)
            of NONE => (ErrorMsg.error pos ("Undeclared variable" ^
                          Symbol.name(sym)))

             | SOME(depth,esc) => if d > depth 
                                  then esc := true
                                  else ())

       | A.FieldVar(var,sym,pos) => 
           ((case S.look(env,sym) 
             of NONE => (ErrorMsg.error pos ("Undeclared variable" ^
                          Symbol.name(sym)))

           
              | SOME(depth,esc) => if d > depth 
                                   then esc := true
                                   else ()); 
            traverseVar(env, d, var))

       | A.SubscriptVar(var,exp,pos) => 
           (traverseVar(env, d, var); traverseExp(env, d, exp))

  (* traverseExp : escEnv depth Absyn.exp -> unit
   * Given an AST expression, s, walks the expression and calculates the
   * appropriate escapes for each node. This function causes side effects
   * by setting the escape ref inside applicable nodes, and is mutually
   * recursive with traverseVar and traverseDecs.
   *)
  and traverseExp(env:escEnv, d:depth, s:Absyn.exp):unit =
    case s
      of A.CallExp{func,args,pos} =>
          (map (fn arg => traverseExp(env,d,arg)) args; ())

       | A.VarExp(var) => traverseVar(env, d, var)
       
       | A.OpExp{left,oper,right,pos} => 
           (traverseExp(env,d,left); traverseExp(env,d,right))

       | A.RecordExp{fields,typ,pos} =>
           (map (fn (sym,exp,pos) => traverseExp(env,d,exp)) fields; ())

       | A.SeqExp(exprs) => 
           (map (fn (exp,pos) => traverseExp(env,d,exp)) exprs; ())

       | A.AssignExp{var,exp,pos} => 
           (traverseVar(env,d,var); traverseExp(env,d,exp))

       | A.IfExp{test,then',else',pos} => 
           (case else' 
              of NONE => 
                   (traverseExp(env,d,test); traverseExp(env,d,then'))
               | SOME(else_exp) =>
                   (traverseExp(env,d,test); traverseExp(env,d,then');
                    traverseExp(env,d,else_exp)))
       
       | A.WhileExp{test,body,pos} => 
           (traverseExp(env,d,test); traverseExp(env,d,body))
       
       | A.ForExp{var,escape,lo,hi,body,pos} => 
           let val for_env = (escape := false; S.enter(env,var, (d,escape)))
           in traverseExp(for_env, d+1, body)
           end

       | A.LetExp{decs,body,pos} => 
           let val let_env = traverseDecs(env,d,decs)
           in traverseExp(let_env, d+1, body)
           end

       | A.ArrayExp{typ,size,init,pos} =>
            (traverseExp(env,d,size); traverseExp(env,d,init))

       | _ => ()

  (* traverseDecs : escEnv depth [list Absyn.dec] -> escEnv
   * Given a set of AST declarations, walks each declaration and 
   * ...
   *)
  and traverseDecs(env:escEnv, d:depth, s:Absyn.dec list):escEnv =
  let
    (* enterParams : escEnv [list field] -> escEnv
     * Given an environment and a set of fields, enters all of the fields
     * into the environment.
     * This is used when processing the parameters of function declarations
     *)
    fun enterParams(env:escEnv, []) = env
      | enterParams(env:escEnv, {name,escape,typ,pos}::fields) = 
          (escape := false;
           enterParams(S.enter(env, name, (d, escape)), fields))

    (* traverseDec : dec -> escEnv
     * Given a single declaration, dec, enters it into the environment
     * and returns the resulting environment 
     *)
    fun traverseDec(dec:Absyn.dec) = 
      (case dec
        of A.FunctionDec({name,params,result,body,pos}::xs) =>
              (traverseExp(enterParams(env, params), d+1, body);
               env)

          | A.VarDec{name,escape,typ,init,pos} => 
             (escape := false; S.enter(env,name,(d,escape)))
         
          | A.TypeDec({name,ty,pos}::xs) => env 
          
          (* catches empty FunctionDec and TypeDec *)
          | _ => env)
  in
    (* loop over all of the declarations, in order, and enter each into
     * the environment, then return that resulting environment. The 
     * starting environment is env*)
    (case s
      of [] => env
       | dec::decs => traverseDecs(traverseDec(dec), d, decs))
  end


  fun findEscape(prog:Absyn.exp) : unit = 
    traverseExp(baseEscEnv, baseDepth, prog)

end


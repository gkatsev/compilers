structure S = Symbol
structure T = Types

signature ENV = 
sig
  type access
  type ty
  datatype enventry = VarEntry of {ty: ty}
                    | FunEntry of {formals: ty list, result: ty}
  val base_tenv : ty Symbol.table (* predefined types *)
  val base_venv : enventry Symbol.table (* predefined functions *) 
end

structure Env =
struct
  type ty = Types.ty

  datatype enventry = VarEntry of {ty: ty} 
                    | FunEntry of {formals: ty list, result: ty}
                      
  val base_tenv = S.enter(S.enter(
                    S.empty, 
                    S.symbol("string"), T.STRING),
                    S.symbol("int"), T.INT) 
  val base_venv = S.enter(S.enter(S.enter(S.enter(S.enter(
                  S.enter(S.enter(S.enter(S.enter(S.enter(
                  S.enter(
                  S.empty,
                  S.symbol("testvar"), VarEntry {ty = T.STRING}),
                  S.symbol("print"),
                  FunEntry {formals = [T.STRING], result = T.UNIT}),
                  S.symbol("getchar"),
                  FunEntry {formals = [], result = T.STRING}),
                  S.symbol("flush"),
                  FunEntry {formals = [], result = T.UNIT}),
                  S.symbol("ord"),
                  FunEntry {formals = [T.STRING], result = T.INT}),
                  S.symbol("chr"),
                  FunEntry {formals = [T.INT], result = T.STRING}),
                  S.symbol("size"),
                  FunEntry {formals = [T.STRING], result = T.INT}),
                  S.symbol("substring"),
                  FunEntry {formals = [T.STRING, T.INT, T.INT],
                   result = T.STRING}),
                  S.symbol("concat"),
                  FunEntry {formals = [T.STRING, T.STRING], result = T.STRING}),
                  S.symbol("not"),
                  FunEntry {formals = [T.INT], result = T.INT}),
                  S.symbol("exit"),
                  FunEntry {formals = [T.INT], result = T.UNIT})
end

structure S = Symbol
structure T = Types

signature ENV = 
sig
  type ty
  datatype enventry = VarEntry of {access: Translate.access, ty: ty}
                    | FunEntry of {level: Translate.level,
                                   label: Temp.label,
                                   formals: ty list, result: ty}
  val base_tenv : ty Symbol.table (* predefined types *)
  val base_venv : enventry Symbol.table (* predefined functions *) 
end

structure Env =
struct
  type ty = Types.ty

  datatype enventry = VarEntry of {access: Translate.access, ty: ty} 
                    | FunEntry of {level: Translate.level,
                                   label: Temp.label,
                                   formals: ty list, result: ty}

  val base_tenv = S.enter(S.enter(
                    S.empty, 
                    S.symbol("string"), T.STRING),
                    S.symbol("int"), T.INT) 
  val base_venv = S.enter(S.enter(S.enter(S.enter(S.enter(
                  S.enter(S.enter(S.enter(S.enter(S.enter(
                  S.empty,
                  S.symbol("print"),
                  FunEntry {formals = [T.STRING], result = T.UNIT,
                            level = Translate.outermost, 
                            label = Temp.newlabel()}),
                  S.symbol("getchar"),
                  FunEntry {formals = [], result = T.STRING,
                            level = Translate.outermost, 
                            label = Temp.newlabel()}),
                  S.symbol("flush"),
                  FunEntry {formals = [], result = T.UNIT,
                            level = Translate.outermost, 
                            label = Temp.newlabel()}),
                  S.symbol("ord"),
                  FunEntry {formals = [T.STRING], result = T.INT,
                            level = Translate.outermost, 
                            label = Temp.newlabel()}),
                  S.symbol("chr"),
                  FunEntry {formals = [T.INT], result = T.STRING, 
                            level = Translate.outermost, 
                            label = Temp.newlabel()}),
                  S.symbol("size"),
                  FunEntry {formals = [T.STRING], result = T.INT,
                            level = Translate.outermost, 
                            label = Temp.newlabel()}),
                  S.symbol("substring"),
                  FunEntry {formals = [T.STRING, T.INT, T.INT], 
                            result = T.STRING,
                            level = Translate.outermost, 
                            label = Temp.newlabel()}),
                  S.symbol("concat"),
                  FunEntry {formals = [T.STRING, T.STRING], result = T.STRING,
                            level = Translate.outermost, 
                            label = Temp.newlabel()}),
                  S.symbol("not"),
                  FunEntry {formals = [T.INT], result = T.INT,
                            level = Translate.outermost, 
                            label = Temp.newlabel()}),
                  S.symbol("exit"),
                  FunEntry {formals = [T.INT], result = T.UNIT,
                            level = Translate.outermost, 
                            label = Temp.newlabel()})
end

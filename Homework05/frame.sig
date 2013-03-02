signature FRAME =
sig type frame
    type access
    datatype frag = PROC of {body: Tree.stm, frame: frame}
                  | STRING of Temp.label * string
    val FP : Temp.temp
    val RV : Temp.temp
    val exp : access -> Tree.exp -> Tree.exp
    val wordSize : int
    val newFrame : {name: Temp.label,
                    formals: bool list} -> frame
    val name : frame -> Temp.label
    val formals : frame -> access list
    val allocLocal : frame -> bool -> access
    val procEntryExit1 : frame * Tree.stm -> Tree.stm
    val procEntryExit2 : frame * Assem.instr list -> Assem.instr list
    val procEntryExit3 : frame * Assem.instr list -> 
            {prolog: string, body: Assem.instr list, epilog: string}
    val calldefs : Temp.temp list

    type register
    val tempMap : register Temp.Table.table

    val string : (Temp.label * string) -> string

    val staticlink : frame -> int
    val callExternal : string * Tree.exp list -> Tree.exp
end


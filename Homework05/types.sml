structure Types =
struct

  (* unit ref is basically a pointer to nowhere. However, each time a new RECORD
  * is initialized, the unique field points to a different nothing each time.
  * So, when doing record or array comparison, if you compare the unique fields
  * of the two vars, they will point to the same nothing if they are exactly the
  * same var, otherwise their unique fields will be different pointers and so
  * not equal
  *)
  type unique = unit ref

  datatype ty = 
            RECORD of (Symbol.symbol * ty) list * unique
          | NIL
          | INT
          | STRING
          | ARRAY of ty * unique
      	  | NAME of Symbol.symbol * ty option ref
      	  | UNIT
 
 (* recordTypeFields : [list (Symbol, Types.ty)] -> String
  * Given a list of Symbol and Type pairs, contatenates all of the
  * symbol names, separated by spaces.
  *
  * This is used by typeToS to write out the types of each record field *)
 fun recordTypeFields([]) = ""
   | recordTypeFields((sym, ty)::fields) = 
       Symbol.name(sym) ^ " " ^ recordTypeFields(fields)


  (* typeToS : Types.ty -> String
   * Given a Types.ty, returns its string representation.
   * Used for error reporting. *)
  fun toS(NIL) = "nil"
    | toS(INT) = "int"
    | toS(STRING) = "string"
    | toS(UNIT) = "unit"
    | toS(NAME(sym, typOpt)) = "Name " ^ Symbol.name(sym)
    | toS(ARRAY(typ, uniq)) = "Array of " ^ toS(typ)
    | toS(RECORD(flds, uniq)) = "Record " ^ recordTypeFields(flds)


end


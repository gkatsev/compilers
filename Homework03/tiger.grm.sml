functor TigerLrValsFun(structure Token : TOKEN)
 : sig structure ParserData : PARSER_DATA
       structure Tokens : Tiger_TOKENS
   end
 = 
struct
structure ParserData=
struct
structure Header = 
struct
structure A = Absyn

fun collateDecs(declist) = 
let
  fun collate([], acc) = acc
    | collate(A.VarDec(v)::rst, acc) = collate(rst, acc @ [A.VarDec(v)])
    | collate(A.FunctionDec(f)::rst, acc) = collateFuns(A.FunctionDec(f)::rst, [], acc)
    | collate(A.TypeDec(t)::rst, acc) = collateTypes(A.TypeDec(t)::rst, [], acc)

  and collateFuns([], funlist, acc) = acc @ [A.FunctionDec(funlist)]
    | collateFuns(A.FunctionDec(f)::rst, funlist, acc) = 
        collateFuns(rst, funlist @ f, acc)
    | collateFuns(x::rst, funlist, acc) = 
        collate(x::rst, acc @ [A.FunctionDec(funlist)])

  and collateTypes([], typelist, acc) = acc @ [A.TypeDec(typelist)]
    | collateTypes(A.TypeDec(t)::rst, typelist, acc) = 
        collateTypes(rst, typelist @ t, acc)
    | collateTypes(x::rst, typelist, acc) = 
        collate(x::rst, acc @ [A.TypeDec(typelist)])
in
  collate(declist, [])
end


end
structure LrTable = Token.LrTable
structure Token = Token
local open LrTable in 
val table=let val actionRows =
"\
\\001\000\001\000\000\000\000\000\
\\001\000\001\000\149\000\005\000\149\000\007\000\149\000\009\000\149\000\
\\011\000\149\000\013\000\149\000\015\000\030\000\016\000\029\000\
\\017\000\028\000\018\000\027\000\025\000\149\000\026\000\149\000\
\\030\000\149\000\031\000\149\000\034\000\149\000\035\000\149\000\
\\037\000\149\000\038\000\149\000\042\000\149\000\043\000\149\000\
\\044\000\149\000\000\000\
\\001\000\001\000\150\000\005\000\150\000\007\000\150\000\009\000\150\000\
\\011\000\150\000\013\000\150\000\015\000\030\000\016\000\029\000\
\\017\000\028\000\018\000\027\000\025\000\150\000\026\000\150\000\
\\030\000\150\000\031\000\150\000\034\000\150\000\035\000\150\000\
\\037\000\150\000\038\000\150\000\042\000\150\000\043\000\150\000\
\\044\000\150\000\000\000\
\\001\000\001\000\151\000\005\000\151\000\007\000\151\000\009\000\151\000\
\\011\000\151\000\013\000\151\000\015\000\030\000\016\000\029\000\
\\017\000\028\000\018\000\027\000\025\000\151\000\026\000\151\000\
\\030\000\151\000\031\000\151\000\034\000\151\000\035\000\151\000\
\\037\000\151\000\038\000\151\000\042\000\151\000\043\000\151\000\
\\044\000\151\000\000\000\
\\001\000\001\000\152\000\005\000\152\000\007\000\152\000\009\000\152\000\
\\011\000\152\000\013\000\152\000\015\000\030\000\016\000\029\000\
\\017\000\028\000\018\000\027\000\025\000\152\000\026\000\152\000\
\\030\000\152\000\031\000\152\000\034\000\152\000\035\000\152\000\
\\037\000\152\000\038\000\152\000\042\000\152\000\043\000\152\000\
\\044\000\152\000\000\000\
\\001\000\001\000\153\000\005\000\153\000\007\000\153\000\009\000\153\000\
\\011\000\153\000\013\000\153\000\015\000\030\000\016\000\029\000\
\\017\000\028\000\018\000\027\000\025\000\153\000\026\000\153\000\
\\030\000\153\000\031\000\153\000\034\000\153\000\035\000\153\000\
\\037\000\153\000\038\000\153\000\042\000\153\000\043\000\153\000\
\\044\000\153\000\000\000\
\\001\000\001\000\154\000\005\000\154\000\007\000\154\000\009\000\154\000\
\\011\000\154\000\013\000\154\000\015\000\030\000\016\000\029\000\
\\017\000\028\000\018\000\027\000\025\000\154\000\026\000\154\000\
\\030\000\154\000\031\000\154\000\034\000\154\000\035\000\154\000\
\\037\000\154\000\038\000\154\000\042\000\154\000\043\000\154\000\
\\044\000\154\000\000\000\
\\001\000\002\000\015\000\003\000\014\000\004\000\013\000\008\000\012\000\
\\016\000\011\000\029\000\010\000\032\000\009\000\033\000\008\000\
\\036\000\007\000\040\000\006\000\041\000\005\000\000\000\
\\001\000\002\000\039\000\000\000\
\\001\000\002\000\049\000\000\000\
\\001\000\002\000\065\000\000\000\
\\001\000\002\000\066\000\000\000\
\\001\000\002\000\067\000\000\000\
\\001\000\002\000\098\000\012\000\097\000\028\000\096\000\000\000\
\\001\000\002\000\100\000\000\000\
\\001\000\002\000\103\000\000\000\
\\001\000\002\000\106\000\000\000\
\\001\000\002\000\120\000\000\000\
\\001\000\002\000\126\000\000\000\
\\001\000\002\000\130\000\000\000\
\\001\000\005\000\089\000\013\000\088\000\000\000\
\\001\000\005\000\093\000\009\000\092\000\000\000\
\\001\000\005\000\114\000\009\000\113\000\000\000\
\\001\000\005\000\114\000\013\000\121\000\000\000\
\\001\000\006\000\082\000\027\000\081\000\000\000\
\\001\000\006\000\115\000\000\000\
\\001\000\006\000\124\000\019\000\123\000\000\000\
\\001\000\007\000\072\000\009\000\071\000\000\000\
\\001\000\007\000\072\000\038\000\094\000\000\000\
\\001\000\008\000\083\000\000\000\
\\001\000\011\000\078\000\015\000\030\000\016\000\029\000\017\000\028\000\
\\018\000\027\000\019\000\026\000\020\000\025\000\021\000\024\000\
\\022\000\023\000\023\000\022\000\024\000\021\000\025\000\020\000\
\\026\000\019\000\000\000\
\\001\000\011\000\091\000\015\000\030\000\016\000\029\000\017\000\028\000\
\\018\000\027\000\019\000\026\000\020\000\025\000\021\000\024\000\
\\022\000\023\000\023\000\022\000\024\000\021\000\025\000\020\000\
\\026\000\019\000\000\000\
\\001\000\015\000\030\000\016\000\029\000\017\000\028\000\018\000\027\000\
\\019\000\026\000\020\000\025\000\021\000\024\000\022\000\023\000\
\\023\000\022\000\024\000\021\000\025\000\020\000\026\000\019\000\
\\030\000\070\000\000\000\
\\001\000\015\000\030\000\016\000\029\000\017\000\028\000\018\000\027\000\
\\019\000\026\000\020\000\025\000\021\000\024\000\022\000\023\000\
\\023\000\022\000\024\000\021\000\025\000\020\000\026\000\019\000\
\\034\000\104\000\000\000\
\\001\000\015\000\030\000\016\000\029\000\017\000\028\000\018\000\027\000\
\\019\000\026\000\020\000\025\000\021\000\024\000\022\000\023\000\
\\023\000\022\000\024\000\021\000\025\000\020\000\026\000\019\000\
\\035\000\069\000\000\000\
\\001\000\015\000\030\000\016\000\029\000\017\000\028\000\018\000\027\000\
\\019\000\026\000\020\000\025\000\021\000\024\000\022\000\023\000\
\\023\000\022\000\024\000\021\000\025\000\020\000\026\000\019\000\
\\035\000\127\000\000\000\
\\001\000\019\000\080\000\000\000\
\\001\000\019\000\090\000\000\000\
\\001\000\019\000\118\000\000\000\
\\001\000\019\000\132\000\000\000\
\\001\000\027\000\068\000\000\000\
\\001\000\027\000\112\000\000\000\
\\001\000\037\000\064\000\042\000\038\000\043\000\037\000\044\000\036\000\000\000\
\\001\000\039\000\108\000\000\000\
\\001\000\039\000\110\000\000\000\
\\001\000\042\000\038\000\043\000\037\000\044\000\036\000\000\000\
\\135\000\015\000\030\000\016\000\029\000\017\000\028\000\018\000\027\000\
\\019\000\026\000\020\000\025\000\021\000\024\000\022\000\023\000\
\\023\000\022\000\024\000\021\000\025\000\020\000\026\000\019\000\000\000\
\\136\000\000\000\
\\137\000\000\000\
\\138\000\000\000\
\\139\000\015\000\030\000\016\000\029\000\017\000\028\000\018\000\027\000\
\\019\000\026\000\020\000\025\000\021\000\024\000\022\000\023\000\
\\023\000\022\000\024\000\021\000\025\000\020\000\026\000\019\000\000\000\
\\140\000\000\000\
\\141\000\010\000\018\000\014\000\017\000\027\000\016\000\000\000\
\\142\000\015\000\030\000\016\000\029\000\017\000\028\000\018\000\027\000\
\\019\000\026\000\020\000\025\000\021\000\024\000\022\000\023\000\
\\023\000\022\000\024\000\021\000\025\000\020\000\026\000\019\000\000\000\
\\143\000\000\000\
\\144\000\000\000\
\\145\000\017\000\028\000\018\000\027\000\000\000\
\\146\000\017\000\028\000\018\000\027\000\000\000\
\\147\000\000\000\
\\148\000\000\000\
\\155\000\015\000\030\000\016\000\029\000\017\000\028\000\018\000\027\000\
\\019\000\026\000\020\000\025\000\021\000\024\000\022\000\023\000\
\\023\000\022\000\024\000\021\000\000\000\
\\156\000\015\000\030\000\016\000\029\000\017\000\028\000\018\000\027\000\
\\019\000\026\000\020\000\025\000\021\000\024\000\022\000\023\000\
\\023\000\022\000\024\000\021\000\025\000\020\000\000\000\
\\157\000\000\000\
\\158\000\015\000\030\000\016\000\029\000\017\000\028\000\018\000\027\000\
\\019\000\026\000\020\000\025\000\021\000\024\000\022\000\023\000\
\\023\000\022\000\024\000\021\000\025\000\020\000\026\000\019\000\
\\031\000\105\000\000\000\
\\159\000\015\000\030\000\016\000\029\000\017\000\028\000\018\000\027\000\
\\019\000\026\000\020\000\025\000\021\000\024\000\022\000\023\000\
\\023\000\022\000\024\000\021\000\025\000\020\000\026\000\019\000\000\000\
\\160\000\015\000\030\000\016\000\029\000\017\000\028\000\018\000\027\000\
\\019\000\026\000\020\000\025\000\021\000\024\000\022\000\023\000\
\\023\000\022\000\024\000\021\000\025\000\020\000\026\000\019\000\000\000\
\\161\000\015\000\030\000\016\000\029\000\017\000\028\000\018\000\027\000\
\\019\000\026\000\020\000\025\000\021\000\024\000\022\000\023\000\
\\023\000\022\000\024\000\021\000\025\000\020\000\026\000\019\000\000\000\
\\162\000\000\000\
\\163\000\000\000\
\\164\000\002\000\015\000\003\000\014\000\004\000\013\000\008\000\012\000\
\\016\000\011\000\029\000\010\000\032\000\009\000\033\000\008\000\
\\036\000\007\000\040\000\006\000\041\000\005\000\000\000\
\\165\000\015\000\030\000\016\000\029\000\017\000\028\000\018\000\027\000\
\\019\000\026\000\020\000\025\000\021\000\024\000\022\000\023\000\
\\023\000\022\000\024\000\021\000\025\000\020\000\026\000\019\000\000\000\
\\166\000\015\000\030\000\016\000\029\000\017\000\028\000\018\000\027\000\
\\019\000\026\000\020\000\025\000\021\000\024\000\022\000\023\000\
\\023\000\022\000\024\000\021\000\025\000\020\000\026\000\019\000\000\000\
\\167\000\002\000\015\000\003\000\014\000\004\000\013\000\008\000\012\000\
\\016\000\011\000\029\000\010\000\032\000\009\000\033\000\008\000\
\\036\000\007\000\040\000\006\000\041\000\005\000\000\000\
\\168\000\015\000\030\000\016\000\029\000\017\000\028\000\018\000\027\000\
\\019\000\026\000\020\000\025\000\021\000\024\000\022\000\023\000\
\\023\000\022\000\024\000\021\000\025\000\020\000\026\000\019\000\000\000\
\\169\000\015\000\030\000\016\000\029\000\017\000\028\000\018\000\027\000\
\\019\000\026\000\020\000\025\000\021\000\024\000\022\000\023\000\
\\023\000\022\000\024\000\021\000\025\000\020\000\026\000\019\000\000\000\
\\170\000\002\000\074\000\000\000\
\\171\000\015\000\030\000\016\000\029\000\017\000\028\000\018\000\027\000\
\\019\000\026\000\020\000\025\000\021\000\024\000\022\000\023\000\
\\023\000\022\000\024\000\021\000\025\000\020\000\026\000\019\000\000\000\
\\172\000\015\000\030\000\016\000\029\000\017\000\028\000\018\000\027\000\
\\019\000\026\000\020\000\025\000\021\000\024\000\022\000\023\000\
\\023\000\022\000\024\000\021\000\025\000\020\000\026\000\019\000\000\000\
\\173\000\000\000\
\\174\000\000\000\
\\175\000\000\000\
\\176\000\000\000\
\\177\000\000\000\
\\178\000\000\000\
\\179\000\000\000\
\\180\000\000\000\
\\181\000\000\000\
\\182\000\015\000\030\000\016\000\029\000\017\000\028\000\018\000\027\000\
\\019\000\026\000\020\000\025\000\021\000\024\000\022\000\023\000\
\\023\000\022\000\024\000\021\000\025\000\020\000\026\000\019\000\000\000\
\\183\000\015\000\030\000\016\000\029\000\017\000\028\000\018\000\027\000\
\\019\000\026\000\020\000\025\000\021\000\024\000\022\000\023\000\
\\023\000\022\000\024\000\021\000\025\000\020\000\026\000\019\000\000\000\
\\184\000\015\000\030\000\016\000\029\000\017\000\028\000\018\000\027\000\
\\019\000\026\000\020\000\025\000\021\000\024\000\022\000\023\000\
\\023\000\022\000\024\000\021\000\025\000\020\000\026\000\019\000\000\000\
\\185\000\015\000\030\000\016\000\029\000\017\000\028\000\018\000\027\000\
\\019\000\026\000\020\000\025\000\021\000\024\000\022\000\023\000\
\\023\000\022\000\024\000\021\000\025\000\020\000\026\000\019\000\000\000\
\\186\000\002\000\103\000\000\000\
\\187\000\000\000\
\\188\000\000\000\
\\189\000\000\000\
\\190\000\008\000\047\000\010\000\046\000\012\000\045\000\000\000\
\\191\000\000\000\
\\192\000\000\000\
\"
val actionRowNumbers =
"\007\000\052\000\046\000\047\000\
\\067\000\045\000\008\000\007\000\
\\007\000\007\000\072\000\048\000\
\\049\000\095\000\007\000\009\000\
\\007\000\007\000\007\000\007\000\
\\007\000\007\000\007\000\007\000\
\\007\000\007\000\007\000\007\000\
\\007\000\082\000\081\000\080\000\
\\078\000\042\000\010\000\011\000\
\\012\000\040\000\034\000\032\000\
\\055\000\027\000\073\000\075\000\
\\007\000\069\000\053\000\096\000\
\\030\000\061\000\060\000\006\000\
\\003\000\005\000\004\000\002\000\
\\001\000\059\000\058\000\057\000\
\\056\000\079\000\072\000\036\000\
\\024\000\029\000\007\000\007\000\
\\007\000\062\000\007\000\020\000\
\\037\000\031\000\021\000\070\000\
\\097\000\028\000\013\000\007\000\
\\014\000\091\000\033\000\065\000\
\\063\000\074\000\051\000\016\000\
\\007\000\043\000\054\000\007\000\
\\068\000\083\000\044\000\091\000\
\\084\000\089\000\041\000\092\000\
\\022\000\025\000\007\000\007\000\
\\038\000\076\000\007\000\071\000\
\\017\000\023\000\007\000\026\000\
\\015\000\018\000\035\000\064\000\
\\007\000\050\000\086\000\085\000\
\\090\000\007\000\019\000\093\000\
\\094\000\007\000\077\000\087\000\
\\039\000\066\000\007\000\088\000\
\\000\000"
val gotoT =
"\
\\001\000\002\000\002\000\132\000\003\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\007\000\033\000\008\000\032\000\009\000\031\000\010\000\030\000\
\\011\000\029\000\000\000\
\\000\000\
\\001\000\038\000\003\000\001\000\000\000\
\\001\000\039\000\003\000\001\000\000\000\
\\001\000\040\000\003\000\001\000\000\000\
\\001\000\042\000\003\000\001\000\006\000\041\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\001\000\046\000\003\000\001\000\000\000\
\\000\000\
\\001\000\048\000\003\000\001\000\000\000\
\\001\000\049\000\003\000\001\000\000\000\
\\001\000\050\000\003\000\001\000\000\000\
\\001\000\051\000\003\000\001\000\000\000\
\\001\000\052\000\003\000\001\000\000\000\
\\001\000\053\000\003\000\001\000\000\000\
\\001\000\054\000\003\000\001\000\000\000\
\\001\000\055\000\003\000\001\000\000\000\
\\001\000\056\000\003\000\001\000\000\000\
\\001\000\057\000\003\000\001\000\000\000\
\\001\000\058\000\003\000\001\000\000\000\
\\001\000\059\000\003\000\001\000\000\000\
\\001\000\060\000\003\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\008\000\061\000\009\000\031\000\010\000\030\000\011\000\029\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\015\000\071\000\000\000\
\\001\000\073\000\003\000\001\000\000\000\
\\001\000\075\000\003\000\001\000\005\000\074\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\001\000\042\000\003\000\001\000\006\000\077\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\001\000\082\000\003\000\001\000\000\000\
\\001\000\083\000\003\000\001\000\000\000\
\\001\000\084\000\003\000\001\000\000\000\
\\000\000\
\\001\000\085\000\003\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\014\000\093\000\000\000\
\\001\000\097\000\003\000\001\000\000\000\
\\000\000\
\\012\000\100\000\013\000\099\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\001\000\105\000\003\000\001\000\000\000\
\\000\000\
\\000\000\
\\001\000\107\000\003\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\012\000\109\000\013\000\099\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\001\000\114\000\003\000\001\000\000\000\
\\001\000\115\000\003\000\001\000\000\000\
\\000\000\
\\000\000\
\\001\000\117\000\003\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\001\000\120\000\003\000\001\000\000\000\
\\000\000\
\\013\000\123\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\001\000\126\000\003\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\001\000\127\000\003\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\001\000\129\000\003\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\001\000\131\000\003\000\001\000\000\000\
\\000\000\
\\000\000\
\"
val numstates = 133
val numrules = 58
val s = ref "" and index = ref 0
val string_to_int = fn () => 
let val i = !index
in index := i+2; Char.ord(String.sub(!s,i)) + Char.ord(String.sub(!s,i+1)) * 256
end
val string_to_list = fn s' =>
    let val len = String.size s'
        fun f () =
           if !index < len then string_to_int() :: f()
           else nil
   in index := 0; s := s'; f ()
   end
val string_to_pairlist = fn (conv_key,conv_entry) =>
     let fun f () =
         case string_to_int()
         of 0 => EMPTY
          | n => PAIR(conv_key (n-1),conv_entry (string_to_int()),f())
     in f
     end
val string_to_pairlist_default = fn (conv_key,conv_entry) =>
    let val conv_row = string_to_pairlist(conv_key,conv_entry)
    in fn () =>
       let val default = conv_entry(string_to_int())
           val row = conv_row()
       in (row,default)
       end
   end
val string_to_table = fn (convert_row,s') =>
    let val len = String.size s'
        fun f ()=
           if !index < len then convert_row() :: f()
           else nil
     in (s := s'; index := 0; f ())
     end
local
  val memo = Array.array(numstates+numrules,ERROR)
  val _ =let fun g i=(Array.update(memo,i,REDUCE(i-numstates)); g(i+1))
       fun f i =
            if i=numstates then g i
            else (Array.update(memo,i,SHIFT (STATE i)); f (i+1))
          in f 0 handle Subscript => ()
          end
in
val entry_to_action = fn 0 => ACCEPT | 1 => ERROR | j => Array.sub(memo,(j-2))
end
val gotoT=Array.fromList(string_to_table(string_to_pairlist(NT,STATE),gotoT))
val actionRows=string_to_table(string_to_pairlist_default(T,entry_to_action),actionRows)
val actionRowNumbers = string_to_list actionRowNumbers
val actionT = let val actionRowLookUp=
let val a=Array.fromList(actionRows) in fn i=>Array.sub(a,i) end
in Array.fromList(map actionRowLookUp actionRowNumbers)
end
in LrTable.mkLrTable {actions=actionT,gotos=gotoT,numRules=numrules,
numStates=numstates,initialState=STATE 0}
end
end
local open Header in
type pos = int
type arg = unit
structure MlyValue = 
struct
datatype svalue = VOID | ntVOID of unit ->  unit
 | STRING of unit ->  (string) | INT of unit ->  (int)
 | ID of unit ->  (string)
 | fieldList of unit ->  ( ( A.symbol * A.exp * int )  list)
 | typeVal of unit ->  (A.ty) | typeField of unit ->  (A.field)
 | typeFieldList of unit ->  (A.field list)
 | typeDec of unit ->  (A.dec) | funDec of unit ->  (A.dec)
 | varDec of unit ->  (A.dec) | declaration of unit ->  (A.dec)
 | decList of unit ->  (A.dec list)
 | exprSeq of unit ->  ( ( A.exp * A.pos )  list)
 | exprList of unit ->  (A.exp list)
 | lvalueFollow of unit ->  (A.var) | lvalue of unit ->  (A.var)
 | program of unit ->  (A.exp) | expr of unit ->  (A.exp)
end
type svalue = MlyValue.svalue
type result = A.exp
end
structure EC=
struct
open LrTable
infix 5 $$
fun x $$ y = y::x
val is_keyword =
fn (T 31) => true | (T 32) => true | (T 33) => true | (T 39) => true
 | (T 35) => true | (T 36) => true | (T 37) => true | (T 41) => true
 | (T 42) => true | (T 43) => true | (T 27) => true | (T 28) => true
 | (T 29) => true | (T 30) => true | (T 34) => true | (T 38) => true
 | (T 40) => true | _ => false
val preferred_change : (term list * term list) list = 
(nil
,nil
 $$ (T 29))::
(nil
,nil
 $$ (T 30))::
(nil
,nil
 $$ (T 7))::
(nil
,nil
 $$ (T 26))::
nil
val noShift = 
fn (T 0) => true | _ => false
val showTerminal =
fn (T 0) => "EOF"
  | (T 1) => "ID"
  | (T 2) => "INT"
  | (T 3) => "STRING"
  | (T 4) => "COMMA"
  | (T 5) => "COLON"
  | (T 6) => "SEMICOLON"
  | (T 7) => "LPAREN"
  | (T 8) => "RPAREN"
  | (T 9) => "LBRACK"
  | (T 10) => "RBRACK"
  | (T 11) => "LBRACE"
  | (T 12) => "RBRACE"
  | (T 13) => "DOT"
  | (T 14) => "PLUS"
  | (T 15) => "MINUS"
  | (T 16) => "TIMES"
  | (T 17) => "DIVIDE"
  | (T 18) => "EQ"
  | (T 19) => "NEQ"
  | (T 20) => "LT"
  | (T 21) => "LE"
  | (T 22) => "GT"
  | (T 23) => "GE"
  | (T 24) => "AND"
  | (T 25) => "OR"
  | (T 26) => "ASSIGN"
  | (T 27) => "ARRAY"
  | (T 28) => "IF"
  | (T 29) => "THEN"
  | (T 30) => "ELSE"
  | (T 31) => "WHILE"
  | (T 32) => "FOR"
  | (T 33) => "TO"
  | (T 34) => "DO"
  | (T 35) => "LET"
  | (T 36) => "IN"
  | (T 37) => "END"
  | (T 38) => "OF"
  | (T 39) => "BREAK"
  | (T 40) => "NIL"
  | (T 41) => "FUNCTION"
  | (T 42) => "VAR"
  | (T 43) => "TYPE"
  | _ => "bogus-term"
local open Header in
val errtermvalue=
fn (T 1) => MlyValue.ID(fn () => ("bogus")) | 
(T 2) => MlyValue.INT(fn () => (0)) | 
(T 3) => MlyValue.STRING(fn () => ("")) | 
_ => MlyValue.VOID
end
val terms : term list = nil
 $$ (T 43) $$ (T 42) $$ (T 41) $$ (T 40) $$ (T 39) $$ (T 38) $$ (T 37)
 $$ (T 36) $$ (T 35) $$ (T 34) $$ (T 33) $$ (T 32) $$ (T 31) $$ (T 30)
 $$ (T 29) $$ (T 28) $$ (T 27) $$ (T 26) $$ (T 25) $$ (T 24) $$ (T 23)
 $$ (T 22) $$ (T 21) $$ (T 20) $$ (T 19) $$ (T 18) $$ (T 17) $$ (T 16)
 $$ (T 15) $$ (T 14) $$ (T 13) $$ (T 12) $$ (T 11) $$ (T 10) $$ (T 9)
 $$ (T 8) $$ (T 7) $$ (T 6) $$ (T 5) $$ (T 4) $$ (T 0)end
structure Actions =
struct 
exception mlyAction of int
local open Header in
val actions = 
fn (i392,defaultPos,stack,
    (()):arg) =>
case (i392,stack)
of  ( 0, ( ( _, ( MlyValue.expr expr1, expr1left, expr1right)) :: 
rest671)) => let val  result = MlyValue.program (fn _ => let val  (
expr as expr1) = expr1 ()
 in (expr)
end)
 in ( LrTable.NT 1, ( result, expr1left, expr1right), rest671)
end
|  ( 1, ( ( _, ( _, NIL1left, NIL1right)) :: rest671)) => let val  
result = MlyValue.expr (fn _ => (A.NilExp))
 in ( LrTable.NT 0, ( result, NIL1left, NIL1right), rest671)
end
|  ( 2, ( ( _, ( MlyValue.STRING STRING1, (STRINGleft as STRING1left),
 STRING1right)) :: rest671)) => let val  result = MlyValue.expr (fn _
 => let val  (STRING as STRING1) = STRING1 ()
 in (A.StringExp(STRING, STRINGleft))
end)
 in ( LrTable.NT 0, ( result, STRING1left, STRING1right), rest671)
end
|  ( 3, ( ( _, ( MlyValue.INT INT1, INT1left, INT1right)) :: rest671))
 => let val  result = MlyValue.expr (fn _ => let val  (INT as INT1) = 
INT1 ()
 in (A.IntExp(INT))
end)
 in ( LrTable.NT 0, ( result, INT1left, INT1right), rest671)
end
|  ( 4, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: _ :: ( _
, ( MlyValue.expr expr1, _, _)) :: _ :: ( _, ( MlyValue.ID ID1, (
IDleft as ID1left), _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  (ID as ID1) = ID1 ()
 val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (
A.ArrayExp({typ = Symbol.symbol(ID),
                                                 size = expr1,
                                                 init = expr2,
                                                 pos = IDleft})
)
end)
 in ( LrTable.NT 0, ( result, ID1left, expr2right), rest671)
end
|  ( 5, ( ( _, ( _, _, RBRACE1right)) :: ( _, ( MlyValue.fieldList 
fieldList1, _, _)) :: _ :: ( _, ( MlyValue.ID ID1, (IDleft as ID1left)
, _)) :: rest671)) => let val  result = MlyValue.expr (fn _ => let
 val  (ID as ID1) = ID1 ()
 val  (fieldList as fieldList1) = fieldList1 ()
 in (
A.RecordExp({fields = fieldList,
                                                  typ = Symbol.symbol(ID),
                                                  pos = IDleft})
)
end)
 in ( LrTable.NT 0, ( result, ID1left, RBRACE1right), rest671)
end
|  ( 6, ( ( _, ( MlyValue.lvalue lvalue1, lvalue1left, lvalue1right))
 :: rest671)) => let val  result = MlyValue.expr (fn _ => let val  (
lvalue as lvalue1) = lvalue1 ()
 in (A.VarExp(lvalue))
end)
 in ( LrTable.NT 0, ( result, lvalue1left, lvalue1right), rest671)
end
|  ( 7, ( ( _, ( MlyValue.expr expr1, _, expr1right)) :: _ :: ( _, ( 
MlyValue.lvalue lvalue1, (lvalueleft as lvalue1left), _)) :: rest671))
 => let val  result = MlyValue.expr (fn _ => let val  (lvalue as 
lvalue1) = lvalue1 ()
 val  (expr as expr1) = expr1 ()
 in (
A.AssignExp({var = lvalue, exp = expr,
                                        pos = lvalueleft})
)
end)
 in ( LrTable.NT 0, ( result, lvalue1left, expr1right), rest671)
end
|  ( 8, ( ( _, ( _, _, RPAREN1right)) :: ( _, ( MlyValue.exprList 
exprList1, _, _)) :: _ :: ( _, ( MlyValue.ID ID1, (IDleft as ID1left),
 _)) :: rest671)) => let val  result = MlyValue.expr (fn _ => let val 
 (ID as ID1) = ID1 ()
 val  (exprList as exprList1) = exprList1 ()
 in (
A.CallExp({func = Symbol.symbol(ID),
                                            args = exprList, pos = IDleft})
)
end)
 in ( LrTable.NT 0, ( result, ID1left, RPAREN1right), rest671)
end
|  ( 9, ( ( _, ( MlyValue.expr expr1, _, expr1right)) :: ( _, ( _, (
MINUSleft as MINUS1left), _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  (expr as expr1) = expr1 ()
 in (
A.OpExp({left = A.IntExp(0), oper = A.MinusOp,
                                      right =  expr, pos = MINUSleft})
)
end)
 in ( LrTable.NT 0, ( result, MINUS1left, expr1right), rest671)
end
|  ( 10, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (
A.OpExp({left = expr1, oper = A.PlusOp, 
																		right = expr2, pos = expr1left})
)
end)
 in ( LrTable.NT 0, ( result, expr1left, expr2right), rest671)
end
|  ( 11, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (
A.OpExp({left = expr1, oper = A.MinusOp, 
																		right = expr2, pos = expr1left})
)
end)
 in ( LrTable.NT 0, ( result, expr1left, expr2right), rest671)
end
|  ( 12, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (
A.OpExp({left = expr1, oper = A.TimesOp, 
																		right = expr2, pos = expr1left})
)
end)
 in ( LrTable.NT 0, ( result, expr1left, expr2right), rest671)
end
|  ( 13, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (
A.OpExp({left = expr1, oper = A.DivideOp, 
																		right = expr2, pos = expr1left})
)
end)
 in ( LrTable.NT 0, ( result, expr1left, expr2right), rest671)
end
|  ( 14, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (
A.OpExp({left = expr1, oper = A.EqOp, 
																		right = expr2, pos = expr1left})
)
end)
 in ( LrTable.NT 0, ( result, expr1left, expr2right), rest671)
end
|  ( 15, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (
A.OpExp({left = expr1, oper = A.NeqOp, 
																		right = expr2, pos = expr1left})
)
end)
 in ( LrTable.NT 0, ( result, expr1left, expr2right), rest671)
end
|  ( 16, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (
A.OpExp({left = expr1, oper = A.GtOp,
																		right = expr2, pos = expr1left})
)
end)
 in ( LrTable.NT 0, ( result, expr1left, expr2right), rest671)
end
|  ( 17, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (
A.OpExp({left = expr1, oper = A.LtOp, 
																		right = expr2, pos = expr1left})
)
end)
 in ( LrTable.NT 0, ( result, expr1left, expr2right), rest671)
end
|  ( 18, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (
A.OpExp({left = expr1, oper = A.LeOp, 
																		right = expr2, pos = expr1left})
)
end)
 in ( LrTable.NT 0, ( result, expr1left, expr2right), rest671)
end
|  ( 19, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (
A.OpExp({left = expr1, oper = A.GeOp, 
																		right = expr2, pos = expr1left})
)
end)
 in ( LrTable.NT 0, ( result, expr1left, expr2right), rest671)
end
|  ( 20, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (
A.IfExp({test = expr1, then' = expr2, 
																		else' = SOME(A.IntExp(0)),
                                    pos = expr1left })
)
end)
 in ( LrTable.NT 0, ( result, expr1left, expr2right), rest671)
end
|  ( 21, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, expr1left, _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (
A.IfExp({test = expr1, then' = A.IntExp(1), 
																		else' = SOME(expr2), pos = expr1left})
)
end)
 in ( LrTable.NT 0, ( result, expr1left, expr2right), rest671)
end
|  ( 22, ( ( _, ( _, _, RPAREN1right)) :: ( _, ( MlyValue.exprSeq 
exprSeq1, _, _)) :: ( _, ( _, LPAREN1left, _)) :: rest671)) => let
 val  result = MlyValue.expr (fn _ => let val  (exprSeq as exprSeq1) =
 exprSeq1 ()
 in (A.SeqExp(exprSeq))
end)
 in ( LrTable.NT 0, ( result, LPAREN1left, RPAREN1right), rest671)
end
|  ( 23, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, _, _)) :: ( _, ( _, (IFleft as IF1left), _)) :: 
rest671)) => let val  result = MlyValue.expr (fn _ => let val  expr1 =
 expr1 ()
 val  expr2 = expr2 ()
 in (
A.IfExp({test = expr1, then' = expr2, 
                                          else' = NONE, pos = IFleft})
)
end)
 in ( LrTable.NT 0, ( result, IF1left, expr2right), rest671)
end
|  ( 24, ( ( _, ( MlyValue.expr expr3, _, expr3right)) :: _ :: ( _, ( 
MlyValue.expr expr2, _, _)) :: _ :: ( _, ( MlyValue.expr expr1, _, _))
 :: ( _, ( _, (IFleft as IF1left), _)) :: rest671)) => let val  result
 = MlyValue.expr (fn _ => let val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 val  expr3 = expr3 ()
 in (
A.IfExp({test = expr1, then' = expr2,
                                          else' = SOME(expr3), pos = IFleft})
)
end)
 in ( LrTable.NT 0, ( result, IF1left, expr3right), rest671)
end
|  ( 25, ( ( _, ( MlyValue.expr expr2, _, expr2right)) :: _ :: ( _, ( 
MlyValue.expr expr1, _, _)) :: ( _, ( _, (WHILEleft as WHILE1left), _)
) :: rest671)) => let val  result = MlyValue.expr (fn _ => let val  
expr1 = expr1 ()
 val  expr2 = expr2 ()
 in (
A.WhileExp({test = expr1, body = expr2, 
                                             pos = WHILEleft})
)
end)
 in ( LrTable.NT 0, ( result, WHILE1left, expr2right), rest671)
end
|  ( 26, ( ( _, ( MlyValue.expr expr3, _, expr3right)) :: _ :: ( _, ( 
MlyValue.expr expr2, _, _)) :: _ :: ( _, ( MlyValue.expr expr1, _, _))
 :: _ :: ( _, ( MlyValue.ID ID1, _, _)) :: ( _, ( _, (FORleft as 
FOR1left), _)) :: rest671)) => let val  result = MlyValue.expr (fn _
 => let val  (ID as ID1) = ID1 ()
 val  expr1 = expr1 ()
 val  expr2 = expr2 ()
 val  expr3 = expr3 ()
 in (
A.ForExp({var = Symbol.symbol(ID), 
                                                   escape = ref true,
                                                   lo = expr1, hi = expr2,
                                                   body = expr3, 
                                                   pos = FORleft})
)
end)
 in ( LrTable.NT 0, ( result, FOR1left, expr3right), rest671)
end
|  ( 27, ( ( _, ( _, (BREAKleft as BREAK1left), BREAK1right)) :: 
rest671)) => let val  result = MlyValue.expr (fn _ => (
A.BreakExp(BREAKleft)))
 in ( LrTable.NT 0, ( result, BREAK1left, BREAK1right), rest671)
end
|  ( 28, ( ( _, ( _, _, END1right)) :: ( _, ( MlyValue.exprSeq 
exprSeq1, _, _)) :: _ :: ( _, ( MlyValue.decList decList1, _, _)) :: (
 _, ( _, (LETleft as LET1left), _)) :: rest671)) => let val  result = 
MlyValue.expr (fn _ => let val  (decList as decList1) = decList1 ()
 val  (exprSeq as exprSeq1) = exprSeq1 ()
 in (
A.LetExp({decs = collateDecs(decList), 
                                           body = A.SeqExp(exprSeq),
                                           pos = LETleft})
)
end)
 in ( LrTable.NT 0, ( result, LET1left, END1right), rest671)
end
|  ( 29, ( rest671)) => let val  result = MlyValue.exprList (fn _ => (
[]))
 in ( LrTable.NT 4, ( result, defaultPos, defaultPos), rest671)
end
|  ( 30, ( ( _, ( MlyValue.expr expr1, expr1left, expr1right)) :: 
rest671)) => let val  result = MlyValue.exprList (fn _ => let val  (
expr as expr1) = expr1 ()
 in ([expr])
end)
 in ( LrTable.NT 4, ( result, expr1left, expr1right), rest671)
end
|  ( 31, ( ( _, ( MlyValue.expr expr1, _, expr1right)) :: _ :: ( _, ( 
MlyValue.exprList exprList1, exprList1left, _)) :: rest671)) => let
 val  result = MlyValue.exprList (fn _ => let val  (exprList as 
exprList1) = exprList1 ()
 val  (expr as expr1) = expr1 ()
 in (exprList @ [expr])
end)
 in ( LrTable.NT 4, ( result, exprList1left, expr1right), rest671)
end
|  ( 32, ( rest671)) => let val  result = MlyValue.exprSeq (fn _ => (
[]))
 in ( LrTable.NT 5, ( result, defaultPos, defaultPos), rest671)
end
|  ( 33, ( ( _, ( MlyValue.expr expr1, (exprleft as expr1left), 
expr1right)) :: rest671)) => let val  result = MlyValue.exprSeq (fn _
 => let val  (expr as expr1) = expr1 ()
 in ([(expr, exprleft)])
end)
 in ( LrTable.NT 5, ( result, expr1left, expr1right), rest671)
end
|  ( 34, ( ( _, ( MlyValue.expr expr1, exprleft, expr1right)) :: _ :: 
( _, ( MlyValue.exprSeq exprSeq1, exprSeq1left, _)) :: rest671)) =>
 let val  result = MlyValue.exprSeq (fn _ => let val  (exprSeq as 
exprSeq1) = exprSeq1 ()
 val  (expr as expr1) = expr1 ()
 in ( exprSeq @ [(expr, exprleft)])
end)
 in ( LrTable.NT 5, ( result, exprSeq1left, expr1right), rest671)
end
|  ( 35, ( rest671)) => let val  result = MlyValue.fieldList (fn _ =>
 ([]))
 in ( LrTable.NT 14, ( result, defaultPos, defaultPos), rest671)
end
|  ( 36, ( ( _, ( MlyValue.expr expr1, _, expr1right)) :: _ :: ( _, ( 
MlyValue.ID ID1, (IDleft as ID1left), _)) :: rest671)) => let val  
result = MlyValue.fieldList (fn _ => let val  (ID as ID1) = ID1 ()
 val  (expr as expr1) = expr1 ()
 in ([(Symbol.symbol(ID), expr, IDleft)])
end)
 in ( LrTable.NT 14, ( result, ID1left, expr1right), rest671)
end
|  ( 37, ( ( _, ( MlyValue.expr expr1, _, expr1right)) :: _ :: ( _, ( 
MlyValue.ID ID1, IDleft, _)) :: _ :: ( _, ( MlyValue.fieldList 
fieldList1, fieldList1left, _)) :: rest671)) => let val  result = 
MlyValue.fieldList (fn _ => let val  (fieldList as fieldList1) = 
fieldList1 ()
 val  (ID as ID1) = ID1 ()
 val  (expr as expr1) = expr1 ()
 in (
fieldList @ [(Symbol.symbol(ID),
                                                     expr, IDleft)]
)
end)
 in ( LrTable.NT 14, ( result, fieldList1left, expr1right), rest671)

end
|  ( 38, ( ( _, ( MlyValue.declaration declaration1, declaration1left,
 declaration1right)) :: rest671)) => let val  result = 
MlyValue.decList (fn _ => let val  (declaration as declaration1) = 
declaration1 ()
 in ([declaration])
end)
 in ( LrTable.NT 6, ( result, declaration1left, declaration1right), 
rest671)
end
|  ( 39, ( ( _, ( MlyValue.declaration declaration1, _, 
declaration1right)) :: ( _, ( MlyValue.decList decList1, decList1left,
 _)) :: rest671)) => let val  result = MlyValue.decList (fn _ => let
 val  (decList as decList1) = decList1 ()
 val  (declaration as declaration1) = declaration1 ()
 in (decList @ [declaration])
end)
 in ( LrTable.NT 6, ( result, decList1left, declaration1right), 
rest671)
end
|  ( 40, ( ( _, ( MlyValue.varDec varDec1, varDec1left, varDec1right))
 :: rest671)) => let val  result = MlyValue.declaration (fn _ => let
 val  (varDec as varDec1) = varDec1 ()
 in (varDec)
end)
 in ( LrTable.NT 7, ( result, varDec1left, varDec1right), rest671)
end
|  ( 41, ( ( _, ( MlyValue.funDec funDec1, funDec1left, funDec1right))
 :: rest671)) => let val  result = MlyValue.declaration (fn _ => let
 val  (funDec as funDec1) = funDec1 ()
 in (funDec)
end)
 in ( LrTable.NT 7, ( result, funDec1left, funDec1right), rest671)
end
|  ( 42, ( ( _, ( MlyValue.typeDec typeDec1, typeDec1left, 
typeDec1right)) :: rest671)) => let val  result = MlyValue.declaration
 (fn _ => let val  (typeDec as typeDec1) = typeDec1 ()
 in (typeDec)
end)
 in ( LrTable.NT 7, ( result, typeDec1left, typeDec1right), rest671)

end
|  ( 43, ( ( _, ( MlyValue.typeVal typeVal1, _, typeVal1right)) :: _
 :: ( _, ( MlyValue.ID ID1, _, _)) :: ( _, ( _, (TYPEleft as TYPE1left
), _)) :: rest671)) => let val  result = MlyValue.typeDec (fn _ => let
 val  (ID as ID1) = ID1 ()
 val  (typeVal as typeVal1) = typeVal1 ()
 in (
A.TypeDec([{name = Symbol.symbol(ID),
                                         ty = typeVal,
                                         pos = TYPEleft}])
)
end)
 in ( LrTable.NT 10, ( result, TYPE1left, typeVal1right), rest671)
end
|  ( 44, ( ( _, ( MlyValue.ID ID1, (IDleft as ID1left), ID1right)) :: 
rest671)) => let val  result = MlyValue.typeVal (fn _ => let val  (ID
 as ID1) = ID1 ()
 in (A.NameTy(Symbol.symbol(ID), IDleft))
end)
 in ( LrTable.NT 13, ( result, ID1left, ID1right), rest671)
end
|  ( 45, ( ( _, ( _, _, RBRACE1right)) :: ( _, ( 
MlyValue.typeFieldList typeFieldList1, _, _)) :: ( _, ( _, LBRACE1left
, _)) :: rest671)) => let val  result = MlyValue.typeVal (fn _ => let
 val  (typeFieldList as typeFieldList1) = typeFieldList1 ()
 in (A.RecordTy(typeFieldList))
end)
 in ( LrTable.NT 13, ( result, LBRACE1left, RBRACE1right), rest671)

end
|  ( 46, ( ( _, ( MlyValue.ID ID1, _, ID1right)) :: _ :: ( _, ( _, (
ARRAYleft as ARRAY1left), _)) :: rest671)) => let val  result = 
MlyValue.typeVal (fn _ => let val  (ID as ID1) = ID1 ()
 in (A.ArrayTy(Symbol.symbol(ID), ARRAYleft))
end)
 in ( LrTable.NT 13, ( result, ARRAY1left, ID1right), rest671)
end
|  ( 47, ( ( _, ( MlyValue.expr expr1, _, expr1right)) :: _ :: _ :: (
 _, ( MlyValue.typeFieldList typeFieldList1, _, _)) :: _ :: ( _, ( 
MlyValue.ID ID1, _, _)) :: ( _, ( _, (FUNCTIONleft as FUNCTION1left),
 _)) :: rest671)) => let val  result = MlyValue.funDec (fn _ => let
 val  (ID as ID1) = ID1 ()
 val  (typeFieldList as typeFieldList1) = typeFieldList1 ()
 val  (expr as expr1) = expr1 ()
 in (
A.FunctionDec[{name = Symbol.symbol(ID), params = typeFieldList,
                        result = NONE, body = expr, pos = FUNCTIONleft}]
)
end)
 in ( LrTable.NT 9, ( result, FUNCTION1left, expr1right), rest671)
end
|  ( 48, ( ( _, ( MlyValue.expr expr1, _, expr1right)) :: _ :: ( _, ( 
MlyValue.ID ID2, ID2left, _)) :: _ :: _ :: ( _, ( 
MlyValue.typeFieldList typeFieldList1, _, _)) :: _ :: ( _, ( 
MlyValue.ID ID1, _, _)) :: ( _, ( _, (FUNCTIONleft as FUNCTION1left),
 _)) :: rest671)) => let val  result = MlyValue.funDec (fn _ => let
 val  ID1 = ID1 ()
 val  (typeFieldList as typeFieldList1) = typeFieldList1 ()
 val  ID2 = ID2 ()
 val  (expr as expr1) = expr1 ()
 in (
A.FunctionDec[{name = Symbol.symbol(ID1), params = typeFieldList,
                        result = SOME(Symbol.symbol(ID2), ID2left), 
                        body = expr, pos = FUNCTIONleft}]
)
end)
 in ( LrTable.NT 9, ( result, FUNCTION1left, expr1right), rest671)
end
|  ( 49, ( ( _, ( MlyValue.expr expr1, _, expr1right)) :: _ :: ( _, ( 
MlyValue.ID ID1, _, _)) :: ( _, ( _, (VARleft as VAR1left), _)) :: 
rest671)) => let val  result = MlyValue.varDec (fn _ => let val  (ID
 as ID1) = ID1 ()
 val  (expr as expr1) = expr1 ()
 in (
A.VarDec({name = Symbol.symbol(ID),
                                               escape = ref true,
                                               typ = NONE,
                                               init = expr,
                                               pos = VARleft})
)
end)
 in ( LrTable.NT 8, ( result, VAR1left, expr1right), rest671)
end
|  ( 50, ( ( _, ( MlyValue.expr expr1, _, expr1right)) :: _ :: ( _, ( 
MlyValue.ID ID2, ID2left, _)) :: _ :: ( _, ( MlyValue.ID ID1, _, _))
 :: ( _, ( _, (VARleft as VAR1left), _)) :: rest671)) => let val  
result = MlyValue.varDec (fn _ => let val  ID1 = ID1 ()
 val  ID2 = ID2 ()
 val  (expr as expr1) = expr1 ()
 in (
A.VarDec({name = Symbol.symbol(ID1),
                                               escape = ref true,
                                               typ = SOME(Symbol.symbol(ID2), 
                                                          ID2left),
                                               init = expr,
                                               pos = VARleft})
)
end)
 in ( LrTable.NT 8, ( result, VAR1left, expr1right), rest671)
end
|  ( 51, ( rest671)) => let val  result = MlyValue.typeFieldList (fn _
 => ([]))
 in ( LrTable.NT 11, ( result, defaultPos, defaultPos), rest671)
end
|  ( 52, ( ( _, ( MlyValue.typeField typeField1, typeField1left, 
typeField1right)) :: rest671)) => let val  result = 
MlyValue.typeFieldList (fn _ => let val  (typeField as typeField1) = 
typeField1 ()
 in ([typeField])
end)
 in ( LrTable.NT 11, ( result, typeField1left, typeField1right), 
rest671)
end
|  ( 53, ( ( _, ( MlyValue.typeField typeField1, _, typeField1right))
 :: _ :: ( _, ( MlyValue.typeFieldList typeFieldList1, 
typeFieldList1left, _)) :: rest671)) => let val  result = 
MlyValue.typeFieldList (fn _ => let val  (typeFieldList as 
typeFieldList1) = typeFieldList1 ()
 val  (typeField as typeField1) = typeField1 ()
 in (typeFieldList @ [typeField])
end)
 in ( LrTable.NT 11, ( result, typeFieldList1left, typeField1right), 
rest671)
end
|  ( 54, ( ( _, ( MlyValue.ID ID2, _, ID2right)) :: _ :: ( _, ( 
MlyValue.ID ID1, ID1left, _)) :: rest671)) => let val  result = 
MlyValue.typeField (fn _ => let val  ID1 = ID1 ()
 val  ID2 = ID2 ()
 in (
{name = Symbol.symbol(ID1),
                          escape = ref true,
                          typ = Symbol.symbol(ID2),
                          pos = ID1left}
)
end)
 in ( LrTable.NT 12, ( result, ID1left, ID2right), rest671)
end
|  ( 55, ( ( _, ( MlyValue.ID ID1, (IDleft as ID1left), ID1right)) :: 
rest671)) => let val  result = MlyValue.lvalue (fn _ => let val  (ID
 as ID1) = ID1 ()
 in (A.SimpleVar(Symbol.symbol(ID), IDleft))
end)
 in ( LrTable.NT 2, ( result, ID1left, ID1right), rest671)
end
|  ( 56, ( ( _, ( MlyValue.ID ID1, IDleft, ID1right)) :: _ :: ( _, ( 
MlyValue.lvalue lvalue1, lvalue1left, _)) :: rest671)) => let val  
result = MlyValue.lvalue (fn _ => let val  (lvalue as lvalue1) = 
lvalue1 ()
 val  (ID as ID1) = ID1 ()
 in (
A.FieldVar(lvalue, Symbol.symbol(ID),
                                                IDleft)
)
end)
 in ( LrTable.NT 2, ( result, lvalue1left, ID1right), rest671)
end
|  ( 57, ( ( _, ( _, _, RBRACK1right)) :: ( _, ( MlyValue.expr expr1,
 _, _)) :: ( _, ( _, LBRACKleft, _)) :: ( _, ( MlyValue.lvalue lvalue1
, lvalue1left, _)) :: rest671)) => let val  result = MlyValue.lvalue
 (fn _ => let val  (lvalue as lvalue1) = lvalue1 ()
 val  (expr as expr1) = expr1 ()
 in (A.SubscriptVar(lvalue, expr, LBRACKleft))
end)
 in ( LrTable.NT 2, ( result, lvalue1left, RBRACK1right), rest671)
end
| _ => raise (mlyAction i392)
end
val void = MlyValue.VOID
val extract = fn a => (fn MlyValue.program x => x
| _ => let exception ParseInternal
	in raise ParseInternal end) a ()
end
end
structure Tokens : Tiger_TOKENS =
struct
type svalue = ParserData.svalue
type ('a,'b) token = ('a,'b) Token.token
fun EOF (p1,p2) = Token.TOKEN (ParserData.LrTable.T 0,(
ParserData.MlyValue.VOID,p1,p2))
fun ID (i,p1,p2) = Token.TOKEN (ParserData.LrTable.T 1,(
ParserData.MlyValue.ID (fn () => i),p1,p2))
fun INT (i,p1,p2) = Token.TOKEN (ParserData.LrTable.T 2,(
ParserData.MlyValue.INT (fn () => i),p1,p2))
fun STRING (i,p1,p2) = Token.TOKEN (ParserData.LrTable.T 3,(
ParserData.MlyValue.STRING (fn () => i),p1,p2))
fun COMMA (p1,p2) = Token.TOKEN (ParserData.LrTable.T 4,(
ParserData.MlyValue.VOID,p1,p2))
fun COLON (p1,p2) = Token.TOKEN (ParserData.LrTable.T 5,(
ParserData.MlyValue.VOID,p1,p2))
fun SEMICOLON (p1,p2) = Token.TOKEN (ParserData.LrTable.T 6,(
ParserData.MlyValue.VOID,p1,p2))
fun LPAREN (p1,p2) = Token.TOKEN (ParserData.LrTable.T 7,(
ParserData.MlyValue.VOID,p1,p2))
fun RPAREN (p1,p2) = Token.TOKEN (ParserData.LrTable.T 8,(
ParserData.MlyValue.VOID,p1,p2))
fun LBRACK (p1,p2) = Token.TOKEN (ParserData.LrTable.T 9,(
ParserData.MlyValue.VOID,p1,p2))
fun RBRACK (p1,p2) = Token.TOKEN (ParserData.LrTable.T 10,(
ParserData.MlyValue.VOID,p1,p2))
fun LBRACE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 11,(
ParserData.MlyValue.VOID,p1,p2))
fun RBRACE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 12,(
ParserData.MlyValue.VOID,p1,p2))
fun DOT (p1,p2) = Token.TOKEN (ParserData.LrTable.T 13,(
ParserData.MlyValue.VOID,p1,p2))
fun PLUS (p1,p2) = Token.TOKEN (ParserData.LrTable.T 14,(
ParserData.MlyValue.VOID,p1,p2))
fun MINUS (p1,p2) = Token.TOKEN (ParserData.LrTable.T 15,(
ParserData.MlyValue.VOID,p1,p2))
fun TIMES (p1,p2) = Token.TOKEN (ParserData.LrTable.T 16,(
ParserData.MlyValue.VOID,p1,p2))
fun DIVIDE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 17,(
ParserData.MlyValue.VOID,p1,p2))
fun EQ (p1,p2) = Token.TOKEN (ParserData.LrTable.T 18,(
ParserData.MlyValue.VOID,p1,p2))
fun NEQ (p1,p2) = Token.TOKEN (ParserData.LrTable.T 19,(
ParserData.MlyValue.VOID,p1,p2))
fun LT (p1,p2) = Token.TOKEN (ParserData.LrTable.T 20,(
ParserData.MlyValue.VOID,p1,p2))
fun LE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 21,(
ParserData.MlyValue.VOID,p1,p2))
fun GT (p1,p2) = Token.TOKEN (ParserData.LrTable.T 22,(
ParserData.MlyValue.VOID,p1,p2))
fun GE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 23,(
ParserData.MlyValue.VOID,p1,p2))
fun AND (p1,p2) = Token.TOKEN (ParserData.LrTable.T 24,(
ParserData.MlyValue.VOID,p1,p2))
fun OR (p1,p2) = Token.TOKEN (ParserData.LrTable.T 25,(
ParserData.MlyValue.VOID,p1,p2))
fun ASSIGN (p1,p2) = Token.TOKEN (ParserData.LrTable.T 26,(
ParserData.MlyValue.VOID,p1,p2))
fun ARRAY (p1,p2) = Token.TOKEN (ParserData.LrTable.T 27,(
ParserData.MlyValue.VOID,p1,p2))
fun IF (p1,p2) = Token.TOKEN (ParserData.LrTable.T 28,(
ParserData.MlyValue.VOID,p1,p2))
fun THEN (p1,p2) = Token.TOKEN (ParserData.LrTable.T 29,(
ParserData.MlyValue.VOID,p1,p2))
fun ELSE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 30,(
ParserData.MlyValue.VOID,p1,p2))
fun WHILE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 31,(
ParserData.MlyValue.VOID,p1,p2))
fun FOR (p1,p2) = Token.TOKEN (ParserData.LrTable.T 32,(
ParserData.MlyValue.VOID,p1,p2))
fun TO (p1,p2) = Token.TOKEN (ParserData.LrTable.T 33,(
ParserData.MlyValue.VOID,p1,p2))
fun DO (p1,p2) = Token.TOKEN (ParserData.LrTable.T 34,(
ParserData.MlyValue.VOID,p1,p2))
fun LET (p1,p2) = Token.TOKEN (ParserData.LrTable.T 35,(
ParserData.MlyValue.VOID,p1,p2))
fun IN (p1,p2) = Token.TOKEN (ParserData.LrTable.T 36,(
ParserData.MlyValue.VOID,p1,p2))
fun END (p1,p2) = Token.TOKEN (ParserData.LrTable.T 37,(
ParserData.MlyValue.VOID,p1,p2))
fun OF (p1,p2) = Token.TOKEN (ParserData.LrTable.T 38,(
ParserData.MlyValue.VOID,p1,p2))
fun BREAK (p1,p2) = Token.TOKEN (ParserData.LrTable.T 39,(
ParserData.MlyValue.VOID,p1,p2))
fun NIL (p1,p2) = Token.TOKEN (ParserData.LrTable.T 40,(
ParserData.MlyValue.VOID,p1,p2))
fun FUNCTION (p1,p2) = Token.TOKEN (ParserData.LrTable.T 41,(
ParserData.MlyValue.VOID,p1,p2))
fun VAR (p1,p2) = Token.TOKEN (ParserData.LrTable.T 42,(
ParserData.MlyValue.VOID,p1,p2))
fun TYPE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 43,(
ParserData.MlyValue.VOID,p1,p2))
end
end

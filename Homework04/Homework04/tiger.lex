type svalue = Tokens.svalue
type pos = int
type ('a, 'b) token = ('a, 'b) Tokens.token
type lexresult = (svalue,pos) token

val lineNum = ErrorMsg.lineNum
val linePos = ErrorMsg.linePos
val commentDepth = Comment.depth
fun err(p1,p2) = ErrorMsg.error p1

fun eof() = let val pos = hd(!linePos) in Tokens.EOF(pos,pos) end

(* String Literal Globals *)
val strLit = ref ""
val strSize = ref 0

fun parseCC(s) = valOf(String.fromString(s))
fun parseRawAscii(s) = Char.toString(chr(valOf(Int.fromString(substring(s,1,size(s)-1)))))

%% 
%header (functor TigerLexFun(structure Tokens: Tiger_TOKENS));

digit = [0-9];
digits = {digit}+;
lower = [a-z];
upper = [A-Z];
letter = {lower}|{upper};
id = {letter}({letter}|{digit}|_)*;
ws = [\ \t];
formatChars = (" "|\t|\n|\r|\f);
newlineChar = "\\n";
tabChar = "\\t";
ccChar = "\\\^"{letter}; 
asciiChar = "\\"{digit}{3};
quoteChar = "\\\"";
backslashChar = "\\\\";
strWrapSeq = "\\"{formatChars}+"\\";

%s COMMENT;
%s STRING;

%%
\n	=> (lineNum := !lineNum + 1; linePos := yypos :: !linePos; continue());
<INITIAL>{ws}	=> (linePos := yypos :: !linePos; continue());

<INITIAL>"/*"	=> (YYBEGIN COMMENT; 
		    linePos := yypos :: !linePos; 
		    commentDepth := !commentDepth + 1; 
		    continue());
<INITIAL>"*/"	=> (ErrorMsg.error yypos ("unmatched comment delimeter " ^ yytext); 
		    continue());
<COMMENT>"/*"	=> (linePos := yypos :: !linePos; 
		    commentDepth := !commentDepth + 1; 
		    continue());
<COMMENT>"*/"	=> (linePos := yypos :: !linePos; 
		    commentDepth := !commentDepth - 1; 
		    if !commentDepth = 0
		    then YYBEGIN INITIAL
		    else ();
		    continue());


<INITIAL>"="	=> (Tokens.EQ(yypos, yypos + 1));
<INITIAL>","	=> (Tokens.COMMA(yypos, yypos + 1));
<INITIAL>":"	=> (Tokens.COLON(yypos, yypos + 1));
<INITIAL>";"	=> (Tokens.SEMICOLON(yypos, yypos + 1));
<INITIAL>"["	=> (Tokens.LBRACK(yypos, yypos + 1));
<INITIAL>"]"	=> (Tokens.RBRACK(yypos, yypos + 1));
<INITIAL>"{"	=> (Tokens.LBRACE(yypos, yypos + 1));
<INITIAL>"}"	=> (Tokens.RBRACE(yypos, yypos + 1));
<INITIAL>"("	=> (Tokens.LPAREN(yypos, yypos + 1));
<INITIAL>")"	=> (Tokens.RPAREN(yypos, yypos + 1));
<INITIAL>":="	=> (Tokens.ASSIGN(yypos, yypos + 2));
<INITIAL>"if"	=> (Tokens.IF(yypos, yypos + 2));
<INITIAL>"of"	=> (Tokens.OF(yypos, yypos + 2));
<INITIAL>"do"	=> (Tokens.DO(yypos, yypos + 2));
<INITIAL>"|"	=> (Tokens.OR(yypos, yypos + 1));
<INITIAL>"to"	=> (Tokens.TO(yypos, yypos + 2));
<INITIAL>"in"	=> (Tokens.IN(yypos, yypos + 2));
<INITIAL>"end"	=> (Tokens.END(yypos, yypos + 3));
<INITIAL>"var"	=> (Tokens.VAR(yypos, yypos + 3));
<INITIAL>"let"	=> (Tokens.LET(yypos, yypos + 3));
<INITIAL>"type"  => (Tokens.TYPE(yypos, yypos + 4));
<INITIAL>"array" => (Tokens.ARRAY(yypos, yypos + 5));
<INITIAL>"function" => (Tokens.FUNCTION(yypos, yypos + 8));
<INITIAL>"break" => (Tokens.BREAK(yypos, yypos + 5));
<INITIAL>"end" => (Tokens.END(yypos, yypos + 3));
<INITIAL>"nil" => (Tokens.NIL(yypos, yypos + 3));
<INITIAL>"for" => (Tokens.FOR(yypos, yypos + 3));
<INITIAL>"while" => (Tokens.WHILE(yypos, yypos + 5));
<INITIAL>"else" => (Tokens.ELSE(yypos, yypos + 4));
<INITIAL>"then" => (Tokens.THEN(yypos, yypos + 4));
<INITIAL>"&" => (Tokens.AND(yypos, yypos + 1));
<INITIAL>">=" => (Tokens.GE(yypos, yypos + 2));
<INITIAL>">" => (Tokens.GT(yypos, yypos + 1));
<INITIAL>"<" => (Tokens.LT(yypos, yypos + 1));
<INITIAL>"<=" => (Tokens.LE(yypos, yypos + 2));
<INITIAL>"<>" => (Tokens.NEQ(yypos, yypos + 2));
<INITIAL>"/" => (Tokens.DIVIDE(yypos, yypos + 1));
<INITIAL>"*" => (Tokens.TIMES(yypos, yypos + 1));
<INITIAL>"-" => (Tokens.MINUS(yypos, yypos + 1));
<INITIAL>"+" => (Tokens.PLUS(yypos, yypos + 1));
<INITIAL>"." => (Tokens.DOT(yypos, yypos + 1));

<INITIAL>"\"" => (YYBEGIN STRING; strLit := ""; 
                  strSize := 0; continue());
<STRING>{newlineChar} => (strLit := !strLit ^ "\n"; strSize := !strSize + 2; continue());
<STRING>{tabChar} => (strLit := !strLit ^ "\t"; strSize := !strSize + 3; continue());
<STRING>{quoteChar} => (strLit := !strLit ^ "\""; strSize := !strSize + 4; continue());
<STRING>{ccChar}  => (strLit := !strLit ^ parseCC(yytext); strSize := !strSize + 5; continue());
<STRING>{backslashChar}  => (strLit := !strLit ^ "\\"; strSize := !strSize + 4; continue());
<STRING>{asciiChar} => (strLit := !strLit ^ parseRawAscii(yytext); strSize := !strSize + 5; continue());
<STRING>{strWrapSeq} => (strSize := !strSize + size yytext; continue());
<STRING>"\""  =>  (YYBEGIN INITIAL; 
                   Tokens.STRING(!strLit, yypos, yypos + !strSize));
<STRING>.     => (strLit := !strLit ^ yytext;
                  strSize := !strSize + size(yytext); continue());

<INITIAL>{id}	=> (Tokens.ID(yytext, yypos, yypos + size(yytext)));
<INITIAL>{digits}   => 
  (Tokens.INT(valOf(Int.fromString(yytext)), yypos, yypos + size(yytext)));

<INITIAL>.	=> (ErrorMsg.error yypos ("illegal character " ^ yytext); continue()); 
<COMMENT>.	=> (linePos := yypos :: !linePos; continue());

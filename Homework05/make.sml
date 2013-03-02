
print "Compiling sources.cm...";
CM.make "sources.cm";

(* A test is 
 * (string * string) list
 * where #1 is the path and #2 is a test description
 *)

val goodTests = 
  [("test/test1.tig", "Array type and variable"),
   ("test/test2.tig", "Array and type dec"), 
   ("test/test3.tig", "Record type and var"),
   ("test/test4.tig", "Recursive function"),
   ("test/test5.tig", "Recursive types"),
   ("test/test6.tig", "mutually recursive procedures"),
   ("test/test7.tig", "mutually recursive functions"),
   ("test/test8.tig", "Correct if"),
   ("test/test12.tig", "valid for and let"),
   ("test/test27.tig", "locals hide globals"),
   ("test/test30.tig", "type synonyms are fine"),
   ("test/test37.tig", "Redeclaration of variables"),
   ("test/test41.tig", "local types hide global"),
   ("test/test42.tig", "Array and record declarations"),
   ("test/test44.tig", "valid nil init and assign"),
   ("test/test46.tig", "valid record comparisons"),
   ("test/test47.tig", "redeclaration of types b/c 2nd isn't mutual"),
   ("test/test48.tig", "redeclaration of function")];

val errors = 
 [("test/test9.tig", "if branch types differ"),
  ("test/test10.tig", "body of while not unit"),
  ("test/test11.tig", "for hi exp is not int; index var assignment"),
  ("test/test13.tig", "comparison of incompatible types"),
  ("test/test14.tig", "compare rec with array"),
  ("test/test15.tig", "if-then returns non-unit"),
  ("test/test16.tig", "circularly recursive types"),
  ("test/test17.tig", "def of mutually recursive types interrupted"),
  ("test/test18.tig", "def of mutually recursive functions interrupted"),
  ("test/test19.tig", "2nd fun uses variables local to 1st"),
  ("test/test20.tig", "undeclared var"),
  ("test/test21.tig", "proc returns value, proc used recursively"),
  ("test/test22.tig", "field not in record type"),
  ("test/test23.tig", "type mismatch"),
  ("test/test24.tig", "access subscript in var that's not array"),
  ("test/test25.tig", "access field in var that's not record"),
  ("test/test26.tig", "binop type mismatch"),
  ("test/test28.tig", "different record types"),
  ("test/test29.tig", "different array types"),
  ("test/test31.tig", "type constraint and init type differ"),
  ("test/test32.tig", "init exp and array type differ"),
  ("test/test33.tig", "unknown type"),
  ("test/test34.tig", "formals and actuals have different types"),
  ("test/test35.tig", "more formals are more than actuals"),
  ("test/test36.tig", "fewer formals than actuals"),
  ("test/test38.tig", "mutually recursive types with same name"),
  ("test/test39.tig", "mutually recursive functions with same name"),
  ("test/test40.tig", "procedure returns a value"),
  ("test/test43.tig", "init with unit and cause type mismatch in binop"),
  ("test/test45.tig", "init nil expression not constrained by record"),
  ("test/test49.tig", "syntax error. nil should not be preceded by type") ];

(app (fn (file, desc) => (Main.compile(file))) goodTests);
OS.Process.exit(OS.Process.success)


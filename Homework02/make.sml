print "Compiling sources.cm...";
CM.make "sources.cm";

print "Running tests...\n";
structure A = Absyn; 

Parse.parse("test/mytest1.tig") = A.StringExp("Hello", 8); 

Parse.parse("test/mytest2.tig") = A.IntExp(100);

Parse.parse("test/mytest3.tig") = A.NilExp;

Parse.parse("test/mytest4.tig") = 
        A.OpExp({left = A.IntExp(10), right = A.IntExp(15), 
                 oper = A.PlusOp, pos = 2});

Parse.parse("test/mytest5.tig") = 
        A.OpExp({left = A.IntExp(10), oper = A.PlusOp, pos = 2,
                 right = A.OpExp({right = A.IntExp(25), 
                                  oper = A.DivideOp, pos = 7,
                                  left = A.OpExp({left = A.IntExp(15), 
                                                  right = A.IntExp(20),
                                                  oper = A.TimesOp,
                                                  pos = 7})})});

PrintAbsyn.print(TextIO.stdOut, Parse.parse("test/mytest5.5.tig"));
PrintAbsyn.print(TextIO.stdOut, Parse.parse("test/mytest6.tig"));
PrintAbsyn.print(TextIO.stdOut, Parse.parse("test/mytest7.tig"));
PrintAbsyn.print(TextIO.stdOut, Parse.parse("test/mytest8.tig"));
PrintAbsyn.print(TextIO.stdOut, Parse.parse("test/mytest9.tig"));
PrintAbsyn.print(TextIO.stdOut, Parse.parse("test/mytest10.tig"));
PrintAbsyn.print(TextIO.stdOut, Parse.parse("test/mytest11.tig"));

Parse.parse "test/test1.tig";
Parse.parse "test/test2.tig";
Parse.parse "test/test3.tig";
Parse.parse "test/test4.tig";
Parse.parse "test/test5.tig";

PrintAbsyn.print(TextIO.stdOut, Parse.parse("test/test4.tig"));
PrintAbsyn.print(TextIO.stdOut, Parse.parse("test/test6.tig"));
PrintAbsyn.print(TextIO.stdOut, Parse.parse("test/test7.tig"));
PrintAbsyn.print(TextIO.stdOut, Parse.parse("test/test8.tig"));
PrintAbsyn.print(TextIO.stdOut, Parse.parse("test/test9.tig"));
PrintAbsyn.print(TextIO.stdOut, Parse.parse("test/test10.tig"));
PrintAbsyn.print(TextIO.stdOut, Parse.parse("test/test11.tig"));
PrintAbsyn.print(TextIO.stdOut, Parse.parse("test/test13.tig"));
PrintAbsyn.print(TextIO.stdOut, Parse.parse("test/test15.tig"));
PrintAbsyn.print(TextIO.stdOut, Parse.parse("test/test16.tig"));
PrintAbsyn.print(TextIO.stdOut, Parse.parse("test/test17.tig"));
PrintAbsyn.print(TextIO.stdOut, Parse.parse("test/test20.tig"));
PrintAbsyn.print(TextIO.stdOut, Parse.parse("test/test26.tig"));
PrintAbsyn.print(TextIO.stdOut, Parse.parse("test/test29.tig"));
PrintAbsyn.print(TextIO.stdOut, Parse.parse("test/test38.tig"));
PrintAbsyn.print(TextIO.stdOut, Parse.parse("test/test41.tig"));
PrintAbsyn.print(TextIO.stdOut, Parse.parse("test/test42.tig"));
PrintAbsyn.print(TextIO.stdOut, Parse.parse("test/mytest42.tig"));

PrintAbsyn.print(TextIO.stdOut, Parse.parse("test/test12.tig"));
PrintAbsyn.print(TextIO.stdOut, Parse.parse("test/test14.tig"));
PrintAbsyn.print(TextIO.stdOut, Parse.parse("test/test18.tig"));
PrintAbsyn.print(TextIO.stdOut, Parse.parse("test/test19.tig"));
PrintAbsyn.print(TextIO.stdOut, Parse.parse("test/test21.tig"));
PrintAbsyn.print(TextIO.stdOut, Parse.parse("test/test22.tig"));
PrintAbsyn.print(TextIO.stdOut, Parse.parse("test/test23.tig"));
PrintAbsyn.print(TextIO.stdOut, Parse.parse("test/test25.tig"));
PrintAbsyn.print(TextIO.stdOut, Parse.parse("test/test27.tig"));
PrintAbsyn.print(TextIO.stdOut, Parse.parse("test/test28.tig"));
PrintAbsyn.print(TextIO.stdOut, Parse.parse("test/test31.tig"));
PrintAbsyn.print(TextIO.stdOut, Parse.parse("test/test32.tig"));
PrintAbsyn.print(TextIO.stdOut, Parse.parse("test/test33.tig"));
PrintAbsyn.print(TextIO.stdOut, Parse.parse("test/test34.tig"));
PrintAbsyn.print(TextIO.stdOut, Parse.parse("test/test35.tig"));
PrintAbsyn.print(TextIO.stdOut, Parse.parse("test/test36.tig"));
PrintAbsyn.print(TextIO.stdOut, Parse.parse("test/test37.tig"));
PrintAbsyn.print(TextIO.stdOut, Parse.parse("test/test39.tig"));
PrintAbsyn.print(TextIO.stdOut, Parse.parse("test/test40.tig"));
PrintAbsyn.print(TextIO.stdOut, Parse.parse("test/test42.tig"));
PrintAbsyn.print(TextIO.stdOut, Parse.parse("test/test43.tig"));
PrintAbsyn.print(TextIO.stdOut, Parse.parse("test/test44.tig"));
PrintAbsyn.print(TextIO.stdOut, Parse.parse("test/test45.tig"));
PrintAbsyn.print(TextIO.stdOut, Parse.parse("test/test46.tig"));
PrintAbsyn.print(TextIO.stdOut, Parse.parse("test/test47.tig"));
PrintAbsyn.print(TextIO.stdOut, Parse.parse("test/test48.tig"));
PrintAbsyn.print(TextIO.stdOut, Parse.parse("test/test49.tig"));
PrintAbsyn.print(TextIO.stdOut, Parse.parse("test/merge.tig"));
PrintAbsyn.print(TextIO.stdOut, Parse.parse("test/queens.tig"));

(*

PrintAbsyn.print(TextIO.stdOut, Parse.parse("test/test24.tig"));
PrintAbsyn.print(TextIO.stdOut, Parse.parse("test/test30.tig"));
*)

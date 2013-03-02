
print "Compiling sources.cm...";
CM.make "sources.cm";

(* runTest : string bool -> ()
 * Given a path and whether or not the test is enabled, run the test
 * runTest(src, enabled, passed)
 *)
fun runTest(src, true, false) = 
      (let 
        val expty = Semant.transProg(Parse.parse(src))
      in 
        (print("========================================\n");
         print("Running test " ^ src ^ "...\n");
         print("========================================\n");
         Printtree.printtree(TextIO.stdOut, Translate.unNx(#exp expty));
         expty)
      end)
  | runTest(src, false, false) = 
      Semant.transProg(Parse.parse(src))
  | runTest(_, _, true) = {exp = Translate.nilExp(), ty = Types.UNIT};
  

(*
(let val parseTree = Parse.parse("test/mytest4.tig")
in (FindEscape.findEscape(parseTree); Semant.transProg(parseTree))
end);

(let val {exp, ty} = Semant.transProg(Parse.parse("test/mytest4.tig"));
in Printtree.printtree(TextIO.stdOut, Translate.unNx(exp))
end);
*)
(*
runTest("test/mytest4.tig", false);
runTest("test/mytestif.tig", false);
runTest("test/test1.tig", false);
runTest("test/test2.tig", false);
runTest("test/test3.tig", true);
runTest("test/test4.tig", false);
runTest("test/test5.tig", false);   (* FIXME: Mutually Recursive *)
runTest("test/test6.tig", false);   (* FIXME: Mutually Recursive *)
runTest("test/test7.tig", false);   (* FIXME: Mutually Recursive *)
runTest("test/test8.tig", true, true);
runTest("test/test9.tig", false, true);
runTest("test/test10.tig", false, true);
runTest("test/test11.tig", false, true);
runTest("test/test12.tig", false, true);
runTest("test/test13.tig", false, true);
runTest("test/test14.tig", false, true);
runTest("test/test15.tig", false, true);
runTest("test/test16.tig", false, false); (* FIXME: Mutually Recursive*)
runTest("test/test17.tig", false, false); (* FIXME: Mutually Recursive *)
runTest("test/test18.tig", false, false); (* FIXME: Mutually Recursive *)
runTest("test/test19.tig", false, false); (* FIXME: Mutually Recursive *)
runTest("test/test20.tig", false, true);
runTest("test/test21.tig", false, true);
runTest("test/test22.tig", false, true);
*)
runTest("test/test23.tig", false, false); (* FIXME: accessing fieldvars *)
(*
runTest("test/test24.tig", false, true);
runTest("test/test25.tig", false, true);
runTest("test/test26.tig", false, true);
runTest("test/test27.tig", false, true);
runTest("test/test28.tig", false, true);
runTest("test/test29.tig", false, true);
runTest("test/test30.tig", false, true);
runTest("test/test31.tig", false, true);
runTest("test/test32.tig", false, true);
runTest("test/test33.tig", false, true);
runTest("test/test34.tig", false, true);
runTest("test/test35.tig", false, true);
runTest("test/test36.tig", false, true);
runTest("test/test37.tig", false, true);
runTest("test/test38.tig", false, true);
runTest("test/test39.tig", false, true);
runTest("test/test40.tig", false, true);
runTest("test/test41.tig", false, true);
runTest("test/test42.tig", false, false); (* FIXME: fjdksal; *)
runTest("test/test43.tig", false, true);
runTest("test/test44.tig", false, true); 
runTest("test/test45.tig", false, true); 
runTest("test/test46.tig", false, true);
runTest("test/test47.tig", false, true);
runTest("test/test48.tig", false, true);
runTest("test/test49.tig", false, false);
*)
OS.Process.exit(OS.Process.success)

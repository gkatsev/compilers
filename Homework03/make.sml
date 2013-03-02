print "Compiling sources.cm...";
CM.make "sources.cm";

Semant.transProg(Parse.parse("test/mytest4.tig"));

Semant.transProg(Parse.parse("test/mytest12.tig"));

Semant.transProg(Parse.parse("test/mytest8.tig"));

Semant.transProg(Parse.parse("test/mytest11.tig"));

Semant.transProg(Parse.parse("test/mytest13.tig"));

Semant.transProg(Parse.parse("test/test3.tig"));

Gary Katsevman
Daniel Bostwick

This is the frame analyzer and the IR translation assignment. 

!!!LATE!!! :-(

Could you also re-run the tests for the Semantic Analyzer and let us know how 
many of the bugs were fixed? Mutually recursive types & functions are still 
non-operational, but l-values and vars should be fixed. 


== New Code ==

types.sml
* New method, Types.toS : Types.ty -> string, used for debugging and 
  error handling.

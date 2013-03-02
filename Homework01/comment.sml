signature COMMENT = 
sig
    val depth : int ref
    val outsideComment : int
    val isOutside : int -> bool
end

structure Comment : COMMENT = 
struct

    val depth = ref 0
    val outsideComment = 0
    
    fun reset() = (depth := 0);

    fun isOutside 0 = true
      | isOutside n = false

end (* Comment structure *)

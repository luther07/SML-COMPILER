(* lexer receives the return value from a call to Mlex.makeLexer.
   We are passing a function int->string to CalcLex.makeLexer. *)

val lexer =
  let val input_line = fn f =>
        let 
	    fun loop result =
            	let 
		    val c = TextIO.inputN (f,1)
       		    val result = c :: result
           	in 
		   if String.size c = 0 orelse c = "\n" then
                   foldl op^ "" result
    		   else loop result
		end
     	in loop nil
        end
  in CalcLex.makeLexer (fn n => input_line std_in)
  end

(* Write an ML function (maxargs : stm->int) that tells the maximum number
 * of arguments of any print statement within any subexpression of a
 * given statement. For example, maxargs(prog) is 2.
 * For part 1, remember that print statements can contain expressions
 * that contain other print statements.
 ******************************************
 * Function does pass the test, returning value 2 for argument prog.
 * I fixed the syntax errors, but I have not verified that my
 * function is correct. 
 ******************************************
 * Identified error: I think I need to handle the case there's a 
 * PrintStm with an EseqExp sandwiched in the middle of its args.
 ******************************************)

fun maxargsStm(CompoundStm(a,b))
    = if maxargsStm(a) >= maxargsStm(b)
         then maxargsStm(a)
         else maxargsStm(b)
   |maxargsStm(AssignStm(a,b))
    = maxargsExp(b)
   |maxargsStm(PrintStm([]))
    = 0
   |maxargsStm(PrintStm(EseqExp(a,b)::rest_of_list))
    = if maxargsStm(a) >= maxargsExp(b)
         then if maxargsStm(a) >= maxargsStm(PrintStm(rest_of_list))
                 then maxargsStm(a)
                 else maxargsStm(PrintStm(rest_of_list))
         else if maxargsExp(b) >= maxargsStm(PrintStm(rest_of_list))
                 then maxargsExp(b)
                 else maxargsStm(PrintStm(rest_of_list))
   |maxargsStm(PrintStm(x::xs))
    = 1 + maxargsStm(PrintStm(xs))

and maxargsExp(IdExp(a))
    = 0
   |maxargsExp(NumExp(a))
    = 0
   |maxargsExp(OpExp(a,b,c))
    = 0
   |maxargsExp(EseqExp(a,b))
    = if maxargsStm(a) >= maxargsExp(b)
         then maxargsStm(a)
         else maxargsExp(b)

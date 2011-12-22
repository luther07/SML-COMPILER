(* Write an ML function (maxargs : stm->int) that tells the maximum number
 * of arguments of any print statement within any subexpression of a
 * given statement. For example, maxargs(prog) is 2.
 * For part 1, remember that print statements can contain expressions
 * that contain other print statements.
 ******************************************
 * Function does pass the test, returning value 2 for argument prog.
 * Function also returns correct response from a nested PrintStm
 * when sandwiched inside an EseqExp inside a PrintStm.
 ******************************************)

fun maxargsStm(CompoundStm(a,b))
    = if maxargsStm(a) >= maxargsStm(b)
         then maxargsStm(a)
         else maxargsStm(b)
   |maxargsStm(AssignStm(a,b))
    = maxargsExp(b)
   |maxargsStm(PrintStm(xs)) =
       let
          val printArgs = length xs
          fun traverse (member, maxi) =
             case member of
                [] => 0
               |last::[] => if maxi > maxargsExp(last) then maxi else maxargsExp(last)
               |first::rest => if maxi > maxargsExp(first) then traverse(rest,maxi) else traverse(rest, maxargsExp(first))
       in
          traverse(xs,printArgs)
       end

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

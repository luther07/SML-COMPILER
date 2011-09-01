(* Write an ML function (maxargs : stm->int) that tells the maximum number
 * of arguments of any print statement within any subexpression of a
 * given statement. For example, maxargs(prog) is 2.
 * For part 1, remember that print statements can contain expressions
 * that contain other print statements.
 *
 * TODO: pattern-match for case where a print statement contains other
 * print statements. *)

fun maxargs(CompoundStm(a,b))
    = if maxargs(a) >= maxargs(b)
         then maxargs(a)
         else maxargs(b)
   |maxargs(AssignStm(a,b))
    = maxargs_exp(b)
   |maxargs(PrintStm([]))
    = 0
   |maxargs(PrintStm([EseqExp(a,b)),rest_of_list])
    = if maxargs(a) >= maxargs_exp(b)
         then if maxargs(a) >= maxargs_exp(rest_of_list)
                 then maxargs(a)
                 else maxargs_exp(rest_of_list)
         else if maxargs_exp(b) >= maxargs_exp(rest_of_list)
                 then maxargs_exp(b)
                 else maxargs_exp(rest_of_list)
   |maxargs(PrintStm(x::xs))
    = 1 + maxargs(PrintStm(xs))

and maxargs_exp(IdExp(a))
    = 0
   |maxargs_exp(NumExp(a))
    = 0
   |maxargs_exp(OpExp(a,b,c))
    = 0
   |maxargs_exp(EseqExp(a,b))
    = if maxargs(a) >= maxargs_exp(b)
         then maxargs(a)
         else maxargs_exp(b)

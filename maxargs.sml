(* Write an ML function (maxargs : stm->int) that tells the maximum number
 * of arguments of any print statement within any subexpression of a
 * given statement. For example, maxargs(prog) is 2.
 * For part 1, remember that print statements can contain expressions
 * that contain other print statements. *)
fun maxargs(CompoundStm(a,b))
    = if maxargs(a) >= maxargs_stm(b)
         then maxargs(a)
         else maxargs(b)
   |maxargs(AssignStm(a,b))
    = maxargs_exp(b)
   |maxargs(PrintStm([]))
    = 0
   |maxargs(PrintStm(x::xs))
    = 1 + maxargs(PrintStm(xs))
and maxargs_exp(IdExp(a))
    = 0
   |maxargs_exp(NumExp(a))
    = 0
   |maxargs_exp(OpExp(a))
    = 0
   |maxargs_exp(EseqExp(a,b))
    = if maxargs(a) >= maxargs_exp(b)
         then maxargs(a)
         else maxargs_exp(b)

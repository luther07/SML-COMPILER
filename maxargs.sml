(* Write an ML function (maxargs : stm->int) that tells the maximum number
 * of arguments of any print statement within any subexpression of a
 * given statement. For example, maxargs(prog) is 2. *)
fun maxargs(CompoundStm(a,b))
    = 1
   |maxargs(AssignStm(a,b))
    = 0
   |maxargs(PrintStm(x::xs))
    = 0

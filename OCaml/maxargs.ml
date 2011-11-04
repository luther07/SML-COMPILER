(* Write an OCaml function (maxargs : stm->int) that tells the maximum number
 * of arguments of any print statement within any subexpression of a
 * given statement. For example, maxargs(prog) is 2.
 * For part 1, remember that print statements can contain expressions that 
 * contain other print statement.
 *
 * TODO: pattern-match for case where a print statement contains other
 * print statements. *)
let rec (maxargs : stm -> int) =
   function
      CompoundStm(a,b)
       -> maxargs(a) + maxargs(b)
     |AssignStm(a,b)
       -> 0
     |PrintStm([])
       -> 0
     |PrintStm([EseqExp(PrintStm(x::xs),expr)::eseq_exp_list])
       -> if 1 + maxargs(PrintStm(eseq_exp_list)) >= 
             
     |PrintStm(x::xs)
       -> 1 + maxargs(PrintStm(xs))
and (maxargs_exp : exp -> int) =
   function
      IdExp(a)
       -> 0
     |NumExp(a)
       -> 0
     |OpExp(a,b,c)
       -> 0
     |EseqExp(a,b)
       -> if maxargs(a) >= maxargs_exp(b)
             then maxargs(a)
             else maxargs_exp(b)

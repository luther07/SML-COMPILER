(* Write an OCaml function (maxargs : stm->int) that tells the maximum number
 * of arguments of any print statement within any subexpression of a
 * given statement. For example, maxargs(prog) is 2. *)
let rec (maxargs : stm -> int) =
   function
      CompoundStm(a,b)
       -> 1 (* I don't know yet *)
     |AssignStm(a,b)
       -> 0
     |PrintStm([])
       -> 0
     |PrintStm(x::xs)
       -> 1 + maxargs(PrintStm(xs))

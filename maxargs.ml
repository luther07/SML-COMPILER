(* Write an OCaml function (maxargs : stm->int) that tells the maximum number
 * of arguments of any print statement within any subexpression of a
 * given statement. For example, maxargs(prog) is 2. *)
let rec maxargs_in_stm =
   function
      CompoundStm(a,b)
       -> 1
     |AssignStm(a,b)
       -> 0
     |PrintStm(a)
       -> 0

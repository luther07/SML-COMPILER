Control.Print.printDepth := 60;

(* The expression below shows a case that isn't handled correctly by maxargsStm function.
   The function should count the maximum number of arguments to a print statement. For
   "prog" below it should return 10, but it returns 11. Therefore the function is not correct. *)
type id = string
datatype binop = Plus | Minus | Times | Div
datatype stm = CompoundStm of stm * stm
	     | AssignStm of id * exp
	     | PrintStm of exp list

     and exp = IdExp of id
	     | NumExp of int
             | OpExp of exp * binop * exp
             | EseqExp of stm * exp

val prog = 
 CompoundStm(AssignStm("a",OpExp(NumExp 5, Plus, NumExp 3)),
  CompoundStm(AssignStm("b",
      EseqExp(PrintStm[IdExp"a",OpExp(IdExp"a", Minus,NumExp 1)],
           OpExp(NumExp 10, Times, IdExp"a"))),
   PrintStm[IdExp "b", EseqExp(PrintStm[NumExp 1, NumExp 2, NumExp 3, NumExp 4, NumExp 5, NumExp 6, NumExp 7, NumExp 8, NumExp 9, NumExp 10], NumExp 6)]))


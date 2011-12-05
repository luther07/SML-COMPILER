Control.Print.printDepth := 60;

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
   PrintStm[IdExp "b"]))

(* stm prog1 is evaluated correctly by the interpreter.
   The expression inside PrintStm constructor is evaluated to 8,
   which is printed to stdout, followed by a new line. Finally,
   the table of bindings is the return value of the expression. *)

val prog1: stm = PrintStm([OpExp(NumExp 5, Plus, NumExp 3)])

val myid: id = "word"

val mytable: (id*int) list = (myid,1) :: []

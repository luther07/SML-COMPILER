signature INTERPRETER =
 sig
   type id 
   type binop
   val Plus : binop
   val Minus : binop
   val Times : binop
   val Div : binop
   type stm
   type exp
   val CompoundStm : stm*stm -> stm
   val AssignStm : string*exp -> stm
   val PrintStm : exp list -> stm
   val IdExp : string -> exp
   val NumExp : int -> exp
   val OpExp : exp*binop*exp -> exp
   val EseqExp : stm*exp -> exp
   exception Key_binding_not_found of int
   type symtable
   val interpStm : (stm*symtable) -> symtable
   val interpExp : (exp*symtable) -> int*symtable
   val sample : stm
 end;

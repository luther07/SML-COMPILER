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
   val AssignStm   : string*exp -> stm
   val PrintStm    : exp list -> stm
   val IdExp       : string -> exp
   val NumExp      : int -> exp
   val OpExp       : exp*binop*exp -> exp
   val EseqExp     : stm*exp -> exp
   exception KeyBindingNotFound of int
   type sym_table
   val interpStm   : (stm*sym_table) -> sym_table
   val interpExp   : (exp*sym_table) -> int*sym_table
   val maxargsStm  : stm -> int
   val maxargsExp  : exp -> int
 end;


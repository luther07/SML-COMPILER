(* Write an ML function (interp : stm->unit) that interprets a program
 * in this language. To write in a "functional style" - without assignment
 * (:=) or arrays - maintain a list of (variable, integer) pairs, and
 * produce new versions of this list at each AssignStm.
 ***********************************************************************
 * For part 2, make two mutually recursive functions interpStm and 
 * interpExp. Represent a "table", mapping identifiers to the integer
 * values assigned to them, as a list of id X int pairs. Then interpStm
 * should have the type stm X table -> table, taking a table t1 as
 * argument and producing the new table t2 that's just like t1 except 
 * that some identifiers map to different integers as a result of the
 * statement.
 ***********************************************************************)

fun interpStm(CompoundStm(a,b))

and interpExp(IdExp(a))
    

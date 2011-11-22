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
(* stm * (id * int) list -> (id * int) list *)
fun interpStm(CompoundStm(a,b), tbl:(id * int) list)
    = (interpStm(a); interpStm(b); tbl)
   |interpStm(AssignStm(a,b), tbl:(id * int) list)
    = (a,b)::tbl
   |interpStm(PrintStm(first::rest), tbl:(id * int) list)
    = (print first; print "\n"; tbl)

and interpExp(IdExp(a), tbl:(id * int) list)
    = 
   |interpExp(NumExp(a), tbl:(id * int) list)
    =
   |interpExp(OpExp(a,b,c), tbl:(id * int) list)
    = 
   |interpExp(EseqExp(a,b), tbl:(id * int) list)
    = (interpStm(a); interpExp(b); tbl)

fun update(t1: (id * int) list, c: id, i: int)
    = (c, i) :: t1

fun lookup(table: (id * int) table)
    = 

(* Write an ML function (interp : stm->unit) that interprets a program
 * in this language. To write in a "functional style" - without assignment
 * (:=) or arrays - maintain a list of (variable, integer) pairs, and
 * produce new versions of this list at each AssignStm.
 ***********************************************************************
 * For part 2, make two mutually recursive functions interpStm and 
 * interpExp. Represent a "table", mapping identifiers to the integer
 * values assigned to them, as a list of id*int pairs. Then interpStm
 * should have the type stm*table -> table, taking a table t1 as
 * argument and producing the new table t2 that's just like t1 except 
 * that some identifiers map to different integers as a result of the
 * statement.
 ***********************************************************************)
(* helper functions *)

exception Key_binding_not_found of int

fun update([], c: id, i: int): (id*int) list = (c, i) :: []
  | update(tbl: (id*int) list, c: id, i: int): (id*int) list = (c, i) :: tbl

fun lookup([], a: id): int list = raise Key_binding_not_found(~1000000)
  | lookup((x:id,y:int) :: pairs, a: id): int list = if (x=a) then [y] else lookup(pairs, a)

(* stm * (id * int) list -> (id * int) list *)
fun interpStm(CompoundStm(a,b), tbl:(id * int) list): (id*int) list =
    let 
       val firstTable = interpStm(a, tbl)
    in
       interpStm(b, firstTable)
    end

   |interpStm(AssignStm(a,b), tbl:(id * int) list): (id*int) list =
       let 
          val (aNum, aTable) = interpExp(b,tbl)
       in 
          update(tbl, a, aNum)
       end

   |interpStm(PrintStm([]), tbl: (id * int) list): (id*int) list =
       tbl

   |interpStm(PrintStm(first::rest), tbl:(id * int) list): (id * int) list =
       let val (aString, aTable) =
          let
             val (aNum, aTab) = interpExp(first, tbl);
          in
             (Int.toString aNum, aTab)
          end
       in
          (print aString; print "\n"; aTable)
       end

(* The call to the lookup function below will throw Table_lookup_key_not_found exception. *)
and interpExp(IdExp(a), tbl:(id * int) list): (int*(id*int) list) =
       let 
          val subResult = lookup(tbl, a)
          val aResult = hd subResult
       in
          (aResult, tbl)
       end
   |interpExp(NumExp(a), tbl:(id * int) list): (int*(id*int) list) =
       (a, tbl)

(* interpExp(OpExp) branch is syntactically correct *)
   |interpExp(OpExp(a,Plus,c), tbl:(id * int) list): (int*(id*int) list)  =
       let 
          val (result1, t1) = interpExp(a, tbl);
          val (result2, t2) = interpExp(c, t1)
       in 
          ((result1 + result2), t2)
       end
   |interpExp(OpExp(a, Minus, c), tbl:(id * int) list): (int*(id*int) list) =
       let 
          val (result1, t1) = interpExp(a, tbl)
          val (result2, t2) = interpExp(c, t1)
       in 
          ((result1 - result2), t2)
       end
   |interpExp(OpExp(a, Times, c), tbl:(id * int) list): (int*(id*int) list) =
       let 
          val (result1, t1) = interpExp(a, tbl)
          val (result2, t2) = interpExp(c, t1)
       in 
          ((result1 * result2), t2)
       end
   |interpExp(OpExp(a, Div, c), tbl:(id * int) list): (int*(id*int) list) =
       let 
          val (result1, t1) = interpExp(a, tbl)
          val (result2, t2) = interpExp(c, t1)
       in 
          ((result1 div result2), t2)
       end

   |interpExp(EseqExp(a,b), tbl:(id * int) list): (int*(id*int) list) =
       let 
          val aTable = interpStm(a, tbl)
       in 
          interpExp(b, aTable)
       end

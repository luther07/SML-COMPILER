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

exception Key_binding_not_found of int

(* helper functions *)
fun update(tbl: (id*int) list, c: id, i: int): (id*int) list = (c, i) :: tbl

fun lookup([], a: id): int list = raise Key_binding_not_found(~1000000)
  | lookup((x:id,y:int) :: pairs, a: id): int list = 
      if (x=a) 
        then [y] 
      else lookup(pairs, a)

(* two mutually recursive functions *)
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

(* The call to the lookup function below will throw an exception called 
 * Table_lookup_key_not_found, if the symbol is not found in the table. This
 * exception makes sense. When a program tries to use a nonexistent variable
 * then an exception should be thrown when . *)
and interpExp(IdExp(a), tbl:(id * int) list): (int*(id*int) list) =
       let 
          val subResult = lookup(tbl, a)
          val intResult = hd subResult
       in
          (intResult, tbl)
       end
   |interpExp(NumExp(a), tbl:(id * int) list): (int*(id*int) list) =
       (a, tbl)

   |interpExp(OpExp(a,Plus,c), tbl:(id * int) list): (int*(id*int) list) =
       let 
          val (resultOne, t1) = interpExp(a, tbl);
          val (resultTwo, bindingsTable) = interpExp(c, t1)
       in 
          ((resultOne + resultTwo), bindingsTable)
       end
   |interpExp(OpExp(a, Minus, c), tbl:(id * int) list): (int*(id*int) list) =
       let 
          val (resultOne, t1) = interpExp(a, tbl)
          val (resultTwo, bindingsTable) = interpExp(c, t1)
       in 
          ((resultOne - resultTwo), bindingsTable)
       end
   |interpExp(OpExp(a, Times, c), tbl:(id * int) list): (int*(id*int) list) =
       let 
          val (resultOne, t1) = interpExp(a, tbl)
          val (resultTwo, bindingsTable) = interpExp(c, t1)
       in 
          ((resultOne * resultTwo), bindingsTable)
       end
   |interpExp(OpExp(a, Div, c), tbl:(id * int) list): (int*(id*int) list) =
       let 
          val (resultOne, t1) = interpExp(a, tbl)
          val (resultTwo, bindingsTable) = interpExp(c, t1)
       in 
          ((resultOne div resultTwo), bindingsTable)
       end

   |interpExp(EseqExp(a,b), tbl:(id * int) list): (int*(id*int) list) =
       let 
          val bindingsTable = interpStm(a, tbl)
       in 
          interpExp(b, bindingsTable)
       end

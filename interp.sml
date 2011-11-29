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
(* stm * (id * int) list -> (id * int) list *)
fun interpStm(CompoundStm(a,b), tbl:(id * int) list)
    = (interpStm(a, tbl); interpStm(b, tbl))
   |interpStm(AssignStm(a,b), tbl:(id * int) list)
    = update(tbl,a,interpExp(b,tbl))
   |interpStm(PrintStm([]), tbl: (id * int) list)
    = tbl
   |interpStm(PrintStm(first::rest), tbl:(id * int) list)
    = (print(interpExp(first, tbl)); print "\n"; interpStm(PrintStm(rest), tbl))

and interpExp(IdExp(a), tbl:(id * int) list) =
     (hd(lookup(tbl, a)), tbl)
   |interpExp(NumExp(a), tbl:(id * int) list) =
     (a, tbl)
   |interpExp(OpExp(a,Plus,c), tbl:(id * int) list) =
     let val (result1, t1) = interpExp(a, tbl)
     in 
       let val (result2, t2) = interpExp(c, t1)
       in (result1+result2, t2)
       end;
     end;
   |interpExp(OpExp(a, Minus, c), tbl:(id * int) list) =
     let val (result1, t1) = interpExp(a, tbl)
     in
       let val (result2, t2) = interpExp(c, t1)
       in (result1-result2, t2)
       end;
     end;
   |interpExp(OpExp(a, Times, c), tbl:(id * int) list) =
     let val (result1, t1) = interpExp(a, tbl)
     in
       let val (result2, t2) = interpExp(c, t1)
       in (result1*result2, t2)
       end;
     end;
   |interpExp(OpExp(a, Div, c), tbl:(id * int) list) =
     let val (result1, t1) = interpExp(a, tbl)
     in
       let val (result2, t2) = interpExp(c, t1)
       in (result1 div result2, t2)
       end;
     end;
   |interpExp(EseqExp(a,b), tbl:(id * int) list) =
     (interpStm(a); interpExp(b); tbl)

fun update([], c: id, i: int) = (c, i) :: []
  | update(tbl, c: id, i: int) = (c, i) :: tbl

fun lookup([], a:id) = []
  | lookup((x:id,y:int)::pairs, a:id) = if (x = a) then [y] else lookup(pairs, a) 

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

(* two private helper functions *)
fun update(symbolTable:(id*int) list, symbol:id, value:int): (id*int) list = (symbol,value) :: symbolTable

fun lookup(symbolTable:(id*int) list, searchSymbol:id) = case symbolTable of
  [] => raise Key_binding_not_found(~1000000)
 |(firstSymbol,firstValue)::restTable => if (firstSymbol=searchSymbol)
                              then [firstValue]
                            else lookup(restTable,searchSymbol)

(* two mutually recursive functions *)
fun interpStm(CompoundStm(firstStmt,restStmt), symbolTable:(id*int) list): (id*int) list =
    let 
       val firstTable = interpStm(firstStmt,symbolTable)
    in
       interpStm(restStmt,firstTable)
    end

   |interpStm(AssignStm(a,b), symbolTable:(id * int) list): (id*int) list =
       let 
          val (numberValue, newSymbolTable) = interpExp(b,symbolTable)
       in 
          update(newSymbolTable, a, numberValue)
       end

   |interpStm(PrintStm([]), symbolTable: (id*int) list): (id*int) list =
       symbolTable

   |interpStm(PrintStm(firstExpr::restExpr), symbolTable:(id*int) list): (id * int) list =
       let val (finalString, finalTable) =
          let
             val (numberValue, newSymbolTable) = interpExp(firstExpr, symbolTable);
          in
             (Int.toString numberValue, newSymbolTable)
          end
       in
          (print finalString; print "\n"; finalTable)
       end

(* The call to the lookup function below will throw an exception called 
 * Table_lookup_key_not_found, if the symbol is not found in the table. This
 * exception makes sense. When a program tries to use a nonexistent variable
 * then an exception should be thrown when . *)
and interpExp(IdExp(variable), symbolTable:(id*int) list): (int*(id*int) list) =
       let 
          val subResult = lookup(symbolTable, variable)
          val number = hd subResult
       in
          (number, symbolTable)
       end
   |interpExp(NumExp(number), symbolTable:(id*int) list): (int*(id*int) list) =
       (number, symbolTable)
   |interpExp(OpExp(firstExpr,Plus,secondExpr), symbolTable:(id*int) list): (int*(id*int) list) =
       let 
          val (resultOne, newSymbolTable) = interpExp(firstExpr, symbolTable);
          val (resultTwo, finalSymbolTable) = interpExp(secondExpr, newSymbolTable)
       in 
          ((resultOne + resultTwo), finalSymbolTable)
       end
   |interpExp(OpExp(firstExpr, Minus, secondExpr), symbolTable:(id*int) list): (int*(id*int) list) =
       let 
          val (resultOne, newSymbolTable) = interpExp(firstExpr, symbolTable)
          val (resultTwo, finalSymbolTable) = interpExp(secondExpr, newSymbolTable)
       in 
          ((resultOne - resultTwo), finalSymbolTable)
       end
   |interpExp(OpExp(firstExpr, Times, secondExpr), symbolTable:(id*int) list): (int*(id*int) list) =
       let 
          val (resultOne, newSymbolTable) = interpExp(firstExpr, symbolTable)
          val (resultTwo, finalSymbolTable) = interpExp(secondExpr, newSymbolTable)
       in 
          ((resultOne * resultTwo), finalSymbolTable)
       end
   |interpExp(OpExp(firstExpr, Div, secondExpr), symbolTable:(id*int) list): (int*(id*int) list) =
       let 
          val (resultOne, newSymbolTable) = interpExp(firstExpr, symbolTable)
          val (resultTwo, finalSymbolTable) = interpExp(secondExpr, newSymbolTable)
       in 
          ((resultOne div resultTwo), finalSymbolTable)
       end
   |interpExp(EseqExp(firstExpr,restExprs), symbolTable:(id*int) list): (int*(id*int) list) =
       let 
          val finalSymbolTable = interpStm(firstExpr, symbolTable)
       in 
          interpExp(restExprs, finalSymbolTable)
       end

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
structure Interpreter : INTERPRETER =
  struct
  (* Below are the provided abstract syntax definitions *)
  type id = string
  datatype binop = Plus | Minus | Times | Div
  datatype stm = CompoundStm of stm*stm
                |AssignStm of id*exp
                |PrintStm of exp list
       and exp = IdExp of id
                |NumExp of int
                |OpExp of exp*binop*exp
                |EseqExp of stm*exp

  exception Key_binding_not_found of int
  type symtable = (id*int) list

  (* two private helper functions *)
  fun update(symbolTable:symtable, symbol:id, value:int): symtable = (symbol,value) :: symbolTable

  fun lookup(symbolTable:symtable, searchSymbol:id) = case symbolTable of
    [] => raise Key_binding_not_found(~1000000)
   |(firstSymbol,firstValue)::restTable => if (firstSymbol=searchSymbol)
                              then [firstValue]
                            else lookup(restTable,searchSymbol)

  (* two mutually recursive functions *)
  fun interpStm(CompoundStm(firstStmt,restStmt), symbolTable:symtable): symtable =
      let
         val firstTable = interpStm(firstStmt,symbolTable)
      in
         interpStm(restStmt,firstTable)
      end

     |interpStm(AssignStm(a,b), symbolTable:symtable): symtable =
         let
            val (numberValue, newSymbolTable) = interpExp(b,symbolTable)
         in
            update(newSymbolTable, a, numberValue)
         end

     |interpStm(PrintStm([]), symbolTable: symtable): symtable =
         symbolTable

     |interpStm(PrintStm(firstExpr::restExpr), symbolTable:symtable): symtable =
         let val (finalString, finalTable) =
            let
               val (numberValue, newSymbolTable) = interpExp(firstExpr, symbolTable);
            in
               (Int.toString numberValue, newSymbolTable)
            end
         in
            (print finalString; print "\n"; finalTable)
         end

  (* The call to the lookup function below will throw an uncaught exception
   * called Table_lookup_key_not_found, if the symbol is not found in the table.
   * This exception makes sense. When a program tries to use a nonexistent variable
   * then an exception should be thrown when . *)

  and interpExp(IdExp(variable), symbolTable:symtable): (int*symtable) =
         let
            val subResult = lookup(symbolTable, variable)
            val number = hd subResult
         in
            (number, symbolTable)
         end
     |interpExp(NumExp(number), symbolTable:symtable): (int*symtable) =
         (number, symbolTable)
     |interpExp(OpExp(firstExpr,Plus,secondExpr), symbolTable:symtable): (int*symtable) =
         let
            val (resultOne, newSymbolTable) = interpExp(firstExpr, symbolTable);
            val (resultTwo, finalSymbolTable) = interpExp(secondExpr, newSymbolTable)
         in
            ((resultOne + resultTwo), finalSymbolTable)
         end
     |interpExp(OpExp(firstExpr, Minus, secondExpr), symbolTable:symtable): (int*symtable) =
         let
            val (resultOne, newSymbolTable) = interpExp(firstExpr, symbolTable)
            val (resultTwo, finalSymbolTable) = interpExp(secondExpr, newSymbolTable)
         in
            ((resultOne - resultTwo), finalSymbolTable)
         end
     |interpExp(OpExp(firstExpr, Times, secondExpr), symbolTable:symtable): (int*symtable) =
         let
            val (resultOne, newSymbolTable) = interpExp(firstExpr, symbolTable)
            val (resultTwo, finalSymbolTable) = interpExp(secondExpr, newSymbolTable)
         in
            ((resultOne * resultTwo), finalSymbolTable)
         end
     |interpExp(OpExp(firstExpr, Div, secondExpr), symbolTable:symtable): (int*symtable) =
         let
            val (resultOne, newSymbolTable) = interpExp(firstExpr, symbolTable)
            val (resultTwo, finalSymbolTable) = interpExp(secondExpr, newSymbolTable)
         in
            ((resultOne div resultTwo), finalSymbolTable)
         end
     |interpExp(EseqExp(firstExpr,restExprs), symbolTable:symtable): (int*symtable) =
         let
            val finalSymbolTable = interpStm(firstExpr, symbolTable)
         in
            interpExp(restExprs, finalSymbolTable)
         end

  (* An ML function (maxargs : stm->int) that tells the maximum number
   * of arguments of all print statements within a given statement. *)

  fun maxargsStm(CompoundStm(a,b))
      = if maxargsStm(a) >= maxargsStm(b)
           then maxargsStm(a)
           else maxargsStm(b)
     |maxargsStm(AssignStm(a,b))
      = maxargsExp(b)
     |maxargsStm(PrintStm(xs)) =
         let
            val printArgs = length xs
            fun traverse (member, maxi) =
               case member of
                  [] => 0
                 |last::[] => if maxi > maxargsExp(last)
                                then maxi
                              else maxargsExp(last)
                 |first::rest => if maxi > maxargsExp(first)
                                   then traverse(rest,maxi)
                                 else traverse(rest, maxargsExp(first))
         in
            traverse(xs,printArgs)
         end

  and maxargsExp(IdExp(_))
      = 0
     |maxargsExp(NumExp(_))
      = 0
     |maxargsExp(OpExp(_,_,_))
      = 0
     |maxargsExp(EseqExp(a,b))
      = if maxargsStm(a) >= maxargsExp(b)
           then maxargsStm(a)
           else maxargsExp(b)
  end;


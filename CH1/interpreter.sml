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
structure Interpreter : INTERPRETER = struct

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

  exception KeyBindingNotFound of int
  type sym_table = (id*int) list

  (* two private helper functions *)
  fun update(symbolTable:sym_table, symbol:id, value:int): sym_table =
    (symbol,value) :: symbolTable

  fun lookup(symbolTable:sym_table, searchSymbol:id) = case symbolTable of
    [] => raise KeyBindingNotFound(~1000000)
   |(firstSymbol,firstValue)::restTable => if (firstSymbol=searchSymbol)
                              then [firstValue]
                            else lookup(restTable,searchSymbol)

  fun help() =
    print "****Welcome to the Straight Line Program Interpreter!!\n\
      \****You are using a structure called: Interpreter.\n\
      \****You should prefix your use of structure components with the structure name, Interpreter.\n\
      \****Or you can define an alias for structure in the top-level environment.\n\
      \****The type Interpreter.id is an alias for type string.\n\
      \Available atomic constructor functions are:\n\
      \\tInterpreter.IdExp: Interpreter.id -> Interpreter.exp\n\
      \\tInterpreter.NumExp: int -> Interpreter.exp\n\
      \Practice using these constructor functions until you've mastered them!\n"

  (* two mutually recursive functions *)
  fun interpStm(CompoundStm(firstStmt,restStmt), symbolTable:sym_table): sym_table =
      let
         val firstTable = interpStm(firstStmt,symbolTable)
      in
         interpStm(restStmt,firstTable)
      end

     |interpStm(AssignStm(a,b), symbolTable:sym_table): sym_table =
         let
            val (numberValue, newSymbolTable) = interpExp(b,symbolTable)
         in
            update(newSymbolTable, a, numberValue)
         end

     |interpStm(PrintStm([]), symbolTable: sym_table): sym_table =
         symbolTable

     |interpStm(PrintStm(firstExpr::restExpr), symbolTable:sym_table): sym_table =
         let val (finalString, finalTable) =
            let
               val (numberValue, newSymbolTable) =
                 interpExp(firstExpr, symbolTable);
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

  and interpExp(IdExp(variable), symbolTable:sym_table): (int*sym_table) =
         let
            val subResult = lookup(symbolTable, variable)
            val number = hd subResult
         in
            (number, symbolTable)
         end
     |interpExp(NumExp(number), symbolTable:sym_table): (int*sym_table) =
         (number, symbolTable)
     |interpExp(OpExp(firstExpr,Plus,secondExpr), symbolTable:sym_table): (int*sym_table) =
         let
            val (resultOne, newSymbolTable) = interpExp(firstExpr, symbolTable);
            val (resultTwo, finalSymbolTable) = interpExp(secondExpr, newSymbolTable)
         in
            ((resultOne + resultTwo), finalSymbolTable)
         end
     |interpExp(OpExp(firstExpr, Minus, secondExpr), symbolTable:sym_table): (int*sym_table) =
         let
            val (resultOne, newSymbolTable) = interpExp(firstExpr, symbolTable)
            val (resultTwo, finalSymbolTable) = interpExp(secondExpr, newSymbolTable)
         in
            ((resultOne - resultTwo), finalSymbolTable)
         end
     |interpExp(OpExp(firstExpr, Times, secondExpr), symbolTable:sym_table): (int*sym_table) =
         let
            val (resultOne, newSymbolTable) = interpExp(firstExpr, symbolTable)
            val (resultTwo, finalSymbolTable) = interpExp(secondExpr, newSymbolTable)
         in
            ((resultOne * resultTwo), finalSymbolTable)
         end
     |interpExp(OpExp(firstExpr, Div, secondExpr), symbolTable:sym_table): (int*sym_table) =
         let
            val (resultOne, newSymbolTable) = interpExp(firstExpr, symbolTable)
            val (resultTwo, finalSymbolTable) = interpExp(secondExpr, newSymbolTable)
         in
            ((resultOne div resultTwo), finalSymbolTable)
         end
     |interpExp(EseqExp(firstExpr,restExprs), symbolTable:sym_table): (int*sym_table) =
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


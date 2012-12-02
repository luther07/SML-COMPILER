(* Sample interactive calculator to demonstrate use of lexer
   The original grammar was
       stmt_list -> stmt_list stmt
       stmt -> print exp ; | exp ;
       exp -> exp + t | exp - t | t
       t -> t * f | t/f | f
       f -> (exp) | id | num
  The function parse takes a stream and parses it for the calculator
  program.
  If a syntax error occurs, parse prints an error message and calls
  itself on the stream. On this system that has the effect of ignoring
  all input to the end of a line.
*)
structure Calc =
 struct
   open CalcLex
   open UserDeclarations
   exception Error
   fun parse strm =
    let
      val say = fn s => output(std_out,s)
      val input_line = fn f =>
           let fun loop result =
              let val c = input (f,1)
         val result = c :: result
        in if String.size c = 0 orelse c = "\n" then
 String.implode (rev result)
    else loop result
end
     in loop nil
     end
 val lexer = makeLexer (fn n => input_line strm)
 val nexttok = ref (lexer())
 val advance = fn () => (nexttok := lexer(); !nexttok)
 val error = fn () => (say ("calc: syntax error on line" ^
                      (makestring(!linenum)) ^ "\n"); raise Error)
 val lookup = fn i =>
   if i = "ONE" then 1
   else if i = "TWO" then 2
   else (say ("calc: unknown identifier ’" ^ i ^ "’\n"); raise Error)
fun STMT_LIST () =
    case !nexttok of
       EOF => ()
     | _ => (STMT(); STMT_LIST())
and STMT() =
    (case !nexttok
      of EOS => ()
       | PRINT => (advance(); say ((makestring (E():int)) ^ "\n"); ())
       | _ => (E(); ());
    case !nexttok
      of EOS => (advance())
       | _ => error())
and E () = E'(T())
and E' (i : int ) =
    case !nexttok of
       PLUS => (advance (); E'(i+T()))
     | SUB => (advance (); E'(i-T()))
     | RPAREN => i
     | EOF => i
     | EOS => i
     | _ => error()
and T () = T'(F())
and T' i =
   case !nexttok of
       PLUS => i
     | SUB => i
     | TIMES => (advance(); T'(i*F()))
     | DIV => (advance (); T'(i div F()))
     | EOF => i
     | EOS => i
     | RPAREN => i
         | _ => error()
    and F () =
       case !nexttok of
           ID i => (advance(); lookup i)
         | LPAREN =>
             let val v = (advance(); E())
             in if !nexttok = RPAREN then (advance (); v) else error()
             end
         | NUM i => (advance(); i)
         | _ => error()
   in STMT_LIST () handle Error => parse strm
   end
end


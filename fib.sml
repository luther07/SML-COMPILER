(* function is not tail-recursive,
   stackoverflow exception on evaluation of 'fib 100000;'
   uncaught exception Overflow [overflow] *)

fun fib(n: int) = case n of
  0 => 0
 |1 => 1
 |any => fib(any-1) + fib(any-2)

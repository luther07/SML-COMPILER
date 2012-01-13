(* function is not tail-recursive,
   stackoverflow exception on evaluation of 'fib 100000;'
   uncaught exception Overflow [overflow] *)

fun fib(0) = 0
  |fib(1) = 1
  |fib(n) = fib(n-1) + fib(n-2)

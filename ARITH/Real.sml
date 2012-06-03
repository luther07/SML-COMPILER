(* Exercise 2.24 from Paulson, function quo is defined in terms of prod and
 * recip. Function quo could as well be defined in terms of only the division
 * operator. Below we declare that the structure, Real, conforms to the
 * signature, ARITH. *)

structure Real : ARITH =
  struct
  type t = real;
  val zero = 0.0;
  fun sum (x,y) = x+y : t;
  fun diff (x,y) = x-y : t
  fun prod (x,y) = x*y : t;
  fun recip(x) = 1.0/x : t;
  fun quo(z,z') = prod(z, recip z');
  end;

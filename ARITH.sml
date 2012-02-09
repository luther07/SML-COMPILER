(* signature from Paulson Exercise 2.24, which hides any components not
   mentioned below, making them private *)
signature ARITH =
   sig
   type t
   val zero : t
   val sum : t * t -> t
   val diff : t * t -> t
   val prod : t * t -> t
   val quo : t * t -> t
   end;

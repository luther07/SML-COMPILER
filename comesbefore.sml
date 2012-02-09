(* ML for the Working Programmer, Exercise 2.6, page 32. *)
fun comesbefore ((hour1,min1,ampm1),(hour2,min2,ampm2)) =
   if (hour1 + (if ampm1 = "PM" then 12 else 0) > 
       hour2 + (if ampm2 = "PM" then 12 else 0))
   then false
   else if (hour1 + (if ampm1 = "PM" then 12 else 0) < 
            hour2 + (if ampm2 = "PM" then 12 else 0))
   then true
   else min1 < min2   

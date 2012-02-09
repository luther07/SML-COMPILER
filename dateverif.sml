(* ML for the Working Programmer, Exercise 2.5, page 27. *)
fun dateverif d m =
   if (m = "September" 
      orelse m = "April" 
      orelse m = "June"
      orelse m = "November")
      andalso d >=1 
      andalso d <= 30
      then true
   else if m = "February" 
      andalso d >= 1 
      andalso d <= 28
      then true
   else if (m = "January"
      orelse m = "March"
      orelse m = "May"
      orelse m = "July"
      orelse m = "August"
      orelse m = "October"
      orelse m = "December")
      andalso d >= 1
      andalso d <= 31
      then true
   else false

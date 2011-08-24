let rec (listcount : 'a list -> int) =
   function
      ([])
       -> 0
     |(x::xs)
       -> 1 + listcount xs

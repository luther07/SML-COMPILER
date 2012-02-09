(* Association Lists, Paulson section 3.16. *)
val battles = [("Crecy", 1346), ("Poitiers", 1356), ("Agincourt", 1415),
               ("Trafalgar", 1805), ("Waterloo", 1815)];

fun assoc ([], a) = []
  | assoc((x,y)::pairs, a) = if (a = x) then [y]
                                else assoc(pairs, a)

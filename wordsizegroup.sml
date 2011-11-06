(* Interview question, write a function of type string list -> string list list,
   which receives a list of strings and returns these strings grouped into separate
   lists of those strings that are anagrams/permutations of each other.

   Function, wordsizegroup, is just a beginning, to map a list of words to a list of
   their corresponding sizes. *)
fun wordsizegroup input : int list =
   map (fn x => size x) input


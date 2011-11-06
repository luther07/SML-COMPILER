(* Interview question, write a function from string list -> string list list,
   which receives a list of strings and returns these strings grouped into separate
   lists of those strings that are anagrams/permutations of each other.

   Function, wordsizegroup, is just a beginning, to map a list of words to a list of
   tuples containing the string size and value. *)

fun wordsizegroup input : (int*string) list =
   map (fn x => (size x,x)) input




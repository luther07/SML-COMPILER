(* Function lookupbool is a member function that returns true if 
   the searched item is found else false. 
   Function lookup provides mappings from keys to values. *)

type key = string

datatype tree = LEAF | TREE of tree * key * tree

val empty = LEAF

exception Key_not_found_in_binary_search_tree of key

fun insert(key,LEAF) = TREE(LEAF,key,LEAF)
  | insert(key,TREE(l,k,r)) =
       if key<k
         then TREE(insert(key,l), k, r)
       else if key>k
         then TREE(l,k,insert(key,r))
       else TREE(l,key,r)

fun lookupbool(key,LEAF) = false
  | lookupbool(key,TREE(l,k,r)) =
       if key = k
         then true
       else if key>k
         then lookupbool(key,r)
       else lookupbool(key,l)

(* Function lookup throws Key_not_found_in_binary_search_tree exception. *)

fun lookup(key,LEAF) = raise Key_not_found_in_binary_search_tree("")
  | lookup(key,TREE(l,k,r)) =
       if key = k
         then k
       else if key>k
         then lookup(key,r)
       else lookup(key,l)

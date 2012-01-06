type key = string
datatype tree = LEAF | TREE of tree * key * tree

val empty = LEAF

fun insert(key,LEAF) = TREE(LEAF,key,LEAF)
  | insert(key,TREE(l,k,r)) =
       if key<k
         then TREE(insert(key,l), k, r)
       else if key>k
         then TREE(l,k,insert(key,r))
       else TREE(l,key,r)

fun lookupBool(key,LEAF) = false
  | lookup(key,TREE(l,k,r)) =
       if key = k
         then true
       else if key>k
         then lookup(key,r)
       else lookup(key,l)

fun lookupKV(key,LEAF) = false
  | lookupKV(key,TREE(l,k,r)) =
       if key = k
         then k
       else if key>k
         then lookupKV(key,r)
       else lookupKV(key,l)

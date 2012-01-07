(* Test function to confirm that the function, lookupkv, in file "persistent.sml" does what it should.
   Searching for any value inside a tree that is only an empty
   leaf will not find the searched-for value. Instead the test
   function extracts the string that is encapsulated in the
   exception, an empty string. The test returns true if the
   val, returnval, matches an empty string. Otherwise the
   function returns false. *)

fun test_lookupkv(key:key, LEAF): bool =
    let 
       val returnval = lookupkv(key:string, LEAF) handle Key_not_found(a_string) => a_string
    in
       case returnval of
          "" => true
        | _  => false
    end
   
   |test_lookupkv(key:string, TREE(l,k,r)): bool = 
    let
       val returnval = lookupkv(key:key, TREE(l,k,r)) handle Key_not_found(a_string) => a_string
    in
       if returnval = key
         then true
       else if returnval = ""
         then true
       else false
    end

(* Test cases for empty and non-empty binary trees. *)

val key_not_exists_in_empty_tree: bool = test_lookupkv("test",LEAF)

val key_exists_in_nonempty_tree: bool = test_lookupkv("test",TREE(LEAF,"test",LEAF))

val key_not_exists_in_nonempty_tree: bool = test_lookupkv("test", TREE(LEAF,"somevalue",LEAF))

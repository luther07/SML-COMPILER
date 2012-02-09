(* Test function to confirm that the function, lookupkv, does what it should.
   Searching for any value inside a tree that is only an empty leaf will not
   find the searched-for value. Instead the test function extracts the string
   that is encapsulated in the exception, an empty string. The test returns
   true if the val, returnval, matches an empty string. Otherwise the function
   returns false. *)

fun test_lookupkv(key:key, LEAF): bool =
    let 
       val x = lookupkv(key:string, LEAF) 
                 handle Key_not_found_in_binary_search_tree(a_str) => a_str
    in
       case x of
          "" => true
        | _  => false
    end
   
   |test_lookupkv(key:string, TREE(l,k,r)): bool = 
    let
       val x = lookupkv(key:key, TREE(l,k,r)) 
                 handle Key_not_found_in_binary_search_tree(a_str) => a_str
    in
       if x = key
         then true
       else if x = ""
         then true
       else false
    end

(* Test cases for empty and non-empty binary trees. *)

(* Searching for any string in an empty tree, 
   returns boolean true if exception is handled. *)
val key_not_exists_in_empty_tree: bool = test_lookupkv("test",LEAF)

(* Searching for string "test" in a tree containing "test" and two LEAFs
   returns boolean true if the string returned by function lookupkv equals
   "test" *)
val key_exists_in_nonempty_tree: bool = 
  test_lookupkv("test",TREE(LEAF,"test",LEAF))

(* Searching for string "test" in a tree containing a string which is not
   equal to "test", returns boolean true if either the string returned by
   function lookupkv equals "test or if it equals "", which is what is
   returned by the function what it handles a key not found exception. *)

val key_not_exists_in_nonempty_tree: bool = 
  test_lookupkv("test", TREE(LEAF,"somevalue",LEAF))

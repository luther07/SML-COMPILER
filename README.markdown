# Per L.C. Paulson, "...ML makes it easy to write clear, reliable programs".

### I have the book, Modern Compiler Implementation in ML.

### I have installed sml/nj and associated tools.

### I am learning to implement a compiler by implementing a compiler.

  10/19/11
  I have implemented part 1 of the Straight Line Program Interpreter from
  page 11, which is a max args function that counts the maximum number of
  args to a PrintStm constructor in a nested statement. I have tested the
  function on some difficult, nested expressions, and the function returned
  accurate results.

  10/20/11
  Part 2 of the Straight Line Interpreter, I have finished with renaming
  the mutually recursive functions to maxargsStm and maxargsExp.
  
  1/5/12
  Status of part 2, I have completed the Interpreter, which is two mutually
  recursive functions to interpret Statements and Expressions in the given
  language. The functions maintain a table of key/value bindings for keeping
  track of variable bindings.

  1/6/12
  Working on chapter 1, Exercises 1.1. Parts a and b are complete. This was
  my first use of exceptions. Exception will be thrown in the lookupkv
  function if the key isn't found in the binary search tree. Went back to
  part 2 and added an exception to the lookup function. The lookup function
  used by the interpreter will throw an exception if the binding isn't found.

  TODO: currently researching to identify best balanced BST for functional symbol table in Sedgewick[1998].
  TODO: write good tests to cover the code in maxargs.sml, interp.sml, and persistent.sml.
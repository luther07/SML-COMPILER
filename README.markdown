# Per L.C. Paulson, "...ML makes it easy to write clear, reliable programs".

###### I have the book, _Modern Compiler Implementation in ML_.

###### I have installed sml/nj and associated tools.

###### I am learning to implement a compiler by implementing a compiler.

* Implemented part 1 of the Straight Line Program Interpreter, 
  the _maxargs_ function that counts the maximum number of
  argumentss to a PrintStm constructor in a nested statement.

* Implemented part 2 of the Straight Line Interpreter, renamed
  the mutually recursive functions maxargsStm and maxargsExp.

* Exercises 1.1. parts a and b completed. This was
  my first use of exceptions. Exception will be thrown in the lookupkv
  function if the key isn't found in the binary search tree. Went back to
  the Straight Line Program Interpreter and added an exception to the 
  lookup function.

* Added a signature file and packaged the interpreter inside a structure.
  Also added compilation manager file to project. Now you can run my project 
  with command: _CM.make "sources.cm";_ followed by importing the module into 
  the top-level with something like: _structure S = Interpreter;_

  TODO: currently researching to identify best balanced BST for functional symbol table in Sedgewick[1998].
  TODO: write good tests to cover the code in maxargs.sml, interp.sml, and persistent.sml.

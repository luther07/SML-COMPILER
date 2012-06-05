# Per L.C. Paulson, "...ML makes it easy to write clear, reliable programs".

###### I have the book, _Modern Compiler Implementation in ML_.

###### I have installed sml/nj and associated tools.

###### I am learning to implement a compiler by implementing a compiler.

* Implemented part 1 of the Straight Line Program Interpreter:
  the _maxargsStm_ and _maxargsExp_ functions in structure _Interpreter_
  counts the maximum number of argumentss to all PrintStm constructors
  in a nested statement.

* Implemented part 2 of the Straight Line Interpreter, renamed
  the mutually recursive functions _maxargsStm_ and _maxargsExp_.

* Exercises 1.1. parts a and b completed. This was
  my first use of exceptions. Exception will be thrown in the _lookupkv_
  function if the key isn't found in the binary search tree. Went back to
  the Straight Line Program Interpreter and added an exception to the
  lookup function.

* Added a signature file and packaged the interpreter inside structure
  _Interpreter_. Also added compilation manager file to project. Now you can
  run my project with command: _CM.make "sources.cm";_ followed by importing
  the module into the top-level with: _structure S = Interpreter;_

  TODO: write functional tests to cover the code in maxargs.sml, interp.sml,
  and persistent.sml.


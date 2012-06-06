# Contents

###### _sources.cm_ : compilation manager build file for structure _Interpreter_.

###### interpreter-sig.sml : signature file, defines signature _SIGNATURE_.

###### interpreter.sml : defines structure _Interpreter_ is, the implementation file.

### Steps to see this code in action:

* Install SML of New Jersey. (I haven't tested this on other ML97 implementations)

* Clone this repo

* Start the interpreter from inside folder $/SML-COMPILER/CH1 with command 'sml'

* Type 'CM.make "sources.cm";' into the interpreter

* For easy access to the structure, open the structure with 'open Interpreter;'

* For controlled access to the structure, alias the structure with 'structure S = Interpreter;'

* In order to exercise the functionality, you should first learn to build valid expressions
  and statements.

* TODO: write a help function that tells the user how to use this system.

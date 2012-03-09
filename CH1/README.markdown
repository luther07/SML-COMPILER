* Exercise 1a--Implement a member function that returns true if the item is found else false. 
  * Done, see function `lookupbool` in persistent.sml. Still need to write some tests.
* Exercise 1b--Extend the program to include not just membership, but the mapping of keys to bindings.
  * Done, see function `lookup` in persistent.sml. Still need to write some tests.
* Exercise 1c--These trees are not balanced. Demonstrate the behavior on the following two sequences of insertions.
  * t s p i p f b s t:
                    
                     t
                    s
                   p
                  i
                 f
                b

  * a b c d e f g h i:

                     a
                      b
                       c
                        d
                         e
                          f
                           g
                            h
                             i

* Exercise 1d--From Sedgewick[1997], which balanced BST data structure is best for a functional-style symbol table?
  * Randomized BST? Has average-case performance which is an improvement on standard BST's, because standard BST's depend on receiving input for insertion with 
random ordering of their keys, while Randomized BST's do not rely on assumptions about the ordering of the inputs for insertion. Drawbacks include the computational cost of generating a random number upon each insertion and the cost of each node storing the number of nodes in its subtree. 
  * Splay BST?
  * Top-Down 2-3-4 BST?
  * Red-Black Trees?
  * Skip Lists?

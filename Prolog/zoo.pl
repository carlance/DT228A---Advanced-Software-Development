/* At the Zoo */

elephant(george).
elephant(mary).

tiger(woods).
panda(ming_ming).

big_teeth(X) :- tiger(X). 					

big_teeth(X) :- elephant(X).
dangerous(X) :- big_teeth(X).
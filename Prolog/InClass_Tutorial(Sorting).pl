

/*sorting algorithm
- find minimum M
- M is the head of the sorted list
- remove M
*/

find_min([X], X) :- !.
find_min([X,Y|Tail], N):-
    ( X > Y ->
        find_min([Y|Tail], N)
    ;
        find_min([X|Tail], N)
    ).

/*remove an element from a list*/
remove_el([],_,[]).
remove_el([H|T],X,T):- H = X.
remove_el([H|T],X,[H|R1]):- H =\= X, remove_el(T,X,R1).

/*Buble sort*/
bubble_sort([],[]). /*base rule*/
bubble_sort(L,[M|A]):- find_min(L,M), remove_el(L,M,B), bubble(B,A).

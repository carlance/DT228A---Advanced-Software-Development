/*--------------------------------Prolog Assignment -----------------------------------*/
/*-----------------------------Date: December 19' 2015---------------------------------*/
/*--------------------------Carl Lawrence Mariano - C10309107--------------------------*/




/*-------------------------------- Part 2 - Rules-------------------------------- */


/*  1 */

/*print_status([]). */

print_element([]):- /*base rule*/
	put_char('|'), /*put_char writes a character to the current output : see prolog documentation*/
	nl.

print_element([H|T]):-
	put_char('|'),
	put_char(H),
	print_element(T).

print_status([]).

print_status([H|T]):-
	print_element(H),
	print_status(T).



/*  2 */

search_list_element([A|_],X,D):- /*base rule for search_list_element*/
	A = X, /*if X (character) is on the ground then height is 0*/
	D = 0.

search_list_element([A|B],X,D):- /*recursive rule*/
	not(A = X), /*if A (head of list) is not equal to X*/
	search_list_element(B,X,D1), /*call recursive function passing the tail of the list*/
	D is D1 + 1. /*increment height*/

high([A|_],X,H):- /*pass list to rule*/
	member(X,A), /*if X is a member of the list*/
	search_list_element(A,X,H). /*call another predicate passing the head of the list*/ 

high([_|B],X,H):-
	high(B,X,H).



	
	
/*  3 */

element_at_height([],_,_,[]). /*base rule for element_at_height */

element_at_height([H1|_],H,C,L):- /*predicate to find element in list based on height*/
	C = H,					/*if height is same as height required */
	append([],[H1],L).     /*append to current list L*/
	
element_at_height([_|T1],H,C,L):- /*predicate to find element in a list based on height */
	not(C = H), /*if height passed (in this case 0) is not the same as height required*/
	C1 is C + 1,			/*increment height */
	element_at_height(T1,H,C1,L). /*recursive rule until height matches */

search_lists([H1],H,L):- /*base rule for search_lists*/
	C = 0,
	element_at_height(H1,H,C,E),
	append(E,[],L).	/*append to current list L*/

search_lists([H1|T],H,L):- /*predicate to loop through elements of list*/
	C = 0, 					/*initial height*/
	element_at_height(H1,H,C,E), /*this predicate handles head of list */
	search_lists(T,H,L1),
	append(E,L1,L). /*append list E and L1 to L*/

all_same_height(B,H,L):- 
	search_lists(B,H,L).
	
	
	
/* 4 */

height_block([H|_],X,C):- /*base rule for height_block */
	H = X,
	C is 0.

height_block([H|T],X,C):-
	not(H = X),
	height_block(T,X,C1),
	C is C1 + 1.
	
search_block([H1|_],X,C):- /*base rule for search_block*/
	height_block(H1,X,C1),
	C is C1.
	
search_block([_|T],X,C):-
	search_block(T,X,C1),
	C is C1.
	
same_height(B,X,Y):-
	search_block(B,X,C1), /*predicate to find height for X*/
	search_block(B,Y,C2), /*predicate to find height for Y*/
	C1 = C2. /*returns true if height C1 is equal to height C2*/
	
	/*Sample output

	same_height([[b,c,f],[a,d,g],[h,e]],c,d).
	true ;

	same_height([[b,c,f],[a,d,g],[h,e]],c,g).
	false.

	*/
	
/* 5*/

/*This predicate checks and makes sure X is the last element of the list or a top block*/
x_is_end_of_list([H],X):-
	H = X.

x_is_end_of_list([H|T],X):-
	not(H = X),
	x_is_end_of_list(T,X).

is_end_block([H|_],X,S1,C):-
	C1 is  C + 1,
	S1 = C1,
	x_is_end_of_list(H,X).
	
is_end_block([_|T],X,S1,C):-
	C1 is C + 1,
	S1 > C1,
	is_end_block(T,X,S1,C1). 

/*This predicate removes X from the list L containing X in the list of lists B and returns the updated list L*/

remove_last_block([_],L):-
	append([],[],L).

remove_last_block([H|T],L):-
	remove_last_block(T,L1),
	append([H],L1,L).

remove_x([H|_],X,L):- /*this predicate iterates through the list until it finds X */
	member(X,H),		/*if X is found in the list H*/
	remove_last_block(H,L). /*remove element from the list*/
	
remove_x([H|T],X,L):- /*this predicate iterates through the list until it finds X */
	not(member(X,H)),
	remove_x(T,X,L).

/*This predicate adds an element to a list at a specified index*/

insert_at_index([H|T],L,I,B1,J):-
	J1 is J + 1,
	J1\= I,
	insert_at_index(T,L,I,B2,J1),
	append([H],B2,B1).

insert_at_index([_|T],L,I,B1,J):-
	J1 is J + 1,
	J1 = I,
	append([L],T,B1).

/*This predicate adds an element to the end of a list L in the list of lists B and returns only the updated list L*/


add_x([_|T],I,X,L,J):-
	J1 is J + 1,
	not(J1 = I),
	add_x(T,I,X,L,J1).

add_x([H|_],I,X,L,J):-
	J1 is J + 1,
	J1 = I,
	append(H,[X],L).

/*moveblock predicate*/

moveblock(B,X,S1,S2):-
	C is 0,
	is_end_block(B,X,S1,C),
	write('Before:'),
	nl,
	nl,
	print_status(B),
	nl,
	nl,
	remove_x(B,X,L),
	C1 is 0,
	insert_at_index(B,L,S1,B1,C1),	
	C2 is 0,
	add_x(B,S2,X,U,C2),
	insert_at_index(B1,U,S2,B2,C2),
	write('After: '),
	nl,
	nl,
	print_status(B2).



/*---------Part 3 -------------*/

/*didn't have enough time to start and complete this*/




/*order_blocks(S, S_order) :- */
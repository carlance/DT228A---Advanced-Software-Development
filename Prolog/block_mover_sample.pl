/* Part 2 */


/* Question 1 */

print_status([]).

print_status([H|T]):-
	print_element(H),
	print_status(T).

print_element([]):-
	put_char('|'),
	nl.

print_element([H|T]):-
	put_char('|'),
	put_char(H),
	print_element(T).
	


/* Question 2 */

search_list_element([A|B],X,D):-
	A = X,
	D = 0.

search_list_element([A|B],X,D):-
	A \= X,
	search_list_element(B,X,D1),
	D is D1 + 1.

high([A|B],X,H):-
	member(X,A),
	search_list_element(A,X,H).
	
high([A|B],X,H):-
	high(B,X,H).

	
	
/* Question 3 */

element_at_height([H1|T1],H,C,L):-
	C = H,
	append([],[H1],L).

element_at_height([],_,_,[]).
	
element_at_height([H1|T1],H,C,L):-
	C \= H,
	C1 is C + 1,
	element_at_height(T1,H,C1,L).

search_lists([H1],H,L):-
	C = 0,
	element_at_height(H1,H,C,E),
	append(E,[],L).	

search_lists([H1|T],H,L):-
	C = 0,
	element_at_height(H1,H,C,E),
	search_lists(T,H,L1),
	append(E,L1,L).

all_same_height(B,H,L):-
	search_lists(B,H,L).
	
	
	
/* Question 4 */

height_block([H|T],X,C):-
	H = X,
	C is 0.

height_block([H|T],X,C):-
	H \= X,
	height_block(T,X,C1),
	C is C1 + 1.
	
search([H1|T],X,C):-
	height_block(H1,X,C1),
	C is C1.
	
search([H1|T],X,C):-
	search(T,X,C1),
	C is C1.
	
same_height(B,X,Y):-
	search(B,X,C1),
	search(B,Y,C2),
	C1 = C2.
	

	
/*Question 5*/

/*This predicate checks if x is a last element or top block*/
x_is_end_of_list([H],X):-
	H = X.

x_is_end_of_list([H|T],X):-
	H \= X,
	x_is_end_of_list(T,X).

is_end_block([H|T],X,S1,C):-
	C1 is  C + 1,
	S1 = C1,
	x_is_end_of_list(H,X).
	
is_end_block([H|T],X,S1,C):-
	C1 is C + 1,
	S1 > C1,
	is_end_block(T,X,S1,C1).

/*This predicate removes X from the list L containing X in the list 
of lists B and returns the updated list L*/

remove_last_block([H],L):-
	append([],[],L).

remove_last_block([H|T],L):-
	remove_last_block(T,L1),
	append([H],L1,L).

remove_x([H|T],X,L):-
	member(X,H),
	remove_last_block(H,L).
	
remove_x([H|T],X,L):-
	\+member(X,H),
	remove_x(T,X,L).

/*This predicate adds an element to a list at a specified index*/

insert_at_index([H|T],L,I,B1,J):-
	J1 is J + 1,
	J1\= I,
	insert_at_index(T,L,I,B2,J1),
	append([H],B2,B1).

insert_at_index([H|T],L,I,B1,J):-
	J1 is J + 1,
	J1 = I,
	append([L],T,B1).

/*This predicate adds an element to the end of a list L in 
the list of lists B and returns only the updated list L*/

add_x([H|T],I,X,L,J):-
	J1 is J + 1,
	J1 \= I,
	add_x(T,I,X,L,J1).

add_x([H|T],I,X,L,J):-
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
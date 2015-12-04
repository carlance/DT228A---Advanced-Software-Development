flight(london,dublin,aerlingus,500,45,150).
flight(rome,london,ba,1500,150,400).
flight(rome,paris,airfrance,1200,120,500). 
flight(paris,dublin,airfrance,600,60,200).
flight(berlin,moscow,lufthansa,3000,300,900).
flight(paris,amsterdam,airfrance,400,30,100).
flight(berlin,dublin,lufthansa,1200,120,900).
flight(london,newyork,ba,5000,700,1100).
flight(dublin,newyork,aerlingus,4500,360,800).
flight(dublin,cork,ryanair,300,50,50).
flight(dublin,rome,ryanair,2000,150,70).
flight(dublin,chicago,aerlingus,5500,480,890).
flight(amsterdam,hongkong,klm,7000,660,750).
flight(london,hongkong,ba,7500,700,1000).
flight(dublin,amsterdam,ryanair,1000,90,60).
flight(moscow,newyork,aerflot,9000,720,1000).
flight(moscow,hongkong,aerflot,5500,420,500).
flight(newyork,chicago,aa,3000,240,430).
flight(dublin,london,aerlingus,500,45,150).
flight(london,rome,ba,1500,150,400).
flight(paris,rome,airfrance,1200,120,500). 
flight(dublin,paris,airfrance,600,60,200).
flight(moscow,berlin,lufthansa,3000,300,900).
flight(amsterdam,paris,airfrance,400,30,100).
flight(dublin,berlin,lufthansa,1200,120,900).
flight(newyork,london,ba,5000,700,1100).
flight(newyork,dublin,aerlingus,4500,360,800).
flight(cork,dublin,ryanair,300,50,50).
flight(rome,dublin,ryanair,2000,150,70).
flight(chicago,dublin,aerlingus,5500,480,890).
flight(hongkong,amsterdam,klm,7000,660,750).
flight(hongkong,london,ba,7500,700,1000).
flight(amsterdam,dublin,ryanair,1000,90,60).
flight(newyork,moscow,aerflot,9000,720,1000).
flight(hongkong,moscow,aerflot,5500,420,500).
flight(chicago,newyork,aa,3000,240,430).
flight(rome,shannon,aa,3000,240,430).

country(dublin,ireland).
country(cork,ireland).
country(london,uk).
country(rome,italy).
country(moscow,russia).
country(hongkong,china).
country(amsterdam,holland).
country(berlin,germany).
country(paris,france).
country(newyork,usa).
country(chicago,usa).
country(shannon,ireland).


/*Part 1*/

/*Question 1*/

list_airport(X,L):-
	findall(Y,country(Y,X),L).

	

/*Question 2*/

connections(X,Y,T,L):-
	\+member(Y,L),
	flight(X,Y,_,_,_,_),
	append([],[Y],T).

connections(X,Y,T,L):-
	\+member(X,L),
	append([X],L,L1),
	flight(X,Z,_,_,_,_),
	\+member(Z,L),
	connections(Z,Y,T1,L1),
	append([Z],T1,T).
	
trip(X,Y,T):- 
	L = [], 
	connections(X,Y,T1,L), 
	append([X],T1,T).

	
	
/*Question 3*/

all_trip(X,Y,T):-
	findall(T1,trip(X,Y,T1),T).

	
	
/*Question 4*/

get_trip_dist(X,Y,[T,D],L):-
	\+member(Y,L),
	flight(X,Y,_,D,_,_),
	append([],[Y],T).

get_trip_dist(X,Y,[T,D],L):-
	\+member(X,L),
	append([X],L,L1),
	flight(X,Z,_,D1,_,_),
	\+member(Z,L1),
	get_trip_dist(Z,Y,[T1,D2],L1),
	append([Z],T1,T),
	D is D1 + D2.

trip_dist(X,Y,[T,D]):-
	L = [],
	get_trip_dist(X,Y,[T1,D],L),
	append([X],T1,T).
	
	
	
/*Question 5*/

get_trip_cost(X,Y,[T,C],L):-
	\+member(Y,L),
	flight(X,Y,_,_,_,C),
	append([],[Y],T).

get_trip_cost(X,Y,[T,C],L):-
	\+member(X,L),
	append([X],L,L1),
	flight(X,Z,_,_,_,C1),
	\+member(Z,L1),
	get_trip_cost(Z,Y,[T1,C2],L1),
	append([Z],T1,T),
	C is C1 + C2.

trip_cost(X,Y,[T,C]):-
	L = [],
	get_trip_cost(X,Y,[T1,C],L),
	append([X],T1,T).
	
	
	
/*Question 6*/

get_trip_time(X,Y,[T,I],L):-
	\+member(Y,L),
	flight(X,Y,_,_,_,_),
	append([],[Y],T),
	I = 0.

get_trip_time(X,Y,[T,I],L):-
	\+member(X,L),
	append([X],L,L1),
	flight(X,Z,_,_,_,_),
	\+member(Z,L1),
	get_trip_time(Z,Y,[T1,I1],L1),
	append([Z],T1,T),
	I is I1 + 1.

trip_time(X,Y,[T,I]):-
	L = [],
	get_trip_time(X,Y,[T1,I],L),
	append([X],T1,T).
	
	
	
/*Question 7*/
connections_noairline(X,Y,T,A,L):-
	\+member(Y,L),
	flight(X,Y,A1,_,_,_),
	A \= A1,
	append([],[Y],T).

connections_noairline(X,Y,T,A,L):-
	\+member(X,L),
	append([X],L,L1),
	flight(X,Z,A1,_,_,_),
	A \= A1,
	\+member(Z,L),
	connections_noairline(Z,Y,T1,A,L1),
	append([Z],T1,T).
	
trip_noairline(X,Y,T,A):- 
	L = [], 
	connections_noairline(X,Y,T1,A,L), 
	append([X],T1,T).

all_trip_noairline(X,Y,T,A):-
	findall(T1,trip_noairline(X,Y,T1,A),T).
	

	
/*Question 8*/

min_C_value([[T1|C1]],T1,C1).

min_C_value([[T1|C1]|X],T,C):-
	min_C_value(X,T2,C2),
	C is min(C1,C2),
	C1 =< C2,
	T = T1.
	
min_C_value([[T1|C1]|X],T,C):-
	min_C_value(X,T2,C2),
	C is min(C1,C2),
	C2 =< C1,
	T = T2.

cheapest(X,Y,T,C):-
	findall(W,trip_cost(X,Y,W),L),
	min_C_value(L,T,C).
	
shortest(X,Y,T,C):-
	findall(W,trip_dist(X,Y,W),L),
	min_C_value(L,T,C).

trip_minutes(X,Y,[T,I],L):-
	\+member(Y,L),
	flight(X,Y,_,_,I1,_),
	append([],[Y],T),
	I is I1.

trip_minutes(X,Y,[T,I],L):-
	\+member(X,L),
	append([X],L,L1),
	flight(X,Z,_,_,I1,_),
	\+member(Z,L1),
	trip_minutes(Z,Y,[T1,I2],L1),
	append([Z],T1,T),
	I is I1 + I2.

trip_time_minutes(X,Y,[T,I]):-
	L = [],
	trip_minutes(X,Y,[T1,I],L),
	append([X],T1,T).
	
fastest(X,Y,T,C):-
	findall(W,trip_time_minutes(X,Y,W),L),
	min_C_value(L,T,C).

	
	
/*Question 9*/

trip_to_city(X,[H|E],T1):-
	trip(X,H,T1).
	
trip_to_city(X,[H|E],T1):-
	trip_to_city(X,E,T1).

trip_to_city(X,[H],T1):-
	trip(X,H,T1).
	
trip_to_nation(X,Y,T):-
	list_airport(Y,L),
	trip_to_city(X,L,T1),
	append([],T,T1).	
	


/* Question 10 */

all_trip_to_nation(X,Y,T):-
	findall(L, (trip_to_nation(X,Y,L)), T).

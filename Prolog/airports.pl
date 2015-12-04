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
flight(dublin,sao_paulo,airfrance,10000,900,800).
flight(sao_paulo,newyork,airfrance,7000,840,650).
flight(rio,berlin,lufthansa,11000,1200,1100).

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
country(sao_paulo,brazil).
country(rio,brazil).

/*<-------------------------------Part1----------------------------->*/

/*<-------------------------------Rules----------------------------->*/

/*1 */ list_airport(Y,L) :- findall(X, country(X,Y),L).



/*2*/
trip(X,Y,T) :- trip_helper(X,Y,[X,Y],T).
trip_helper(X,Y,_,[X,Y]) :- flight(X,Y,_,_,_,_).
trip_helper(X,Y,V,[X|T]) :- flight(X,Z,_,_,_,_),
					 not(member(Z,V)),
				     trip_helper(Z,Y,[Z|V],T).



/*3*/
all_trip(X,Y,T) :- findall(A,trip(X,Y,A),T).

/*4*/

dist([X,Y],D):- flight(X,Y,_,D,_,_).

dist([X,Y|T],D) :- flight(X,Y,_,D1,_,_),
					dist([Y|T],D2),
					D is D1 + D2.

trip_dist(X,Y,[T,D]) :- trip(X,Y,T),
						dist(T,D).


/*5*/
cost([X,Y],C):- flight(X,Y,_,_,_,C).

cost([X,Y|T],C) :- flight(X,Y,_,_,_,C1),
					cost([Y|T],C2),
					C is C1 + C2.

trip_cost(X,Y,[T,C]) :- trip(X,Y,T),
						cost(T,C).

/*6*/
trip_time(X,Y,[T,I]) :- trip(X,Y,T),
						length(T,A),
						I is A - 2.


/*7*/

noairline([X,Y],A) :- flight(X,Y,A1,_,_,_),
						not(A = A1).
			
noairline([X,Y|T],A) :- flight(X,Y,A1,_,_,_),
						not(A = A1),
					    noairline([Y|T],A).

all_trip_noairline(X,Y,T,A) :- trip(X,Y,T),
							   noairline(T,A).
						

/*8*/

/*-------<Head with two elements of type list>---------*/
/*--------[    X      ,	     Y   ]------|Tail]--------------------*/
/*--------[List, Cost],[List, Cost]-----------------------*/
/*-----------Compare two elements with each other based on costs-------*/

find_min([M],M). 

find_min([[_  ,  C1],[H2 ,  C2] 		|T],M) :-   C1 > C2,
												    find_min([[H2,C2]|T],M).
												   

find_min([[H1 ,  C1],[_  ,  C2]			|T],M) :- 	C1 =< C2, 
													find_min([[H1,C1]|T],M). 


      			
cheapest(X,Y,T,C) :-  findall(A,trip_cost(X,Y,A),T1), find_min(T1,[T,C]). 


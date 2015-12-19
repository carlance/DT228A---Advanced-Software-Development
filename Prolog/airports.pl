/*--------------------------------Prolog Assignment -----------------------------------*/
/*-----------------------------Date: December 19' 2015---------------------------------*/
/*--------------------------Carl Lawrence Mariano - C10309107--------------------------*/


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

/*<-------------------------------Part 1 - Rules----------------------------->*/

/*1 */ list_airport(X,L) :- findall(Y, country(Y,X),L).



/*2*/
trip_helper(X,Y,_,[X,Y]) :- flight(X,Y,_,_,_,_). /*direct flight, base rule*/ 



trip_helper(X,Y,V,[X|T]) :- flight(X,Z,_,_,_,_),
					 not(member(Z,V)), /* if city is not yet in the list, then add it */
				     trip_helper(Z,Y,[Z|V],T). /*call rule recursively*/

trip(X,Y,T) :- trip_helper(X,Y,[X,Y],T). /*gets connecting flights*/




/*3*/
all_trip(X,Y,T) :- findall(A,trip(X,Y,A),T).


/*4*/

dist([X,Y],D):- flight(X,Y,_,D,_,_).

dist([X,Y|T],D) :- flight(X,Y,_,D1,_,_),
					dist([Y|T],D2),
					D is D1 + D2.

trip_dist(X,Y,[T,D]) :- trip(X,Y,T),
						dist(T,D).

/*Sample Output
 trip_dist(rome,dublin,D).
D = [[rome, dublin], 2000] ;
D = [[rome, london, dublin], 2000] ;
D = [[rome, london, newyork, dublin], 11000] ;
D = [[rome, london, newyork, chicago, dublin], 15000] ;
D = [[rome, london, newyork, moscow, hongkong, amsterdam, dublin], 29000] ;
D = [[rome, london, newyork, moscow, hongkong, amsterdam, paris, dublin], 29000] ;
D = [[rome, london, newyork, moscow, berlin, dublin], 19700] ;
D = [[rome, london, hongkong, amsterdam, dublin], 17000] ;
D = [[rome, london, hongkong, amsterdam, paris, dublin], 17000] ;
D = [[rome, london, hongkong, moscow, newyork, dublin], 28000] ;
D = [[rome, london, hongkong, moscow, newyork, chicago, dublin], 32000] ;
D = [[rome, london, hongkong, moscow, berlin, dublin], 18700] ;
D = [[rome, paris, dublin], 1800] ;
D = [[rome, paris, amsterdam, dublin], 2600] ;
D = [[rome, paris, amsterdam, hongkong, london, dublin], 16600] ;
D = [[rome, paris, amsterdam, hongkong, london, newyork, dublin], 25600] ;
D = [[rome, paris, amsterdam, hongkong, london, newyork, chicago, dublin], 29600] ;
D = [[rome, paris, amsterdam, hongkong, london, newyork, moscow, berlin|...], 34300] ;
D = [[rome, paris, amsterdam, hongkong, moscow, newyork, dublin], 27600] ;
D = [[rome, paris, amsterdam, hongkong, moscow, newyork, chicago, dublin], 31600] ;
D = [[rome, paris, amsterdam, hongkong, moscow, newyork, london, dublin], 28600] ;
D = [[rome, paris, amsterdam, hongkong, moscow, berlin, dublin], 18300] ;
*/


/*5*/
cost([X,Y],C):- flight(X,Y,_,_,_,C).

cost([X,Y|T],C) :- flight(X,Y,_,_,_,C1),
					cost([Y|T],C2),
					C is C1 + C2.

trip_cost(X,Y,[T,C]) :- trip(X,Y,T),
						cost(T,C).

/* Sample Output
 trip_cost(rome,dublin,C).
C = [[rome, dublin], 70] ;
C = [[rome, london, dublin], 550] ;
C = [[rome, london, newyork, dublin], 2300] ;
C = [[rome, london, newyork, chicago, dublin], 2820] ;
C = [[rome, london, newyork, moscow, hongkong, amsterdam, dublin], 3810] ;
C = [[rome, london, newyork, moscow, hongkong, amsterdam, paris, dublin], 4050] ;
C = [[rome, london, newyork, moscow, berlin, dublin], 4300] ;
C = [[rome, london, hongkong, amsterdam, dublin], 2210] ;
C = [[rome, london, hongkong, amsterdam, paris, dublin], 2450] ;
C = [[rome, london, hongkong, moscow, newyork, dublin], 3700] ;
C = [[rome, london, hongkong, moscow, newyork, chicago, dublin], 4220] ;
C = [[rome, london, hongkong, moscow, berlin, dublin], 3700] ;
C = [[rome, paris, dublin], 700] ;
C = [[rome, paris, amsterdam, dublin], 660] ;
C = [[rome, paris, amsterdam, hongkong, london, dublin], 2500] ;
C = [[rome, paris, amsterdam, hongkong, london, newyork, dublin], 4250] ;
C = [[rome, paris, amsterdam, hongkong, london, newyork, chicago, dublin], 4770] ;
C = [[rome, paris, amsterdam, hongkong, london, newyork, moscow, berlin|...], 6250] ;
C = [[rome, paris, amsterdam, hongkong, moscow, newyork, dublin], 3650] ;
C = [[rome, paris, amsterdam, hongkong, moscow, newyork, chicago, dublin], 4170] ;
C = [[rome, paris, amsterdam, hongkong, moscow, newyork, london, dublin], 4100] ;
C = [[rome, paris, amsterdam, hongkong, moscow, berlin, dublin], 3650] ;
*/

/*6*/
trip_time(X,Y,[T,I]) :- trip(X,Y,T),
						length(T,A),
						I is A - 2. /*ignore the first and last trip in the list*/

/*Sample Output
trip_time(rome,dublin,T).
T = [[rome, dublin], 0] ;
T = [[rome, london, dublin], 1] ;
T = [[rome, london, newyork, dublin], 2] ;
T = [[rome, london, newyork, chicago, dublin], 3] ;
T = [[rome, london, newyork, moscow, hongkong, amsterdam, dublin], 5] ;
T = [[rome, london, newyork, moscow, hongkong, amsterdam, paris, dublin], 6] ;
T = [[rome, london, newyork, moscow, berlin, dublin], 4] ;
T = [[rome, london, hongkong, amsterdam, dublin], 3] ;
T = [[rome, london, hongkong, amsterdam, paris, dublin], 4] ;
T = [[rome, london, hongkong, moscow, newyork, dublin], 4] ;
T = [[rome, london, hongkong, moscow, newyork, chicago, dublin], 5] ;
T = [[rome, london, hongkong, moscow, berlin, dublin], 4] ;
T = [[rome, paris, dublin], 1] ;
T = [[rome, paris, amsterdam, dublin], 2] ;
T = [[rome, paris, amsterdam, hongkong, london, dublin], 4] ;
T = [[rome, paris, amsterdam, hongkong, london, newyork, dublin], 5] ;
T = [[rome, paris, amsterdam, hongkong, london, newyork, chicago, dublin], 6] ;
T = [[rome, paris, amsterdam, hongkong, london, newyork, moscow, berlin|...], 7] ;
T = [[rome, paris, amsterdam, hongkong, moscow, newyork, dublin], 5] ;
T = [[rome, paris, amsterdam, hongkong, moscow, newyork, chicago, dublin], 6] ;
T = [[rome, paris, amsterdam, hongkong, moscow, newyork, london, dublin], 6] ;
T = [[rome, paris, amsterdam, hongkong, moscow, berlin, dublin], 5] ;
*/

/*7*/

noairline([X,Y],A) :- flight(X,Y,A1,_,_,_),
						not(A = A1).
			
noairline([X,Y|T],A) :- flight(X,Y,A1,_,_,_),
						not(A = A1),
					    noairline([Y|T],A).

all_trip_noairline(X,Y,T,A) :- trip(X,Y,T),
							   noairline(T,A).

/*	Sample Output						   
 all_trip_noairline(rome,dublin,T,ryanair).
T = [rome, london, dublin] ;
T = [rome, london, newyork, dublin] ;
T = [rome, london, newyork, chicago, dublin] ;
T = [rome, london, newyork, moscow, hongkong, amsterdam, paris, dublin] ;
T = [rome, london, newyork, moscow, berlin, dublin] ;
T = [rome, london, hongkong, amsterdam, paris, dublin] ;
T = [rome, london, hongkong, moscow, newyork, dublin] ;
T = [rome, london, hongkong, moscow, newyork, chicago, dublin] ;
T = [rome, london, hongkong, moscow, berlin, dublin] ;
T = [rome, paris, dublin] ;
T = [rome, paris, amsterdam, hongkong, london, dublin] ;
T = [rome, paris, amsterdam, hongkong, london, newyork, dublin] ;
T = [rome, paris, amsterdam, hongkong, london, newyork, chicago, dublin] ;
T = [rome, paris, amsterdam, hongkong, london, newyork, moscow, berlin, dublin] ;
T = [rome, paris, amsterdam, hongkong, moscow, newyork, dublin] ;
T = [rome, paris, amsterdam, hongkong, moscow, newyork, chicago, dublin] ;
T = [rome, paris, amsterdam, hongkong, moscow, newyork, london, dublin] ;
T = [rome, paris, amsterdam, hongkong, moscow, berlin, dublin] ;
*/						

/*8*/	


/*-------<Head with two elements of type list>---------*/
/*--------[    X      ,	     Y   ]------|Tail]--------------------*/
/*--------[List, Cost],[List, Cost]-----------------------*/
/*-----------Compare two elements with each other based on costs or time or distance-------*/
/*---------Rule has been given some spaces for readability purposes---------------------*/

find_min([M],M). /*base rule*/

/*If first element is greater than second element, pass second element along with tail to rule and call recursive function*/
find_min( [[_  ,  C1],[H2 ,  C2] 		|T], M) :-   C1 > C2,	
												    find_min([[H2,C2]|T],M).
												   
/*If second element is greater than first element, pass first element along with tail to rule and call recursive function*/
find_min( [[H1 ,  C1],[_  ,  C2]		|T], M) :- 	C1 =< C2, 
													find_min([[H1,C1]|T],M). 


      			
cheapest(X,Y,T,C) :-  findall(A,trip_cost(X,Y,A),T1), find_min(T1,[T,C]). 

/* Sample Output
cheapest(rome,dublin,T,C).
T = [rome, dublin],
C = 70 ;
*/

shortest(X,Y,T,C) :-  findall(A,trip_dist(X,Y,A),T1), find_min(T1,[T,C]). 

/* Sample Output
shortest(rome,dublin,T,D).
T = [rome, paris, dublin],
D = 1800 ;
*/

fastest(X,Y,T,C) :-  findall(A,trip_time(X,Y,A),T1), find_min(T1,[T,C]). 

/* Sample Output
fastest(rome,dublin,T,T1).
T = [rome, dublin],
T1 = 0 ; 
*/


/*9*/
trip_to_city(X,[Head|_],T1):- trip(X,Head,T1). /*base rule*/
								

trip_to_city(X,[_|Rest],T1):- trip_to_city(X,Rest,T1). /*recursive rule */
	

trip_to_nation(X,Y,T) :-	list_airport(Y,L), /*get list of airports in country*/
							trip_to_city(X,L,T). /*pass city and list of airports in country to predicate*/
												 /*	and return list T*/


/*10*/
all_trip_to_nation(X,Y,T):-	findall(L, (trip_to_nation(X,Y,L)), T).
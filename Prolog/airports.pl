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

/*<-------------------------------Rules----------------------------->*/

/*1 */ list_airport(Y,L) :- findall(X, country(X,Y),L). 




/*2*/

/*trip1(Source,Destination,T) :- final_trip(Source,Destination,T,[]).



final_trip(Source,Destination,[Source|T],Visited) :- flight(Source,Z,_,_,_,_),
						  							   not(member(Z,Visited)),
				   		  							   final_trip(Z,Destination,T,[Z|Visited]). 

final_trip(Source,Source,[Source],_). */





% get a path from start to end
trip(X,Y,T) :- trip(X,Y,[X],T).

% when target reached, reverse the visited list
trip(Y,Y,R,T) :- reverse(R,T).

% take non deterministically an edge, check if already visited before use
trip(X,Y,Visited,T) :- flight(X,Z,_,_,_,_),
				  not(member(Z,Visited)),
				  trip(Z,Y,[Z|Visited],T).

 


/*3*/
all_trip(Source,Destination,T) :- final_trip2(Source,Destination,T,[]).

final_trip2(Source,Source,[Source],_). 

final_trip2(Source,Destination,[Source|T],Visited) :- flight(Source,Z,_,_,_,_),
						  							   not(member(Z,Visited)),
				   		  							final_trip2(Z,Destination,T,[Z|Visited]).

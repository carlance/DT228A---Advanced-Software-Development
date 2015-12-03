/*------------------------------Use of List or Array in Java in Prolog-------------------*/

/*base rule using the ! - cut operation*/
/*! operation prevents printing out all solutions for a rule*/
factorial(0,1):- !. 

factorial(N,R):- N1 is N-1,
			factorial(N1,R1),
			R is R1*N.


power(_,0,1). /*base rule for power of a number*/

/*calculates power of a number*/
power(X,N,Z) :- N>=0, 
				N1 is N - 1,
              	power(X,N1,Z1), 
              	Z is Z1*X,  	
              	writeln(Z).


/*base rule for printing out list, use something like showlist([1,2,3,4,5]).*/
 showlist([]). 
 
 showlist([Head|Tail]) :- writeln(Head), /*rule for printing out list in order*/
        				showlist(Tail).

/*rule for printing out list in reverse order*/
reverselist([]).

 reverselist([Head|Tail]) :- reverselist(Tail), 
 							 writeln(Head).
        				

/*Filtering a list - Question 20 on worksheet*/

filter_list([],_,[]). /*base rule*/

filter_list([Head|Tail],N,F):- Head =< N,
							filter_list(Tail,N,F1),
							append([Head],F1,F).



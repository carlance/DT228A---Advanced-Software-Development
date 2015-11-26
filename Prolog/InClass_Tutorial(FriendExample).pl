d_friend(mark,john).
d_friend(michael,john).
d_friend(john,paul).
d_friend(john,mary).
d_friend(john,kevin).
d_friend(john,matthew).
d_friend(kevin,jose).
d_friend(jose,matthew).
d_friend(katja,gelato).
d_friend(gelato,matthew).

friend(X,Y) :- d_friend(X,Y). /*base rule*/

friend(X,Y) :-
	d_friend(X,Z),
	d_friend(Z,Y).


/*Extend lfriend(X,Y,Z)
where l is length
Z is distance

example lfriend(john,Y,Z)
Y=paul, Z=1;

incrementing X is Y+1
not X is X+1 -> prolog does not recognize this as same
		variable. Has to be different variable
*/

/*To find number of count when you have a direct friend. Base Rule*/
lfriend(X,Y,1):- d_friend(X,Y). /*output something like lfriend(mark,john,X)*/
					
/*To find number of count per friend of friend lfriend(mark,X,D)*/
lfriend(X,Y,D):- d_friend(X,Z),
				lfriend(Z,Y,D1), 
				D is D1 + 1.
				/*write(D).*/

/*Base rule*/
shownumber(0) :- writeln(0).

/*Outputs number from 0.....N e.g. shownumber(5) would output 0,1,2,3,4,5*/
shownumber(N) :- N1 is N - 1,
				N > 0,
				shownumber(N1),
				writeln(N).

/*loop(N) :- between(1,N,X),
				writeln(X),
				false.*/
				
			
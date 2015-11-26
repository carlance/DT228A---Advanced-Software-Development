/*Facts*/
male(fred).
male(john).
male(harry).
male(mark).
dark(fred).
dark(harry).
dark(john).
dark(mark).


female(mary).
female(julie).
female(susan).
female(anne).

owns(fred,gold).
owns(john,car).
owns(julie,gold).
owns(john,gold).
owns(anne,house).

blonde(julie).
blonde(susan).
blonde(john).
brunette(mary).
brunette(anne).
rich(fred).
rich(mark).

/*Rules*/
likes(john,Person) :- 
female(Person),
blonde(Person),
rich(Person).

likes(fred,Person) :- 
female(Person),
brunette(Person).

likes(harry,Person) :-
female(Person),
rich(Person).

likes(mary,Person) :-
male(Person),
dark(Person).

likes(julie,Person) :-
male(Person),
dark(Person),
rich(Person).

/*rich(Person) :-
owns(Person,gold).*/


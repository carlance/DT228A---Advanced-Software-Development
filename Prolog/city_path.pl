path(chicago,atlanta).
path(chicago,milwaukee).
path(milwaukee,detroit).
path(milwaukee,newyork).
path(chicago,detroit).
path(detroit, newyork).
path(newyork, boston).
path(atlanta,boston).
path(atlanta, milwaukee).


routing(FromCity, ToCity, [FromCity, ToCity]) :-
  path(FromCity, ToCity).

routing(FromCity, ToCity, [FromCity|Connections]) :- 
  path(FromCity, ToConnection),
  routing(ToConnection, ToCity, Connections).
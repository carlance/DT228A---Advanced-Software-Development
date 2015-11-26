weather(phoenix,hot,summer).
weather(la,warm,summer).
weather(sf,cold,winter).
weather(dublin,hot,summer).

warmer_than(C1,C2):-
	weather(C1,hot,summer),
	weather(C2,warm,summer),
	format('~w is warmer than ~w ~n',[C1,C2]).
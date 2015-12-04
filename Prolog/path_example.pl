edge(x, y).
edge(y, t).
edge(t, z).
edge(y, z).
edge(x, z).

% get a path from start to end
path(Start, End, Path) :-
    path(Start, End, [Start], Path).

% when target reached, reverse the visited list
%path(End, End, RPath, Path) :-
%    reverse(RPath, Path).

% take non deterministically an edge, check if already visited before use
path(Start, End, Visited, Path) :-
    edge(Start, Next),
    \+ memberchk(Next, Visited),
    path(Next, End, [Next|Visited], Path).


    
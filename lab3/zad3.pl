%wstaw w nieparzyste
wstaw_nieparz(X, List, [X|List]).
wstaw_nieparz(X, [H1,H2|List1], [H1,H2|List2]) :-
	wstaw_nieparz(X, List1, List2).

%wstaw w parzyste
wstaw_parz(X, [H|List], [H,X|List]).
wstaw_parz(X, [H1,H2|List1], [H1,H2|List2]) :-
	wstaw_parz(X, List1, List2).

%parzysta permutacja to
even_permutation([], []).
%wstaw w nieparzyste miejsce parzystej permutacji lub
even_permutation([X|T], Perm) :-
	even_permutation(T, PermPrim),
	wstaw_nieparz(X, PermPrim, Perm).
%w nieparzyste miejsce parzystej permutacji
even_permutation([X|T], Perm) :-
	odd_permutation(T, PermPrim),
	wstaw_parz(X, PermPrim, Perm).

%analogicznie nieparzysta permutacja to wstaw w nieparzyste miejsca nieparzystej permutacji
odd_permutation([X|T], Perm) :-
	odd_permutation(T, PermPrim),
	wstaw_nieparz(X, PermPrim, Perm).
%lub parzyste miejsca parzystej permutacji
odd_permutation([X|T], Perm) :-
	even_permutation(T, PermPrim),
	wstaw_parz(X, PermPrim, Perm).

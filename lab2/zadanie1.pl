
deleteLast([_], []):- !.
deleteLast([H|T], [H|T1]):-
	deleteLast(T, T1).

srodkowy([X], X).
srodkowy([H|T], X):-
	deleteLast(T, T2),
	srodkowy(T2, X).

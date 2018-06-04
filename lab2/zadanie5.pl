stworz(N, L) :-
	findall(Num, between(1, N, Num), L).%numlist(1,N,L).

permutuj([],[]).
permutuj([H|T],L) :- 
	permutuj(T,L1), select(H,L,L1).

lacz([H1|T1], [H2|T2], [H1, H2|T]) :- !, lacz(T1, T2, T).
lacz([], R, R) :- !.
lacz(R, [], R).

lista(N,X):-
	stworz(N,L1),
	permutuj(L1, L2),
	lacz(L1,L2,X).

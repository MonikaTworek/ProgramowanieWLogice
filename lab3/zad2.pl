max_sum([],0).
max_sum([H|L], Sum) :-
	max_sum(L, H, H, Sum).

max_sum([],_,Sum,Sum).

max_sum([First|T],Wyn,Max,Sum):-
	(Wyn > 0 -> Wyn2 is Wyn + First; Wyn2 is First),
	(Wyn2 > Max -> Max2 is Wyn2; Max2 is Max),
	max_sum(T,Wyn2, Max2, Sum).

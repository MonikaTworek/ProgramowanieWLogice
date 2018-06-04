%jednokrotnie(X, L):-
%	append(H,[X|T],L),
%	\+ member(X, H),
%	\+ member(X, T).

%dwukrotnie(X, L):-
%	append(H,[X|T],L),
%	\+ member(X, H),
%	jednokrotnie(X, T).


%%%%% wersja druga - poprawione
jednokrotnie(X,L) :-
	select(X, L, Lprim),
	\+ member(X, Lprim).

dwukrotnie(X, L) :-
	select(X, L, Lprim),
	select(X, Lprim, Lbis),
	\+ member(X, Lbis).


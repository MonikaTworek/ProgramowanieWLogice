osiagalny(A,B) :- path(A,B, []).
path(A,A, _).
path(A,B, V) :-
	arc(A,X),
	\+ member(X,V),
	path(X, B, [A|V]).

arc(a,b).
arc(b,a).
arc(b,c).
arc(c,d).

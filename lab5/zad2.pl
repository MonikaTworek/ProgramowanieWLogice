board(L) :- 
	length(L, N), 
	NN is N+1,
	(NN mod 2 =:= 0 -> board(1, 1, NN, L, 0, czarny); board(1, 1, NN, L, 0, bialy)).

board(N, N, N, _, _, _) :-
    write("+").

board(X,Y, N, L, 0, Kolor) :-
    X < N,
    Y < N,
    write("+-----"),
    XX is X+1,
    board(XX, Y, N, L, 0, Kolor).

board(N, Y, N, L, 0, Kolor) :-
    Y<N,
    write("+"),
    (nl(),
    board(1, Y, N, L, 1, Kolor)),
    (nl(),
    board(1, Y, N, L, 2, Kolor)),
    zmien(Kolor, KKolor),
    YY is Y+1,
    nl(),
    board(1, YY, N, L, 0, KKolor).
    
board(X, Y, N, L, Z, bialy) :-
    X<N,
    Y<N,
    (Z = 1; Z = 2),
    (at(Y, X, L) ->
    write("| ### ");
    write("|     ")),
    XX is X+1,
    board(XX, Y, N, L, Z, czarny).
    
board(X, Y, N, L, Z, czarny) :-
    X<N,
    Y<N,
    (Z = 1; Z = 2),
    (at(Y, X, L) ->
    write("|:###:");
    write("|:::::")),
    XX is X+1,
    board(XX, Y, N, L, Z, bialy).

board(N, Y, N, _, Z, _) :-
    Y<N,
    (Z = 1; Z = 2),
    write("|").

board(X, N, N, _, _, _) :-
    X < N,
    write("+-----"),
    XX is X+1,
    board(XX, N, N, _, _, _).

at(1,X,[X|_]).
at(N,X,[_|T]) :-
    N > 1,
    NN is N-1,
    at(NN, X, T).

zmien(czarny, bialy).
zmien(bialy, czarny).

perm([], []).
perm(L1, [X | L3]) :-
	select(X, L1, L2),
	perm(L2, L3).

dobra(X) :-
	\+ zla(X).

zla(X) :-
	append(_, [Wi | L1], X),
	append(L2, [Wj | _], L1),
	length(L2, K),
	abs(Wi - Wj) =:= K+1.

hetmany(N, P) :-
	numlist(1, N, L),
	perm(L, P),
	dobra(P).

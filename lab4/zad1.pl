dzialanie(X, Y, V, ' + ') :- V is X + Y.
dzialanie(X, Y, V, ' - ') :- V is X - Y.
dzialanie(X, Y, V, ' * ') :- V is X * Y.
dzialanie(X, Y, V, ' / ') :- \+ Y = 0, \+ Y = 1, M is X mod Y, M = 0, V is X // Y.

drzewo([], _, _) :- !, fail.
drzewo([X|[]], value(X), X).
drzewo(Xs, tree(Op, TLeft, TRight), Val) :-
    append(L, R, Xs),
    L \= Xs, drzewo(L, TLeft, V1),
    R \= Xs, drzewo(R, TRight, V2),
    dzialanie(V1, V2, Val, Op).

wTekst(Lewa, Znak, Prawa, Wyrazenie) :-
    concat('(', Lewa, H1),
    concat(H1, Znak, H2),
    concat(H2, Prawa, H3),
    concat(H3,')', Wyrazenie).

buduj(value(X), X).
buduj(tree(Op, TLeft, TRight), Txt) :-
    buduj(TLeft, TL),
    buduj(TRight, TR),
    wTekst(TL, Op, TR, Txt).

wyrazenie(Lista, Wartosc, Wyrazenie) :-
    drzewo(Lista, Drzewo, Wartosc),
    buduj(Drzewo, Wyrazenie).

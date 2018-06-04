browse(Term) :-
    prompt(X, 'command: '),
    browse(Term, [1]),
    prompt(_, X).

browse(_, []).

browse(Term, Pos) :-
    Pos \= [],
    startPrint(Term, Pos),
    nl(),
    read(Cmd),
    nl(),
    changePos(Term, Cmd, Pos, PPos),
    browse(Term, PPos).

isGood(X) :-
	member(X, [i,o,n,p]),!.

changePos(_, Cmd, L, L) :-
    \+ isGood(Cmd).

changePos(_, o, [1], []).

changePos(_, o, [_|L], L).

changePos(Term, i, L, [1|L]) :-
    reverse([1|L], [1|LL]),
    isPossible(Term, LL).

changePos(Term, i, L, L) :-
    reverse([1|L], [1|LL]),
    \+ isPossible(Term, LL).

changePos(Term, n, [H|L], [HH|L]) :-
    HH is H+1,
    reverse([HH|L], [1|LL]),
    isPossible(Term, LL).

changePos(Term, n, [H|L], [H|L]) :-
    HH is H+1,
    reverse([HH|L], [1|LL]),
    \+ isPossible(Term, LL).

changePos(Term, p, [H|L], [HH|L]) :-
    HH is H-1,
    reverse([HH|L], [1|LL]),
    isPossible(Term, LL).

changePos(Term, p, [H|L], [H|L]) :-
    HH is H-1,
    reverse([HH|L], [1|LL]),
    \+ isPossible(Term, LL).

isPossible(_, []).

isPossible(Term, [H|T]) :-
    functor(Term, _, Amount),
    H =< Amount,
    Term =.. [_ | A],
    at(H, TTerm, A),
    isPossible(TTerm, T).


startPrint(Term, Pos) :-
    reverse(Pos, [1|PPos]),
    printTerm(Term, PPos).

printTerm(Term, []) :-
    print(Term).

printTerm(Term, [H|T]) :-
    Term =.. [_ | A],
    at(H, TTerm, A),
    printTerm(TTerm, T).


at(1, H, [H|_]).
at(N, X, [_|T]) :-
    N > 1,
    NN is N-1,
    at(NN, X, T).

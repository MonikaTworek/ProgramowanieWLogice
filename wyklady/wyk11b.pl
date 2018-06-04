hetmany(N, P) :-
    fd_set_vector_max(N),
    length(P, N),
    fd_domain(P, 1, N),
    fd_all_different(P),
    safe(P),
    fd_labeling(P, [variable_method(ff), value_method(middle)]).

safe([]).
safe([_]).
safe([A, B | L]) :-
    safe([B | L], A, 1),
    safe([B | L]).

safe([], _, _).
safe([B | L], A, K) :-
    B - A #\= K,
    A - B #\= K,
    K1 is K + 1,
    safe(L, A, K1).

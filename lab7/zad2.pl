:- ['zad1.pl'].

split(In, Out1, Out2) :-
    split(In, Out1, 0, Out2, 0).


split(In, Out1, Count1, Out2, Count2) :-
    freeze(In,
        (In = [H | T]
        -> (
            (Count1 > Count2)
            -> Next_Count2 is Count2 + 1,
            Out2 = [H | Rest],
            split(T, Out1, Count1, Rest, Next_Count2)
            ; Next_Count1 is Count1 + 1,
            Out1 = [H | Rest],
            split(T, Rest, Next_Count1, Out2, Count2)
        )
        ; (Out1 = [], Out2 = [])
    )).

merge_sort(In, Out) :-
    split(In, P1, P2),
    freeze(P2, (
        P2 = [_ | _]
        -> freeze(P1, (
            merge_sort(P1, O1)
        )),
        merge_sort(P2, O2)
        ; Out = P1
    )),
    merge(O1, O2, Out).


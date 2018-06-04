merge(In1, In2, Out) :-
    when((nonvar(In1), nonvar(In2)), (
        (In1 = [H1 | T1], In2 = [H2 | T2])
        -> (
            (H1 < H2)
            -> (Out = [H1 | Init], merge(T1, In2, Init))
            ; (Out = [H2 | Init], merge(In1, T2, Init))
        )
        ; (In1 = [H1 | T1], In2 = [])
        -> (
            (Out = [H1 | Init], merge(T1, In2, Init))
        )
        ; (In1 = [], In2 = [H2 | T2])
        -> (
            (Out = [H2 | Init], merge(In1, T2, Init))
        )
        ; Out = []
    )).

filozof(Lewy, Prawy, Numer) :-
    myslenie(Numer),
    spaces(Numer, Prefiks),
    concat(Prefiks, "chce prawy wideled\n", K1),
    write(K1),
    mutex_trylock(Prawy)
    -> (
        concat(Prefiks, "podnosi prawy wideled\n", K2),
        write(K2),
        concat(Prefiks, "chce lewy wideled\n", K3),
        write(K3),
        mutex_trylock(Lewy)
        -> (
            concat(Prefiks, "podnosi lewy wideled\n", K4),
            write(K4),
            jedzenie(Numer),
            concat(Prefiks, "odklada lewy wideled\n", K5),
            write(K5),
            mutex_unlock(Lewy),
            concat(Prefiks, "odklada prawy wideled\n", K6),
            write(K6),
            mutex_unlock(Prawy),
            filozof(Lewy, Prawy, Numer)
        )
        ; (
        concat(Prefiks, "odklada prawy wideled\n", K7),
        write(K7),
        mutex_unlock(Prawy),
        filozof(Lewy, Prawy, Numer)
        )
    )
    ; filozof(Lewy, Prawy, Numer).

filozofowieprim :-
    mutex_create(M1),
    mutex_create(M2),
    mutex_create(M3),
    mutex_create(M4),
    mutex_create(M5),
    thread_create(filozof(M5, M1, 1), T1, []),
    thread_create(filozof(M1, M2, 2), T2, []),
    thread_create(filozof(M2, M3, 3), T3, []),
    thread_create(filozof(M3, M4, 4), T4, []),
    thread_create(filozof(M4, M5, 5), T5, []),
    thread_join(T1, _),
    thread_join(T2, _),
    thread_join(T3, _),
    thread_join(T4, _),
    thread_join(T5, _).

myslenie(Numer) :-
    spaces(Numer, Tekst),
    concat(Tekst, "mysli\n", Komunikat),
    write(Komunikat).

jedzenie(Numer) :-
    spaces(Numer, Tekst),
    concat(Tekst, "je\n", Komunikat),
    write(Komunikat).

spaces(Number, Wynik) :-
    spaces(Number, 0, "", Wynik).

spaces(Number, Number, Tekst, Wynik) :-
    concat(Tekst, "[", T1),
    concat(T1, Number, T2),
    concat(T2, "]  ", Wynik),
    !.

spaces(Number, Acc, Tekst, Wynik) :-
    concat("  ", Tekst, Next),
    Acc1 is Acc + 1,
    spaces(Number, Acc1, Next, Wynik).


% loop
% filozof
%  myśli;
% filozof
%  stara się podnieść prawy widelec;
% filozof
%  stara się podnieść lewy widelec;
% filozof
%  je;
% filozof
%  odkłada prawy widelec;
% filozof
%  odkłada lewy widelec;
% end loop;

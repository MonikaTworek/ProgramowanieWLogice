filozof(Lewy, Prawy, Numer) :-
    myslenie(Numer),
    podnoszenie(Numer, Prawy, "prawy"),
    podnoszenie(Numer, Lewy, "lewy"),
    jedzenie(Numer),
    odkladanie(Numer, Prawy, "prawy"),
    odkladanie(Numer, Lewy, "lewy"),
    filozof(Lewy, Prawy, Numer).

filozofowie :-
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

podnoszenie(Numer, Mutex, Strona) :-
    spaces(Numer, Prefiks),
    concat(Prefiks, "chce ", K1),
    concat(K1, Strona, K2),
    concat(K2, " widelec\n", K3),
    write(K3),
    concat(Prefiks, "podnosi ", L1),
    concat(L1, Strona, L2),
    concat(L2, " widelec\n", L3),
    mutex_lock(Mutex),
    write(L3).

jedzenie(Numer) :-
    spaces(Numer, Tekst),
    concat(Tekst, "je\n", Komunikat),
    write(Komunikat).

odkladanie(Numer, Mutex, Strona) :-
    spaces(Numer, Prefiks),
    concat(Prefiks, "odklada ", K1),
    concat(K1, Strona, K2),
    concat(K2, " widelec\n", K3),
    write(K3),
    mutex_unlock(Mutex).

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

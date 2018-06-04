 % Przyklad: podwajanie

% ?- ex1(5).
% 2
% 4
% 6
% 8
% 10
% true.
%
ex1(N) :-
	drukuj(Y),
	podwajanie(X, Y),
	generowanie(1, N, X).

generowanie(I, J, S) :-
	(   I =< J
	->  S = [I | T],
	    I1 is I+1,
	    generowanie(I1, J, T)
	;   S = []).

podwajanie(S1, S2) :-
        freeze(S1,
               (   S1 = [H1 | T1]
               ->  H2 is 2*H1,
                   S2 = [H2 | T2],
                   podwajanie(T1, T2)
               ;   S2 = [])).
drukuj(S) :-
        freeze(S,
               (   S = [H | T]
               ->  writeln(H),
                   drukuj(T)
	       ;   true)).


% Przyklad: sito Eratostenesa

% ?- ex2(10).
% 2
% 3
% 5
% 7
% true.

ex2(N) :-
	sito(X, Y),
	drukuj(Y),
	generowanie(2, N, X).

czytaj([H | T], H, T).

pisz(H, T, [H | T]).

zamknij([]).

sito(In, Out) :-
        freeze(In,
               (   czytaj(In, N, In_)
               ->  pisz(N, Out_, Out),
                   filtruj(N, In_, Out1),
                   sito(Out1, Out_)
               ;   zamknij(Out))).

filtruj(N, In, Out) :-
        freeze(In,
               (   czytaj(In, I, In_)
               ->  (   I mod N =:= 0
                   ->  filtruj(N, In_, Out)
                   ;   pisz(I, Out_, Out),
                       filtruj(N, In_, Out_))
               ;   zamknij(Out))).

% Przyklad: zmienne nie sa wspoldzielone

% ?- ex3(X).
% X = true.
%
ex3(Status) :-
	thread_create(X = b, ID, []),
	X = a,
	thread_join(ID, Status).

% Przyklad: gracze przesylajacy komunikaty

% ?- gra(TID1, TID2).
% TID1 = 2,
% TID2 = 3.
%
% ?- thread_send_message(2, ping).
% 2 dostal ping
% 3 dospal pong
% 2 dostal ping
% 3 dostal pong
% ...

gra(TID1, TID2) :-
	thread_create(gracz, TID1, [detached(true)]),
	thread_create(gracz, TID2, [detached(true)]),
	thread_send_message(TID1, TID2), % powiedz pierwszemu, ze gra z drugim
	thread_send_message(TID2, TID1). % powiedz drugiemu, ze gra z pierwszym

gracz :-
	thread_self(My_TID),
	thread_get_message(Other_TID),
	gracz(My_TID, Other_TID).

gracz(My_TID, Other_TID) :-
	thread_get_message(X),
	format('~w dostal ~w~n', [My_TID, X]),
	ping_pong(X, Y),
	thread_send_message(Other_TID, Y),
	gracz(My_TID, Other_TID).   % nieskonczona petla

ping_pong(ping, pong).
ping_pong(pong, ping).

% Przyklad: producent-konsument (wspoldzielona baza dynamicznych faktow)

:- dynamic produkt/1.

% ?- ex4(3).
% producent: wyprodukowalem 3
% konsument: skonsumowalem 3
% producent: wyprodukowalem 2
% konsument: skonsumowalem 2
% producent: wyprodukowalem 1
% konsument: skonsumowalem 1
% konsument zakonczyl ze statusem exited(finito)
% producent zakonczyl ze statusem true
% true.
%
% UWAGA: jesli konsumpcja trwa duzo dluzej niz produkcja, to producent
%        moze kazac zakonczyc sie konsumentowi, chociaz nie skonsumowal
%        on jeszcze wszystkich produktow.
%
ex4(N) :-
	thread_create(konsument, ID1, []),
	thread_create(producent(N, ID1), ID2, []),
	thread_join(ID1, ST1),
	thread_join(ID2, ST2),
	format('konsument zakonczyl ze statusem ~w~n', [ST1]),
	format('producent zakonczyl ze statusem ~w~n', [ST2]).

producent(0, ID) :-
	% wyslij sygnal by konsument nie czekal na kolejny produkt:
	thread_signal(ID, thread_exit(finito)).
producent(N, ID) :-
	N > 0,
	assertz(produkt(N)),
	format('producent: wyprodukowalem ~w~n', [N]),
	N1 is N-1,
	producent(N1, ID).

konsument :-
	(   produkt(N)
	->  retract(produkt(N)),
	    format('konsument: skonsumowalem ~w~n', [N])
	;   true),
	konsument.

% MUTEXy
%
ex5a(N) :-
	thread_create(p(N, 'a'), ID1),
	thread_create(p(N, 'b'), ID2),
	thread_join(ID1, _),
	thread_join(ID2, _).

p(0, _).
p(N, CH) :-
	N > 0,
	N1 is N - 1,
	write(CH), write(CH), write(CH), write(' '),
	p(N1, CH).

ex5b(N) :-
	mutex_create(M),
	thread_create(p(N, 'a', M), ID1),
	thread_create(p(N, 'b', M), ID2),
	thread_join(ID1, _),
	thread_join(ID2, _).

p(0, _, _).
p(N, CH, M) :-
	N > 0,
	N1 is N - 1,
	mutex_lock(M),
	write(CH), write(CH), write(CH), write(' '),
	mutex_unlock(M),
	p(N1, CH, M).


ex5c(N) :-
	mutex_create(M),
	thread_create(p2(N, 'a', M), ID1),
	thread_create(p2(N, 'b', M), ID2),
	thread_join(ID1, _),
	thread_join(ID2, _).

p2(0, _, _).
p2(N, CH, M) :-
	N > 0,
	N1 is N - 1,
	with_mutex(M,
		   (
		       write(CH), write(CH), write(CH), write(' ')
		   )),
	p2(N1, CH, M).








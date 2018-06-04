% L(s1) jezyk palindromow.
%
s1 --> [].
s1 --> [a].
s1 --> [b].
s1 --> [a], s1, [a].
s1 --> [b], s1, [b].

% L(s2) jezyk poprawnie rozstawionych nawiasow.
%
s2 --> ``.
s2 --> `(`, s2, `)`, s2.

% L(s3) jezyk zlozony ze slow o rownej liczbie 0 i 1.
%
s3 --> ``.
s3 --> `0`, s3, `1`, s3.
s3 --> `1`, s3, `0`, s3.

% Naiwna analiza zdan jezyka naturalnego.
%
zdanie(X) :-
	append(Y, Z, X),
	fraza_rzecz(Y),
	fraza_czas(Z).

fraza_rzecz(X) :-
	append(Y, Z, X),
	przedimek(Y),
	rzeczownik(Z).

fraza_czas(X) :-
	append(Y, Z, X),
	czasownik(Y),
	fraza_rzecz(Z).
fraza_czas(X) :-
	czasownik(X).

przedimek([the]).

rzeczownik([apple]).
rzeczownik([man]).

czasownik([eats]).
czasownik([sings]).

/*

% Poprawiona analiza zdan jezyka naturalnego.
%
zdanie(X, Z) :-
	fraza_rzecz(X, Y),
	fraza_czas(Y, Z).

fraza_rzecz(X, Z) :-
	przedimek(X, Y),
	rzeczownik(Y, Z).

fraza_czas(X, Z) :-
	czasownik(X, Y),
	fraza_rzecz(Y, Z).
fraza_czas(X, Y) :-
	czasownik(X, Y).

przedimek([the | X], X).

rzeczownik([apple | X], X).
rzeczownik([man | X], X).

czasownik([eats | X], X).
czasownik([sings | X], X).

*/

% Gramatyka zdan jezyka angielskiego.
%
zdanie --> fraza_rzecz, fraza_czas.
fraza_rzecz --> przedimek, rzeczownik.
fraza_czas --> czasownik, fraza_rzecz.
fraza_czas --> czasownik.
przedimek --> [the].
rzeczownik --> [apple].
rzeczownik --> [man].
czasownik --> [eats].
czasownik --> [sings].

% Gramatyka metamorficzna TERM <--> KOD
%
kod(a) --> `0`.
kod(f(X, Y)) --> `1`, kod(X), kod(Y).

% Gramatyka metamorficzna CIAG BITOW --> WARTOSC DZIESIETNA
%
bin(X) --> bin(0, X).
bin(X, X) --> ``.
bin(X, Z) --> `0`, {Y is 2*X}, bin(Y, Z).
bin(X, Z) --> `1`, {Y is 2*X+1}, bin(Y, Z).

% Gramatyka metamorficzna LICZEBNIK --> WARTOSC DZIESIETNA
%
number(0) --> [zero].
number(N) --> xxx(N).

xxx(N) -->
	digit(D), [hundred], rest_xxx(N1), {N is D*100 + N1}.
xxx(N) -->
	xx(N).

rest_xxx(0) --> [].
rest_xxx(N) --> [and], xx(N).

xx(N) --> digit(N).
xx(N) --> teen(N).
xx(N) --> tens(T), rest_xx(N1), {N is T+N1}.

rest_xx(0) --> [].
rest_xx(N) --> digit(N).

digit(1) --> [one].
digit(2) --> [two].
digit(3) --> [three].
digit(4) --> [four].
digit(5) --> [five].
digit(6) --> [six].
digit(7) --> [seven].
digit(8) --> [eight].
digit(9) --> [nine].

teen(10) --> [ten].
teen(11) --> [eleven].
teen(12) --> [twelve].
teen(13) --> [thirteen].
teen(14) --> [fourteen].
teen(15) --> [fifteen].
teen(16) --> [sixteen].
teen(17) --> [seventeen].
teen(18) --> [eighteen].
teen(19) --> [nineteen].

tens(20) --> [twenty].
tens(30) --> [thirty].
tens(40) --> [forty].
tens(50) --> [fifty].
tens(60) --> [sixty].
tens(70) --> [seventy].
tens(80) --> [eighty].
tens(90) --> [ninety].


% Gramatyka metamorficzna ZDANIE <--> FORMULA RACHUNKU PREDYKATOW
%
:- op(900, xfx, =>).
:- op(800, xfy, &).
:- op(550, xfy, :).

zdanie(P) --> fraza_rzecz(X, P1, P), fraza_czas(X, P1).

fraza_rzecz(X, P1, P) -->
	przedimek(X, P2, P1, P), rzeczownik(X, P3),
	klauzula_wzgl(X, P3, P2).
fraza_rzecz(X, P, P) --> rzeczownik_wlasny(X).

fraza_czas(X, P) -->
	czasownik_przech(X, Y, P1), fraza_rzecz(Y, P1, P).
fraza_czas(X, P) --> czasownik_nieprzech(X, P).

klauzula_wzgl(X, P1, P1&P2) --> [that], fraza_czas(X, P2).
klauzula_wzgl(_, P, P) --> [].

przedimek(X, P1, P2, all(X):(P1=>P2)) --> [every].
przedimek(X, P1, P2, exists(X):(P1&P2)) --> [a].

rzeczownik(X, man(X)) --> [man].
rzeczownik(X, woman(X)) --> [woman].

rzeczownik_wlasny(john) --> [john].

czasownik_przech(X, Y, loves(X,Y)) --> [loves].
czasownik_przech(X, Y, knows(X,Y)) --> [knows].

czasownik_nieprzech(X, lives(X)) --> [lives].

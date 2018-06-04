% N-krawędź początkowa,E-zbiór dotychczasowych krawędzi, NE-nowy zbiór krawędzi

generuj_duzy(N,E,NE):-
	N=:=1 -> (duzy(Boki), union(E,Boki,NE));NE=E.

generuj_sredni(N,E,NE):-
	pod([1,2,4,5],V),
	length(V,N),
	generuj_sredniekr(V,[],Boki),
	union(E,Boki,NE).

generuj_maly(N,E,NE):-
	pod([1,2,3,4,5,6,7,8,9],V),
	length(V,N),
	generuj_malekr(V,[],Boki),
	union(E,Boki,NE).

generuj_sredniekr([],E,E).
generuj_sredniekr([H|T],E,NE):-
	sredni(H,Boki),
	union(E,Boki,NBoki),
	generuj_sredniekr(T,NBoki,NE).

generuj_malekr([],E,E).
generuj_malekr([H|T],E,NE):-
	maly(H,Boki),
	union(E,Boki,NBoki),
	generuj_malekr(T,NBoki,NE).

duzy([1,2,3,10,11,12,101,104,105,108,109,112]).

sredni(N,_):-(N<1;N=:=3;N>5),!,fail.
sredni(N,Boki):-
	E1 is N, E2 is N+1, E3 is N+6, E4 is N+7,
	P is floor(N/3),
	E5 is 100+N+P, E6 is 102+N+P, E7 is 104+N+P, E8 is 106+N+P,
	Boki=[E1,E2,E3,E4,E5,E6,E7,E8].

maly(N,_):-(N<1;N>9),!,fail.
maly(N,Boki):-
	E1 is N, E2 is N+3,
	P is floor((N-1)/3),
	E3 is 100+N+P, E4 is 101+N+P,
	Boki=[E1,E2,E3,E4].

sprawdz_zapalki(N,Zapalki):-
	Wsio=[1,2,3,4,5,6,7,8,9,10,11,12,
		  101,102,103,104,105,106,107,108,109,110,111,112],
	subtract(Wsio,Zapalki,Z),
	length(Z,N).

sprawdz_kwadraty(M,S,D,Boki):-
	policz_maly([1,2,3,4,5,6,7,8,9],Boki,CM),CM=:=M,
	policz_srednie([1,2,4,5],Boki,CS),CS=:=S,
	policz_duze(Boki,CD),CD=:=D.

policz_duze(E,N):-
	duzy(X),
	(subset(X,E)->N=1;N=0).

policz_srednie(V,E,N):-policz_srednie(V,E,0,N).
policz_srednie([],_,E,E).
policz_srednie([H|T],E,A,N):-
	sredni(H,X),
	(subset(X,E)->C is A+1; C=A),
	policz_srednie(T,E,C,N).

policz_maly(V,E,N):-policz_maly(V,E,0,N).
policz_maly([],_,E,E).
policz_maly([H|T],E,A,N):-
	maly(H,X),
	(subset(X,E)->C is A+1; C=A),
	policz_maly(T,E,C,N).

rysuj(X):-rysuj(1,101,X).
rysuj(X,Y,Zapalki):-
	write('+'),
	(member(X,Zapalki)->write(' - - - '); write('\t')),
	X2 is X+1,
	write('+'),
	(member(X2,Zapalki)->write(' - - - '); write('\t')),
	X3 is X2+1,
	write('+'),
	(member(X3,Zapalki)->write(' - - - '); write('\t')),
	X4 is X3+1,
	write('+\n\n'),
	(
	    Y<110->((member(Y,Zapalki)->write('|'); write('   ')),
	    Y2 is Y+1,
	    write('\t'),
	    (member(Y2,Zapalki)->write('|'); write('   ')),
	    Y3 is Y2+1,
	    write('\t'),
	    (member(Y3,Zapalki)->write('|'); write('   ')),
	    Y4 is Y3+1,
	    write('\t'),
	    (member(Y4,Zapalki)->write('|'); write('   ')),
	    Y5 is Y4+1,
	    write('\n\n'),
	    rysuj(X4,Y5,Zapalki));
	    write('\n\n'),true).

pod([],[]).
pod([H|T],[H|NT]):-pod(T,NT).
pod([_|T],NT):-pod(T,NT).


zapalki(N,(duze(D),srednie(S),male(M))):-
	generuj_duzy(D,[],E),
	generuj_sredni(S,E,E2),
	generuj_maly(M,E2,E3),
	sprawdz_zapalki(N,E3),
	sprawdz_kwadraty(M,S,D,E3),
	rysuj(E3).

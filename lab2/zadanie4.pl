ma(kazik, dom).
ma(zbysio, auto).
ma(magda, rower).
ma(kasia, willa).

daje(1, kazik, dom, magda).
daje(1, zbysio, auto, magda).
daje(3, magda, dom, kasia).
daje(2, kasia, willa, magda).
daje(8, magda, willa, kazik).

/*
warunek1(Kiedy, Kto, Co) :-
	ma(Kto, Co),
	bet(s(a), Kiedy, N),
	daje(N, Kto, Co, _).

warunek2(Kiedy, Kto, Co) :-
	daje(Pocz, _, Co, Kto),
	bet(s(a), Kiedy, N),
	daje(N, Kto, Co, _). 


ma(Pocz, Koniec, Kto, Co) :-
	\+warunek1(Koniec, Kto, Co), \+warunek2(Pocz, Koniec, Kto, Co).
*/

nieoddal(Pocz, Koniec, Kto, Co) :-
	\+ (
		between(Pocz, Koniec, N),
		daje(N, Kto, Co, _)
	), !.

ma(Kiedy, Kto, Co) :-
	%mial od poczatku i nie oddal	
	ma(Kto, Co), 
	daje(Koniec,_,_,_), 
	nieoddal(0, Koniec, Kto, Co), 
	between(0, Koniec, Kiedy).


ma(Kiedy, Kto, Co) :-
	%dostal i oddal
	daje(Pocz,_,Co, Kto), 
	daje(Koniec,_,Co,_),
	X is Koniec-1,  
	nieoddal(Pocz, X, Kto, Co), 
	between(Pocz, X, Kiedy).


ma(Kiedy, Kto, Co) :-
	%dostal i nie oddal
	daje(Kiedy,_,Co, Kto),  
	\+ (daje(Y, Kto, Co, _), Y > Kiedy).

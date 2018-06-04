average(List, Average):- 
    sumlist(List, Sum),
    length(List, Length),
    Length > 0, 
    Average is Sum / Length.

doit([H], Average, Length, Xbis) :-
	Xprim is (H-Average)*(H-Average),
	Xbis is (1/Length)*Xprim.

doit([H|T], Average, Length, Result) :-
	Xprim is (H-Average)*(H-Average),
	Xbis is (1/Length)*Xprim,
	doit(T, Average, Length, X),
	Result is X+Xbis.


wariancja(List, X) :-
	average(List, Average),
	length(List, Length),
	doit(List, Average, Length, X).

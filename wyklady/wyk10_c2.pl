% przyklad w SICStus Prolog

:- use_module(library('linda/client')).

:- nl,
   write('1. wywolaj linda_client(Adres:Port), gdzie Adres:Port jest'), nl,
   write('   wydrukowane przez serwer z pliku wyk10_s.pl'), nl,
   write('2. wywolaj main'), nl,
   nl.

main :-
	in(msg(c2, X)),
	write(client(c2, dostalem(X))), nl,
	out(msg(c3, f(X))),
	write(client(c2, wyslalem(f(X)))), nl,
	main.

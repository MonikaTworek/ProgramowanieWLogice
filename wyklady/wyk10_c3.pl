% przyklad w SICStus Prolog

:- use_module(library('linda/client')).

:- nl,
   write('1. wywolaj linda_client(Adres:Port), gdzie Adres:Port jest'), nl,
   write('   wydrukowane przez serwer z pliku wyk10_s.pl'), nl,
   write('2. wywolaj main'), nl,
   nl.

main :-
	in(msg(c3, X)),
	write(client(c3, dostalem(X))), nl,
	out(msg(c1, g(X))),
	write(client(c3, wyslalem(g(X)))), nl,
	main.

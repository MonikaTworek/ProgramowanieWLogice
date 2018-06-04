% przyklad w SICStus Prolog

:- use_module(library('linda/client')).

:- nl,
   write('1. wywolaj linda_client(Adres:Port), gdzie Adres:Port jest'), nl,
   write('   wydrukowane przez serwer z pliku wyk10_s.pl'), nl,
   write('2. wywolaj main'), nl,
   nl.

main :-
	write('question: '),
	read(X),
	out(msg(c2, X)),
	write(client(c1, wyslalem(X))), nl,
	in(msg(c1, Y)),
	write(client(c1, dostalem(Y))), nl,
	write('answer: '), write(Y), nl,
	main.


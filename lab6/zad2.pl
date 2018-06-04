wykonaj(NazwaPliku) :-
	open(NazwaPliku, read, X), 
	scanner(X, Y), 
	close(X),
	phrase(program(PROGRAM), Y),
	interpreter(PROGRAM).

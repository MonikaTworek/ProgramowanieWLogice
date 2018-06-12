:- use_module(library(sgml)).

ex1(DOM) :-
	load_html('index.html', DOM, []).

:- use_module(library(xpath)).

ex2(TR) :-
	ex1(DOM),
	xpath(DOM, //tr, TR).

ex3(TD) :-
	ex2(TR),
	xpath(TR, td, TD).

ex4(HREF) :-
	ex1(DOM),
	xpath(DOM, //a(@href), HREF).

:- use_module(library(pwp)).

ex5 :-
	pwp_files('hello_in.html', 'hello_out.html').

ex6 :-
	pwp_files('table_in.html', 'table_out.html').

ex7 :-
	pwp_files('emails_in.html', 'emails_out.html').



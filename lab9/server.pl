:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_client)).
:- use_module(library(http/html_write)).
:- use_module(library(http/http_files)).

:- use_module(form,[build_form/2]).
:- use_module(queens,[queens/2]).
:- http_handler(root(queens), handler_queens, []).
:- http_handler(root(solution), handler_solution, []).
:- http_handler(root(.), http_reply_from_files('pic', []), [prefix]).

% server(+Port) uruchomienie serwera na danym porcie
%
server(Port) :-
	http_server(http_dispatch, [port(Port)]).

handler_queens(_Request) :-
	format('Content-type: text/html~n~n'),
	format('<!DOCTYPE html><html><head><title>Size</title>~n',[]),
	format('<meta http-equiv="content-type" content="text/html; charset=UTF-8">~n',[]),
	format('</head><body>~n', []),
	format('<h1>Gimme size of the problem</h1>~n',[]),
	build_form([action(solution),method(post)],
		   [label(size,'Size:'),input(text,size),br,
		    input(submit)]),
	format('</body></html>~n', []).

handler_solution(Request) :-
	member(method(post),Request),!,
	http_read_data(Request,Data,[]),
	Data=[size=Val],
	atom_number(Val,N),
	queens(N,P),
	reply_html_page(title('Solution'),[h1('Solution'),table(\row(1,N,P))]).

row(R,N,_)-->{R is N+1},[].
row(R,N,[H|P])-->html(tr(\cell(1,N,H))),{R1 is R+1},row(R1,N,P).

cell(C,N,_)-->{C is N+1},[].
cell(C,N,H)-->{H=\=C},html(td(img(src('empty.png')))),{C1 is C+1},cell(C1,N,H).
cell(H,N,H)-->html(td(img(src('queen.png')))),{C1 is H+1},cell(C1,N,H).


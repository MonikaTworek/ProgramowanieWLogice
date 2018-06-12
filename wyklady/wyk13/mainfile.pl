:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_client)).
:- use_module(library(http/html_write)).

:- use_module(form, [build_form/2]).

:- http_handler(root(form), form, []).
:- http_handler(root(action), action, []).

% server(+Port) uruchomienie serwera na danym porcie
%
server(Port) :-
	http_server(http_dispatch, [port(Port)]).

form(_Request) :-
	format('Content-type: text/html~n~n'),
	format('<!DOCTYPE html><html><head><title>Form</title>~n', []),
	format('<meta http-equiv="content-type" content="text/html; charset=UTF-8">~n', []),
	format('</head><body>~n', []),
	build_form([action(action), method(post)],
		   [	label(name, 'Your name:'), input(text, name), br,
			label(address, 'Address:'), input(text, address), br,
			label(sex, 'Sex:'),
			input(radio(checked), sex, male, male),
			input(radio, sex, female, female), br,
			input(submit)]),
	format('</body></html>~n', []).

action(Request) :-
	member(method(post), Request), !,
	http_read_data(Request, Data, []),
	reply_html_page(title('Action'),
			[h1('Fields and values'),
			 table([ \header | \data(Data)])
			]).

header -->
	html(tr([th('Field'), th('Value')])).

data([]) --> [].
data([Name=Value | Tail]) -->
	html(tr([td(Name), td(Value)])),
	data(Tail).






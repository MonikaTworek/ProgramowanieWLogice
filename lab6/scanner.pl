ignore(' ').
ignore('\n').

token(read,  key(read)).
token(write, key(write)).
token(if,    key(if)).
token(then,  key(then)).
token(else,  key(else)).
token(fi,    key(fi)).
token(while, key(while)).
token(do,    key(do)).
token(od,    key(od)).
token(and,   key(and)).
token(or,    key(or)).
token(mod,   key(mod)).

token(';',  sep(';')).
token('+',  sep('+')).
token('-',  sep('-')).
token('*',  sep('*')).
token('/',  sep('/')).
token('(',  sep('(')).
token(')',  sep(')')).
token('<',  sep('<')).
token('>',  sep('>')).
token('=<', sep('=<')).
token('>=', sep('>=')).
token(':=', sep(':=')).
token('=', sep('=')).
token('/=', sep('/=')).

token(TokenString, int(Token)) :-
  atom_number(TokenString, Token),
  integer(Token), !.

is_uppercase(Symbol) :-
    char_code(Symbol, Code),
    Code >= 65,
    Code =< 90, 
    !.

id_token(Token, id(Token)).

tokenize([], '', []).

tokenize([Symbol|RestOfSymbols], Temporary, [Token|RestOfTokens]) :-
  \+ is_uppercase(Symbol),
  \+ ignore(Temporary),
  atom_concat(Temporary, Symbol, SymbolWithTemporary),
  token(SymbolWithTemporary, Token),
  tokenize(RestOfSymbols, '', RestOfTokens), !.

tokenize([Symbol|RestOfSymbols], Temporary, AllTokens) :-
  \+ is_uppercase(Symbol),
  \+ ignore(Temporary),  
  atom_concat(Temporary, Symbol, SymbolWithTemporary),
  tokenize(RestOfSymbols, SymbolWithTemporary, AllTokens), !.

tokenize([Symbol|RestOfSymbols], Temporary, AllTokens) :-
  ignore(Symbol),
  tokenize(RestOfSymbols, Temporary, AllTokens), !.

tokenize([Symbol|RestOfSymbols], '', AllTokens) :-
  is_uppercase(Symbol),
  atom_concat('', Symbol, SymbolWithTemporary),
  tokenize_id(RestOfSymbols, SymbolWithTemporary, AllTokens), !.

tokenize_id([Symbol|RestOfSymbols], Temporary, AllTokens) :-
  is_uppercase(Symbol),
  atom_concat(Temporary, Symbol, SymbolWithTemporary),
  tokenize_id(RestOfSymbols, SymbolWithTemporary, AllTokens), !.

tokenize_id([Symbol|RestOfSymbols], Temporary, [Token|RestOfTokens]) :-
  \+ is_uppercase(Symbol),
  id_token(Temporary, Token),
  tokenize([Symbol|RestOfSymbols], '', RestOfTokens), !.

scanner(X, Z) :-
  read_from_stream(X, Y),
  tokenize(Y, '', Z), !.

read_from_stream(InputStream, []) :- 
    at_end_of_stream(InputStream).
  
read_from_stream(InputStream, [CharsHead|CharsTail]) :-
  \+ at_end_of_stream(InputStream),
  get_code(InputStream, CharsCode),
  atom_codes(CharsHead, [CharsCode]),
  read_from_stream(InputStream, CharsTail).

test :-
    open('read.prog', read, X), 
    scanner(X, Y),
    write(Y).

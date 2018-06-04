program([]) --> [].
program([A|B]) --> instrukcja(A), [sep(;)], program(B).

instrukcja(assign(A,B)) --> [id(A)], [sep(':=')], wyrazenie(B).
instrukcja(read(A)) --> [key('read')], [id(A)].
instrukcja(write(A)) --> [key('write')], wyrazenie(A).
instrukcja(if(A,B)) --> [key('if')], warunek(A), [key('then')], program(B), [key('fi')].
instrukcja(if(A,B,C)) --> [key('if')], warunek(A), [key('then')], program(B), [key('else')], program(C), [key('fi')].
instrukcja(while(A,B)) --> [key('while')], warunek(A), [key('do')], program(B), [key('od')].

wyrazenie(A+B) --> skladnik(A), [sep(+)], wyrazenie(B).
wyrazenie(A-B) --> skladnik(A), [sep(-)], wyrazenie(B).
wyrazenie(A) --> skladnik(A).

skladnik(A*B) --> czynnik(A), [sep(*)], skladnik(B).
skladnik(A/B) --> czynnik(A), [sep(/)], skladnik(B).
skladnik(A mod B) --> czynnik(A), [key('mod')], skladnik(B).
skladnik(A) --> czynnik(A).

czynnik(id(A)) --> [id(A)].
czynnik(int(A)) --> [int(A)].
czynnik(A) --> [sep('(')], wyrazenie(A), [sep(')')].

warunek(A ; B) --> koniunkcja(A), [key('or')], warunek(B).
warunek(A) --> koniunkcja(A).

koniunkcja(A ',' B) --> prosty(A), [key('and')], koniunkcja(B).
koniunkcja(A) --> prosty(A).

prosty(A=:=B) --> wyrazenie(A), [sep(=)], wyrazenie(B).
prosty(A=\=B) --> wyrazenie(A), [sep('/=')], wyrazenie(B).
prosty(A<B) --> wyrazenie(A), [sep(<)], wyrazenie(B).
prosty(A>B) --> wyrazenie(A), [sep(>)], wyrazenie(B).
prosty(A>=B) --> wyrazenie(A), [sep(>=)], wyrazenie(B).
prosty(A=<B) --> wyrazenie(A), [sep(=<)], wyrazenie(B).
prosty(A) --> [sep('(')], warunek(A), [sep(')')].

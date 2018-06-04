% h(kolor, narodowosc, zwierze, drink, papierosy)
% kolory:    czerwony, zielony, bialy, zolty, niebieskie
% narodowosc:   norweg, anglik, dunczyk, niemiec, szwed
% zwierze:      kot, ptak, pies, kon, rybki
% drink:    herbata, mleko, woda, piwo, kawa
% papierosy:   light, cygaro, pipe, nofilter, menthol

select([A|As], S) :- select(A, S, S1), select(As, S1).
select([], _).

obok(A,B,Dom) :- lewo(A,B,Dom).
obok(A,B,Dom) :- lewo(B,A,Dom).
lewo(A,B,Dom) :- append(_,[A,B|_],Dom).

rybki(Kto) :-
    % 1 & 8
    Dom = [ h(_,norweg,_,_,_), _, h(_,_,_,mleko,_), _, _],
    select([
        h(czerwony,anglik,_,_,_),       % 2
        h(_,dunczyk,_,herbata,_),        % 4
        h(_,niemiec,_,_,pipe),       % 7
        h(_,szwed,pies,_,_)        % 11
        ], Dom),

    select([
        h(zolty,_,_,_,cygaro),      % 6
        h(_,_,ptak,_,nofilter),    % 10
        h(_,_,_,piwo,menthol)       % 14
        ], Dom),

    % 3 & 15
    lewo(h(zielony,_,_,kawa,_), h(bialy,_,_,_,_), Dom),
    % 5
    obok(h(_,_,_,_,light), h(_,_,kot,_,_), Dom),
    % 9
    obok(h(_,_,_,_,light), h(_,_,_,woda,_), Dom),
    % 12
    obok(h(_,norweg,_,_,_), h(niebieski,_,_,_,_), Dom),
    % 13
    obok(h(_,_,kon,_,_), h(zolty,_,_,_,_), Dom),

    member(h(_,Kto,rybki,_,_), Dom).


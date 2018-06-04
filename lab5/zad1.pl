scanner(Strumien, Tokeny) :-
    get_char(Strumien, C),
    scan(Strumien, [], C, Tokeny).


sep(X) :-
	member(X, [;,+,-,*,/,'(',')',<,>,=]),!.
inkszy_sep(X) :-
	member(X, [=,\,:,>]),!.

is_key(X) :-
	member(X, ['read', 'write', if, then, else, fi, while, do, od, and, or, 'mod']),!.


scan(_, [], C, []) :-
    char_type(C, end_of_file).

scan(Strumien, [], C, Tokeny) :-
    (char_type(C, white);char_type(C, newline)),
    get_char(Strumien, CC),
    scan(Strumien, [], CC, Tokeny).

scan(Strumien, [], C, Tokeny) :-
    char_type(C, upper),
    get_char(Strumien, CC),
    scan_id(Strumien, [C], CC, Tokeny).

scan(Strumien, [], C, Tokeny) :-
    (sep(C);inkszy_sep(C)),
    get_char(Strumien, CC),
    scan_sep(Strumien, [C], CC, Tokeny).

scan(Strumien, [], C, Tokeny) :-
    char_type(C, lower),
    get_char(Strumien, CC),
    scan_key(Strumien, [C], CC, Tokeny).

scan(Strumien, [], C, Tokeny) :-
    char_type(C, digit),
    get_char(Strumien, CC),
    scan_int(Strumien, [C], CC, Tokeny).


scan_id(Strumien, Buffer, C, Tokeny) :-
    char_type(C, upper),
    get_char(Strumien, CC),
    scan_id(Strumien, [C|Buffer], CC, Tokeny).
    
scan_id(Strumien, Buffer, C, [id(BBBuffer) | Tokeny]) :-
    (char_type(C, white);char_type(C, newline)),
    get_char(Strumien, CC),
    reverse(Buffer, BBuffer),
    atom_codes(BBBuffer, BBuffer),
    scan(Strumien, [], CC, Tokeny).

scan_id(Strumien, Buffer, C, [id(BBBuffer) | Tokeny]) :-
    (sep(C);inkszy_sep(C)),
    get_char(Strumien, CC),
    reverse(Buffer, BBuffer),
    atom_codes(BBBuffer, BBuffer),
    scan_sep(Strumien, [C], CC, Tokeny).


scan_sep(Strumien, [=], <, [sep(=<)|Tokeny]) :-
    get_char(Strumien, CC),
    scan(Strumien, [], CC, Tokeny).

scan_sep(Strumien, [>], =, [sep(>=)|Tokeny]) :-
    get_char(Strumien, CC),
    scan(Strumien, [], CC, Tokeny).

scan_sep(Strumien, [:], =, [sep(:=)|Tokeny]) :-
    get_char(Strumien, CC),
    scan(Strumien, [], CC, Tokeny).

scan_sep(Strumien, [\], =, [sep(\=)|Tokeny]) :-
    get_char(Strumien, CC),
    scan(Strumien, [], CC, Tokeny).

scan_sep(Strumien, [C1], C2, [sep(C1) | Tokeny]) :-
    sep(C1),
    C2 \= '<',
    C2 \= '=',
    scan(Strumien, [], C2, Tokeny).


scan_key(Strumien, Buffer, C, Tokeny) :-
    char_type(C, lower),
    get_char(Strumien, CC),
    scan_key(Strumien, [C|Buffer], CC, Tokeny).

scan_key(Strumien, Buffer, C, [key(BBBuffer) | Tokeny]) :-
    (char_type(C, white);char_type(C, newline)),
    get_char(Strumien, CC),
    reverse(Buffer, BBuffer),
    atom_codes(BBBuffer, BBuffer),
    is_key(BBBuffer),
    scan(Strumien, [], CC, Tokeny).

scan_key(Strumien, Buffer, C, [key(BBBuffer) | Tokeny]) :-
    (sep(C);inkszy_sep(C)),
    get_char(Strumien, CC),
    reverse(Buffer, BBuffer),
    atom_codes(BBBuffer, BBuffer),
    is_key(BBBuffer),
    scan_sep(Strumien, [C], CC, Tokeny).


scan_int(Strumien, Buffer, C, Tokeny) :-
    char_type(C, digit),
    get_char(Strumien, CC),
    scan_int(Strumien, [C|Buffer], CC, Tokeny).

scan_int(Strumien, Buffer, C, [int(BBBuffer) | Tokeny]) :-
    (char_type(C, white);char_type(C, newline)),
    get_char(Strumien, CC),
    reverse(Buffer, BBuffer),
    atom_codes(BBBuffer, BBuffer),
    scan(Strumien, [], CC, Tokeny).

scan_int(Strumien, Buffer, C, [int(BBBuffer) | Tokeny]) :-
    (sep(C);inkszy_sep(C)),
    get_char(Strumien, CC),
    reverse(Buffer, BBuffer),
    atom_codes(BBBuffer, BBuffer),
    scan_sep(Strumien, [C], CC, Tokeny).

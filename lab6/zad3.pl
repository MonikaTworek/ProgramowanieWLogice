% g1 - akceptujaca slowa z jezyka a^n b^n, n>= 0.

g1 --> ``.
g1 --> `a`, g1, `b`.

% g2 - akceptujaca slowa z jezyka a^n b^n c^n, n>= 0.

g2 --> ablock(Count),bblock(Count),cblock(Count).
 
ablock(0) --> ``.
ablock(succ(Count)) --> `a`, ablock(Count).
 
bblock(0) --> ``.
bblock(succ(Count)) --> `b`, bblock(Count).
 
cblock(0) --> ``.
cblock(succ(Count)) --> `c`, cblock(Count).

% g3 - akceptujaca slowa z jezyka a^n b^fib(n), n >= 0

g3 --> ``.
g3 --> ablock(Count), bfib(Count).

bfib(0) --> ``.
bfib(succ(0)) --> `b`.
bfib(succ(succ(Count))) --> bfib(Count), bfib(succ(Count)).

% p - phrase(p(L1), L2, L3) - append(L1, L3, L2).

p([]) --> [].
p([X|XS]) --> [X], p(XS).

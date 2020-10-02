memb(X,[_|T]) :- memb(X,T).
memb(X,[X|_]).

num(0).
num(s(X)) :- num(X).

add(0,X,X).
add(s(X), Y, s(Z)) :- add(X,Y,Z).

mul(0,X,0).
mul(s(X), Y, Z) :- mul(X, Y, XY), add(XY, Y, Z).


q(a).
q(X) :- X=b,!.
q(c).

pos(s(0)).
pos(s(X)) :- pos(X).

neg(p(X)).
neg(p(X)) :- pre(X).

pure(0).
pure(X) :- pos(X); neg(X).

mixed(0).
mixed(s(X)) :- mixed(X).
mixed(p(X)) :- mixed(X).

s --> bs(Length, N), [N].
bs(1,0) --> [0].
bs(1,1) --> [1].
bs(L,N) --> [0], bs(L1,N1), {L is L1 + 1, N is N1}.
bs(L,N) --> [1], bs(L1,N1), {L is L1 + 1, N is N1 + 2^L1}.

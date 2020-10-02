numeral(0).
numeral(s(X)) :- numeral(X).
numeral(X+Y) :- numeral(X), numeral(Y). %Exercise 1
numeral(p(X)) :- numeral(X).            %Exercise 2
numeral(-X) :- numeral(X).              %Exercise 4
numeral(X-Y) :- numeral(X), numeral(Y). %Exercise 6

add(0,X,X).
add(s(X),Y,s(Z)) :- add(X,Y,Z). %Exercise 1
add(p(X),Y,p(Z)) :- add(X,Y,Z). %Exercise 2

%Exercise 2
add2(p(X),s(Y),Z) :- add2(X,Y,Z).
add2(s(X),p(Y),Z) :- add2(X,Y,Z).
add2(s(p(X)),Y,Z) :- add2(X,Y,Z).
add2(p(s(X)),Y,Z) :- add2(X,Y,Z).
add2(X,s(p(Y)),Z) :- add2(X,Y,Z).
add2(X,p(s(Y)),Z) :- add2(X,Y,Z).

%Exercise 4
add2(-X,Y,Z) :- minus(X,W), add2(W,Y,Z).
add2(X,-Y,Z) :- minus(Y,W), add2(X,W,Z).

%Exercise 1
add2(s(X+W),Y,s(Z)) :- add(X,W,Q), add2(Q,Y,Z).
add2(X,s(W+Y),s(Z)) :- add(W,Y,Q), add2(Q,X,Z).
add2(s(X+W),s(Y+V),s(Z)) :- add(X,W,Q), add(Y,V,R), add2(Q,R,Z).

add2(X+W,Y,Z) :- add(X,W,Q), add2(Q,Y,Z).
add2(X,W+Y,Z) :- add(W,Y,Q), add2(Q,X,Z).
add2(X+W,Y+V,Z) :- add(X,W,Q), add(Y,V,R), add2(Q,R,Z).
add2(X,Y,Z) :- add(X,Y,Z).

%Exercise 3
minus(0,0).
minus(s(X)+p(W),Y) :- minus(s(X),Q), minus(p(W),R), add2(Q,R,Y).
minus(p(X)+s(W),Y) :- minus(p(X),Q), minus(s(W),R), add2(Q,R,Y).
minus(s(X)-p(W),Y) :- minus(s(X),Q), minus(-p(W),R), add2(Q,R,Y). %Exercise 6
minus(p(X)-s(W),Y) :- minus(p(X),Q), minus(-s(W),R), add2(Q,R,Y). %Exercise 6
minus(-s(X),Y) :- minus(p(X),Y).                                  %Exercise 5
minus(-p(X),Y) :- minus(s(X),Y).                                  %Exercise 5
minus(s(p(X)),Y) :- minus(X,Y).
minus(p(s(X)),Y) :- minus(X,Y).
minus(s(X),p(Y)) :- minus(X,Y).
minus(p(X),s(Y)) :- minus(X,Y).

%Exercise 5
subtract(X,Y,Z) :- minus(X,Q), minus(Y,R), add2(Q,R,Z).
%Exercise 6
subtract(X,Y-W,Z) :- minus(X,Q), minus(Y-W,R), add2(Q,R,Z).
subtract(X-W,Y,Z) :- minus(X-W,Q), minus(Y,R), add2(Q,R,Z).
subtract(-X,Y,Z) :- minus(Y,W), add2(X,W,Z).
subtract(X,-Y,Z) :- minus(X,W), add2(W,Y,Z).

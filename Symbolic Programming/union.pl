union1([],[],[]).
union1(L1,L2,L3):- setof(X,member(X,L1);member(X,L2),L3).

union2([],[],[]).
union2(L1,L2,L3):- setof(X,(member(X,L1);member(X,L2)),U),setof(X,member(X,L3),U).

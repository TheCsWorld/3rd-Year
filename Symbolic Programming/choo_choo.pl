s(A,B):-  foo(A,C),bar(C,D),wiggle(D,B).
foo([choo|T],T).
foo(A,B):-  foo(A,C),foo(C,B).
bar(A,B):- mar(A,C),zar(C,B).
mar(A,B):- me(A,C),my(C,B).
me([i|T],T).
my([am|T],T).
zar(A,B):-blar(A,C),car(C,B).
blar([a|T],T).
car([train|T],T).
wiggle([toot|T],T).
wiggle(A,B):- wiggle(A,C),wiggle(C,B).

numeral(0).
numeral(successor(X)):- numeral(X).
add(0,X,X).
add(successor(X),Y,successor(Z)):-add(X,Y,Z).

greaterThan(successor(X),0).
greaterThan(successor(X),successor(Y)):-greaterThan(X,Y).

leaf(1).
leaf(2).
leaf(4).

tree(leaf(1),leaf(2)).
tree(tree(leaf(1),leaf(2)),leaf(4)).
tree(X,Y).

swap(X,Y):-tree(Y,X).

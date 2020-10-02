append([],L,L).
append([H|T], L2,[H|L3]) :- append(T, L2, L3).

palindrome(L) :- reverse(L,L).

toptail([H|TIn], Out) :- append(Out,[_],TIn).

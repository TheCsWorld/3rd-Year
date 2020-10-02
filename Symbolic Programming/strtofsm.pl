% string2fsm(+String, ?TransitionSet, ?FinalStates)
string2fsm([], [], [q0]).
string2fsm([H|T], Trans, [Last]) :-
mkTL(T, [H], [[q0, H, [H]]], Trans, Last).
% mkTL(+More, +LastSoFar, +TransSoFar, ?Trans, ?Last)
mkTL([], L, Trans, Trans, L).
mkTL([H|T], L, TransSoFar, Trans, Last) :-
mkTL(T, [H|L], [[L,H,[H|L]]|TransSoFar],
Trans, Last).

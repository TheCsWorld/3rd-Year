termtype(Term, atom) :- atom(Term).
termtype(Term, integer) :- integer(Term).
termtype(Term, number) :- number(Term).
termtype(Term, variable) :- variable(Term).
termtype(Term, constant) : - atomic(Term).

termtype(Term, complex) :- notvar(Term), functor(Term,_,A), A>0.

termtype(Term, simple) :- termtype(Term, variable).
termtype(Term, simple) :- termtype(Term, constant).

termtype(Term, term) :- termtype(Term, simple).
termtype(Term, term) :- termtype(Term, complex).

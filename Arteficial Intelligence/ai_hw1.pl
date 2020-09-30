:- dynamic(kb/1).
makeKB(File):- open(File,read,Str), readK(Str,K),
							 reformat(K,KB), asserta(kb(KB)),close(Str).
readK(Stream,[]):- at_end_of_stream(Stream),!.
readK(Stream,[X|L]):- read(Stream,X), readK(Stream,L).
reformat([],[]).
reformat([end_of_file],[]) :- !.
reformat([:-(H,B)|L],[[H|BL]|R]) :- !,mkList(B,BL),reformat(L,R).
reformat([A|L],[[A]|R]) :- reformat(L,R).
mkList((X,T),[X|R]) :- !, mkList(T,R).
mkList(X,[X]).
initKB(File) :- retractall(kb(_)), makeKB(File).

astar(Node ,Path, Cost) :- kb(KB), doAStar([[Node, [], 0]], Path, Cost, KB).
doAStar([[Node, Path, Cost]|_], [Node, Path], Cost, _) :- goal(Node).
doAStar([[Node, P, C]|Rest], Path, Cost, KB) :- findall([X, [Node|P], Sum],
                                               (arc(Node, X, Y, KB), Sum is Y+C), Children),
																							 addtofrontier(Children, Rest, Temp),
																							 doSort(Temp, [[N1, P1, C1]|T1]),
																							 doAStar([[N1, P1, C1]|T1], Path, Cost, KB).

addtofrontier(Children, Frontier, NewFrontier) :- append(Children, Frontier, NewFrontier).

doSort([Head|Tail], Result) :- sort(Head, [], Tail, Result).
sort(Head, S, [], [Head|S]).
sort(C, S, [Head|Tail], Result) :- lessthan(C, Head), !,
								   								 sort(C, [Head|S], Tail, Result);
								   						 		 sort(Head, [C|S], Tail, Result).

lessthan([Node1,_,Cost1|_],[Node2,_,Cost2|_]) :- heuristic(Node1,Hvalue1), heuristic(Node2,Hvalue2),
                                                 F1 is Cost1+Hvalue1,
                                                 F2 is Cost2+Hvalue2,
                                                 F1 =< F2.
arc([H|T],Node,Cost,KB) :- member([H|B],KB),
						   						 append(B,T,Node),
						   				 		 length(B,L),
						   				 		 Cost is L+1.

heuristic(Node, H) :- length(Node, H).

goal([]).

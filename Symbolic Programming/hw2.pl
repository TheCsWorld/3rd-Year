%Chloe Conneely 17323080
%Exercise 1
s --> u(Cl),[2],v(Cr), {Cl is Cr * 2}.

u(0) --> [].
u(Count) --> [1], u(Count).
u(Count) --> [0], u(C), {Count is C + 1}.

v(0) --> [].
v(Count) --> [0], v(Count).
v(Count) --> [1], v(C),{Count is C + 1}.

%Exercise 2
s --> col(Col1),nat(Nat1),pet(Pet1),
      col(Col2),nat(Nat2),pet(Pet2),
      col(Col3),nat(Nat3),pet(Pet3),
      {Col1 \= Col2, Col1 \= Col3, Col2 \= Col3},
      {Nat1 \= Nat2, Nat1 \= Nat3, Nat2 \= Nat3},
      {Pet1 \= Pet2, Pet1 \= Pet3, Pet2 \= Pet3}.

col(Word) --> [Word], {lex(Word, col)}.
nat(Word) --> [Word], {lex(Word, nat)}.
pet(Word) --> [Word], {lex(Word, pet)}.

lex(red, col).
lex(blue, col).
lex(green, col).
lex(english, nat).
lex(japanese, nat).
lex(spanish, nat).
lex(zebra,pet).
lex(snail,pet).
lex(jaguar,pet).

%Exercise 3
mkList(0,[]).
mkList(Number, [Number | List]) :- N is Number-1, N>= 0, mkList(N, List).

s(0) --> [].
s(Count) --> {mkList(Count, L), member(X, L), C is Count-X}, [X], s(C).

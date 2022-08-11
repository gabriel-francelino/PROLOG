insere(A,[B|C],[A,B|C]):- A >= B, !.
insere(A,[B|C],[B|D]) :- insere(A,C,D), !.
insere(A,[],[A]).

ordemInsercao([A|B],Ls) :- ordemInsercao(B,Li), insere(A,Li,Ls).
ordemInsercao([],[]).

ap([],L,L).
ap([A|B],C, [A|D]) :- ap(B,C,D).

ordemTroca(L,S) :- ap(X,[A,B|C],L), B>A, !, ap(X,[B,A|C],Li), ordemTroca(Li,S).
ordemTroca(L,L).

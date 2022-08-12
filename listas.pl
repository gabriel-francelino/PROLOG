%ap([],L,L).
%ap([A|B],C, [A|D]) :- ap(B,C,D).

apaga(A,[A|B],B).
apaga(A,[B|C],[B|D]) :- apaga(A,C,D).

maximo(X,[X]).
maximo(A,[A|B]):-maximo(A1,B),A>A1.
maximo(A,[B|C]):-maximo(A,C),A>=B.

maximo1(X,[X]).
maximo1(M,[A|B]):-maximo1(C,B),(A>C->M=A;M=C).

comprimento(0,[]).
comprimento(N,[_|C]):-comprimento(N1,C), N is N1+1. % operador is realiza soma%

enesimo(1,[A|_],A) :- !.
enesimo(N,[_|B],X):- N1 is N-1, enesimo(N1,B,X), !.

total([],0).
total([A|B],T):-total(B,T1), T is T1 + A.

operacao(X,Y,Z) :- call(X,Y,Z).

seleciona(X,[X|Y],Y).
seleciona(X,[Y|Z],[Y|W]) :- seleciona(X,Z,W).

permuta(A,[B|C]) :- seleciona(B,A,D), permuta(D,C).
permuta([],[]).

ap([],L,L).
ap([A|B],C, [A|D]) :- ap(B,C,D).

membro(X,L) :- ap(_,[X|_],L).

ultimo(U,L) :- ap(_,[U],L).

compara([_|B],[_|D]) :- compara(B,D). %<--erro

prefixo(P,L) :- ap(P,_,L).

sufixo(S,L) :- ap(_,S,L).

sublista(S,L) :- prefixo(P,L), sufixo(S,P).

ordem([_]) :- !.
ordem([A,B|C]) :- A =< B, ordem([B|C]).

reversa([],[]).
reversa([A|B],L) :- reversa(B,Brev), ap(Brev,[A],L).

pertence(A,[A|_]).
pertence(A,[_|B]) :- pertence(A,B).

insere(A,L,L) :- pertence(A,L), !.
insere(X,Y,L) :- ap(Y,[X],L).

vez3([],[]).
vez3([A|B],[X|Y]) :- X is A*3, vez3(B,Y).

len([],0).
len([_|C],N):-len(C,N1), N is N1+1.

pertence(X,[X|_]).
pertence(X,[_|R]) :- pertence(X,R).

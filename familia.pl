%------------------
%		comenario
%------------------
pai(bruno,joao).
pai(joao, lucas).
pai(joao, joaquim).
pai(joaquim, bruno).
pai(pedro, silvia).

mae(maria, lucas).
mae(maria, joaquim).
mae(silvia, bruno).
mae(laura, silvia).

avo(A,C) :- pai(B,C), pai(A,B).
avo(A,C) :- pai(A,B), pai(B,C).

antecessor(X,Y) :- pai(X,Y).
antecessor(X,Y) :- mae(X,Y).
antecessor(X,Y) :- pai(X,Z), antecessor(Z,Y).
antecessor(X,Y) :- pai(X,Z), antecessor(Z,Y).

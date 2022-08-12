empilha(A,B,[A|B]) :- !.
desempilha(A,[A|B],B) :- !.

empLista([A|B],X,Z) :- empilha(A,X,Y), !, empLista(B,Y,Z).
empLista([],P,P) :- !.

enfileira(A,B,F) :- append(B,[A],F),!.
desenfileira(A,[A|B],B) :- !.

enfLista([A|B],X,Z) :- enfileira(A,X,Y), !, enfLista(B,Y,Z).
enfLista([],F,F) :- !.

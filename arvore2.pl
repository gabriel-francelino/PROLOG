%Outra representação para árvore
insere(X,[],no(X,[],[])) :- !.
insere(X,no(X,E,D),no(X,E,D)) :- !.
insere(X,no(I,E,D),no(I,E1,D)) :- X < I, !, insere(X,E,E1).
insere(X,no(I,E,D),no(I,E,D1)) :- X > I, !, insere(X,D,D1).

insArv([A|B],X-Z) :- !, insere(A,X,Y), insArv(B,Y-Z). % X-Y PEGA O 'X' FAZ A OPERACAO E COLOCA EM 'Y'
insArv([],A-A) :- !.

em([]).
em(no(I,E,D)) :- em(E), write(I), write(' '), em(D).

tabula(0) :- !.
tabula(N) :- N > 0, write('......'), N1 is N-1, tabula(N1).

mostra([], _).
mostra(no(I,E,D), N) :- N1 is N+1, mostra(D, N1), tabula(N), write(I), nl, mostra(E, N1).

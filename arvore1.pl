%UMA REPRESENTAÇÃO DE ÁRVORE EM PROLOG
%no(_,_,_).
no(a,b,c).
no(b,d,[]).
no(d,[],[]).
no(c,e,f).
no(e,[],g).
no(f,[],[]).
no(g,[],[]).

pre([]) :- !.
pre(X) :- write(X), write(' '), no(X,E,D), pre(E), pre(D).

em([]) :- !.
em(X) :- no(X,E,D), em(E), write(X), write(' '), em(D).

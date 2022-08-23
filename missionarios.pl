%------------------------------------------
% Busca em largura/profundidade
% Por Luiz Eduardo
%------------------------------------------
ap([],X,X).
ap([A|B],C,[A|D]) :- ap(B,C,D).

in(A,[A|_]) :- !.
in(A,[_|B]) :- in(A,B).

% Implementacao do algoritmo de busca em largura ou profundidade
% 1 = largura
% 2 = profundidade
estrategia(1).

atingemeta([_-E|_]) :- meta(E).

busca([Caminho|_], Solucao) :- atingemeta(Caminho), !, Solucao = Caminho.
busca([Caminho|Lista], Solucao) :- 
   findall(UMAEXT, estende(Caminho,UMAEXT), EXT),
   estrategia(Tipo),
   estrategia(Tipo),
   (Tipo = 1 -> ap(Lista, EXT,  Lista1);
    Tipo = 2 -> ap(EXT, Lista, Lista1)),
   busca(Lista1, Solucao).

naorepete(_-X,C) :- not(in(_-X,C)).

estende([OperacaoX-EstadoA|Caminho], [OperacaoY-EstadoB,OperacaoX-EstadoA|Caminho]) :-
   oper(OperacaoY,EstadoA,EstadoB),
   naorepete(OperacaoY-EstadoB,Caminho).

margem([M,C], X) :-
   (X==1, M==3 -> write('MMM'); write(' ')),
   (X==1, M==2 -> write('MM'); write(' ')),
   (X==1, M==1 -> write('M'); write(' ')),
   (X==1, M==0 -> write(''); write(' ')),
   (X==1, C==3 -> write('CCC'); write(' ')),
   (X==1, C==2 -> write('CC'); write(' ')),
   (X==1, C==1 -> write('C'); write(' ')),
   (X==1, C==0 -> write(''); write(' ')),
   (X==2, M==3 -> write('MMM'); write(' ')),
   (X==2, M==2 -> write('MM'); write(' ')),
   (X==2, M==1 -> write('M'); write(' ')),
   (X==2, M==0 -> write(''); write(' ')),
   (X==2, C==3 -> write('CCC'); write(' ')),
   (X==2, C==2 -> write('CC'); write(' ')),
   (X==2, C==1 -> write('C'); write(' ')),
   (X==2, C==0 -> write(''); write(' ')).


desenha(Estado) :-
     write('    '), margem(Estado, a), write('|    |'), margem(Estado,b).

escreve([_-E]) :- write('Estado Inicial: '), write(E), nl, !.
escreve([O-E|R]) :- 
    escreve(R), 
    write('Executando: '), 
    traduz(O,T),
    write(T), write(' obtemos '), /*desenha(E),*/ write(E), nl.

resolva :-
    inicial(X), 
    busca([[raiz-X]],S), 
    write(S), nl,
    escreve(S),
    write('que é a solução do problema').

%-----------------------------------
% Especificacao do problema
%-----------------------------------

% traduz(c1, 'encher o jarro 1  ').
% traduz(c2, 'encher o jarro 2  ').
% traduz(v1, 'esvaziar o jarro 1').
% traduz(v2, 'esvaziar o jarro 2').
% traduz(12, 'despejar 1 em 2   ').
% traduz(21, 'despejar 2 em 1   ').
% inicial([0,0]).
% meta([_,2]).
% oper(c1, [X,Y], [3,Y]) :- X < 3.
% oper(c2, [X,Y], [X,4]) :- Y < 4.
% oper(v1, [X,Y], [0,Y]) :- X > 0.
% oper(v2, [X,Y], [X,0]) :- Y > 0.
% oper(12, [X,Y], [0,Y1]) :- X > 0, Y < 4, Y1 is X + Y, Y1 =< 4.
% oper(12, [X,Y], [X1,4]) :- X > 0, Y < 4, X1 is X + Y - 4, X + Y > 4.
% oper(21, [X,Y], [X1,0]) :- Y > 0, X < 3, X1 is X + Y, X1 =< 3.
% oper(21, [X,Y], [3,Y1]) :- Y > 0, X < 3, Y1 is X + Y - 3, X + Y > 3.

traduz(vm1, 'vai um missionário').
traduz(tm1, 'volta um missionário').
traduz(vm2, 'vai dois missionários').
traduz(tm2, 'volta dois missionários').
traduz(vc1, 'vai um canibal').
traduz(tc1, 'volta um canibal').
traduz(vc2, 'vai dois canibais').
traduz(tc2, 'volta dois canibais').
traduz(vmc, 'vai um missionário e um canibal').
traduz(tmc, 'volta um missionário e um canibal').

% [Ma,Ca,Mb,Cb,L], margem em que está cada elemento
inicial([3,3,0,0,1]).
meta([0,0,3,3,2]).

% seguro(lM,M1,C1,T) :- X is M1-T, Y is 3-C1, Z is Y-3-M1, (X==0; X>=C1), (Y==0; Z=<T).
% seguro(lC,M1,C1,T) :- X is 3-M1, Y is X-3-C1, (X==0); (Y>=T).
% seguro(lMC,M1,C1) :- X is 3-C1, Y is 3-M1, (X==0); (X)=<(Y).

seguro(lM,M1,C1,T) :- (X==0; X>=C1), (Y==0; Z=<T), X is M1-T, Y is 3-C1, Z is Y-3-M1.
seguro(lC,M1,C1,T) :- (X==0); (Y>=T), X is 3-M1, Y is X-3-C1.
seguro(lMC,M1,C1) :- (X==0); (X)=<(Y), X is 3-C1, Y is 3-M1.
    
%operações para levar e trazer das margens - prolog não esta considerando o ou (;)
oper(levaM, [M1,C1,M2,C2,L], [A,C1,B,C2,2]) :- 
    M1>=1, L==1, seguro(lM,M1,C1,1), A is M1-1, B is M2+1.
oper(trazM, [M1,C1,M2,C2,L], [A,C1,B,C2,1]) :- 
    M2>=1, L==2, seguro(lM,M2,C2,1), A is M1+1, B is M2-1.
oper(levaC, [M1,C1,M2,C2,L], [M1,A,M2,B,2]) :-
    C1>=1, L==1, seguro(lC,M1,C1,1), A is C1-1, B is C2+1.
oper(trazC, [M1,C1,M2,C2,L], [M1,A,M2,B,1]) :-
    C2>=1, L==2, seguro(lC,M2,C2,1), A is C1+1, B is C2-1.

oper(levaMM, [M1,C1,M2,C2,L], [A,C1,B,C2,2]) :-
    M1>=2, L==1, seguro(lM,M1,C1,2), A is M1-2, B is M2+2.
oper(trazMM, [M1,C1,M2,C2,L], [A,C1,B,C2,1]) :-
    M2>=2, L==2, seguro(lM,M2,C2,2), A is M1+2, B is M2-2.
oper(levaCC, [M1,C1,M2,C2,L], [M1,A,M2,B,2]) :-
    C1>=2, L==1, seguro(lC,M1,C1,2), A is C1-2, B is C2+2.
oper(trazCC, [M1,C1,M2,C2,L], [M1,A,M2,B,1]) :-
    C2>=2, L==2, seguro(lC,M2,C2,2), A is C1+2, B is C2-2.

oper(levaMC, [M1,C1,M2,C2,L], [A,C,B,D,2]) :-
    M1>=1, C1>=1, L==1, seguro(lM,M1,C1), A is M1-1, B is M2+1, C is C1-1, D is C2+1.
oper(trazMC, [M1,C1,M2,C2,L], [A,C,B,D,1]) :-
    M2>=1, C2>=1, L==2, seguro(lM,M2,C2), A is M1+1, B is M2-1, C is C1+1, D is C2-1.


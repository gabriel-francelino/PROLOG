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

naorepete(X,C) :- not(in(_-X,C)).

estende([OperacaoX-EstadoA|Caminho], [OperacaoY-EstadoB,OperacaoX-EstadoA|Caminho]) :-
   oper(OperacaoY,EstadoA,EstadoB),
   naorepete(OperacaoY-EstadoB,Caminho).

margem([F,L,C,R], M) :-
   (F = M -> write('F'); write(' ')),
   (L = M -> write('L'); write(' ')),
   (C = M -> write('C'); write(' ')),
   (R = M -> write('R'); write(' ')).

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

%operações para levar e trazer das margens
oper(levaM, [M1,C1,M2,C2,L], [A,C1,B,C2,2]) :- 
    M1>0, M2=<3, L==1, A is M1-1, B is M2+1, A>=C1, B>=C2.
oper(trazM, [M1,C1,M2,C2,L], [A,C1,B,C2,1]) :- 
    M2>0, M1=<3, L==2, A is M1+1, B is M2-1, A>=C1, B>=C2.
oper(levaC, [M1,C1,M2,C2,L], [M1,A,M2,B,2]) :-
    C1>0, C2=<3, L==1, A is C1-1, B is C2+1, M1>=A, M2>=B.
oper(trazC, [M1,C1,M2,C2,L], [M1,A,M2,B,1]) :-
    C2>0, C1=<3, L==2, A is C1+1, B is C2-1, M1>=A, M2>=B.
oper(levaMM, [M1,C1,M2,C2,L], [A,C1,B,C2,2]) :-
    M1>0, M2=<3, L==1, A is M1-2, B is M2+2, A>=C1, B>=C2.
oper(trazMM, [M1,C1,M2,C2,L], [A,C1,B,C2,1]) :-
    M2>0, M1=<3, L==2, A is M1+2, B is M2-2, A>=C1, B>=C2.
oper(levaCC, [M1,C1,M2,C2,L], [M1,A,M2,B,2]) :-
    C1>0, C2=<3, L==1, A is C1-2, B is C2+2, M1>=A, M2>=B.
oper(trazCC, [M1,C1,M2,C2,L], [M1,A,M2,B,1]) :-
    C2>0, C1=<3, L==2, A is C1+2, B is C2-2, M1>=A, M2>=B.
oper(levaMC, [M1,C1,M2,C2,L], [A,C,B,D,2]) :-
    M1>0, M2=<3, L==1, C1>0, C2=<3,
    A is M1-1, B is M2+1, C is C1-1, D is C2+1,
    A>=C, B>=D.
oper(trazMC, [M1,C1,M2,C2,L], [A,C,B,D,1]) :-
    M2>0, M1=<3, L==2, C2>0, C1=<3,
    A is M1+1, B is M2-1, C is C1+1, D is C2-1,
    A>=C, B>=D.

% [Ma,Ca,Mb,Cb,L], margem em que está cada elemento
inicial([3,3,0,0,1]).
meta([0,0,3,3,2]).

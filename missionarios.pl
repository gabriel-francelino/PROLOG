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

% Verifica se atingiu a meta.
atingemeta([_-E|_]) :- meta(E).

% Faz a busca atráz da solução.
busca([Caminho|_], Solucao) :- atingemeta(Caminho), !, Solucao = Caminho.
busca([Caminho|Lista], Solucao) :- 
   findall(UMAEXT, estende(Caminho,UMAEXT), EXT),
   estrategia(Tipo),
   estrategia(Tipo),
   (Tipo = 1 -> ap(Lista, EXT,  Lista1);
    Tipo = 2 -> ap(EXT, Lista, Lista1)),
   busca(Lista1, Solucao).

% Verifica se o elemento repete.
naorepete(_-X,C) :- not(in(_-X,C)).

estende([OperacaoX-EstadoA|Caminho], [OperacaoY-EstadoB,OperacaoX-EstadoA|Caminho]) :-
   oper(OperacaoY,EstadoA,EstadoB),
   naorepete(OperacaoY-EstadoB,Caminho).

% Linhas 34 - 64: Funções de imprimir o resultado.
% margem([M1,C1,M2,C2,_], X) :-
%     (X=a -> forall(between(1,M1,_),write('M')), forall(between(1,C1,_),write('C')));
%     (X=b -> forall(between(1,M2,_),write('M')), forall(between(1,C2,_),write('C'))).

impM(P,I) :- 
    (I =< P -> write('M'); write(' ')).

impC(P,I) :- 
    (I =< P -> write('C'); write(' ')).

margem([M1,C1,M2,C2,_], X) :-
    (X=a -> forall(between(1,6,A),impM(M1,A)), forall(between(1,6,B),impC(C1,B)));
    (X=b -> forall(between(1,6,A),impM(M2,A)), forall(between(1,6,B),impC(C2,B))).

desenha(Estado) :-
     write('      '), margem(Estado, a), write('|      | '), margem(Estado,b).

escreve([_-E]) :- write('Estado Inicial: '), write(E), nl, !.
escreve([O-E|R]) :- 
    escreve(R), 
    write('Executando: '), 
    traduz(O,T),
    write(T), write(' obtemos -->'), desenha(E),/* write(E),*/ nl.

resolva :-
    inicial(X), 
    busca([[raiz-X]],S), 
    write(S), nl,
    escreve(S),
    write('que é a solução do problema').

traduz(levaM, 'vai um missionário                 ').
traduz(trazM, 'volta um missionário              ').
traduz(levaMM, 'vai dois missionários             ').
traduz(trazMM, 'volta dois missionários           ').
traduz(levaC, 'vai um canibal                     ').
traduz(trazC, 'volta um canibal                  ').
traduz(levaCC, 'vai dois canibais                 ').
traduz(trazCC, 'volta dois canibais               ').
traduz(levaMC, 'vai um missionário e um canibal   ').
traduz(trazMC, 'volta um missionário e um canibal ').

% [MissionárioA, CanibalA, MissionárioB, CanibalB, Lado do barco].
inicial([3,3,0,0,1]).
meta([0,0,3,3,2]).

% Verifica se é seguro levar ou trazer.
seguro([M1,C1,M2,C2]) :- (M1>=C1;M1 is 0), (M2>=C2;M2 is 0).
    
% Operações para levar e trazer das margens.
oper(levaM, [M1,C1,M2,C2,L], [A,C1,B,C2,2]) :- 
    L==1, M1>0, 
    A is M1-1, B is M2+1, seguro([A,C1,B,C2]).
oper(trazM, [M1,C1,M2,C2,L], [A,C1,B,C2,1]) :- 
    L==2, M2>0, 
    A is M1+1, B is M2-1, seguro([A,C1,B,C2]).
oper(levaC, [M1,C1,M2,C2,L], [M1,A,M2,B,2]) :-
    L==1, C1>0, 
    A is C1-1, B is C2+1, seguro([M1,A,M2,B]).
oper(trazC, [M1,C1,M2,C2,L], [M1,A,M2,B,1]) :-
    L==2, C2>0, 
    A is C1+1, B is C2-1, seguro([M1,A,M2,B]).

oper(levaMM, [M1,C1,M2,C2,L], [A,C1,B,C2,2]) :-
    L==1, M1>1, 
    A is M1-2, B is M2+2, seguro([A,C1,B,C2]).
oper(trazMM, [M1,C1,M2,C2,L], [A,C1,B,C2,1]) :-
    L==2, M2>1, 
    A is M1+2, B is M2-2, seguro([A,C1,B,C2]).
oper(levaCC, [M1,C1,M2,C2,L], [M1,A,M2,B,2]) :-
    L==1, C1>1, 
    A is C1-2, B is C2+2, seguro([M1,A,M2,B]).
oper(trazCC, [M1,C1,M2,C2,L], [M1,A,M2,B,1]) :-
    L==2, C2>1, 
    A is C1+2, B is C2-2, seguro([M1,A,M2,B]).

oper(levaMC, [M1,C1,M2,C2,L], [A,C,B,D,2]) :-
    L==1, M1>0, C1>0, 
    A is M1-1, C is C1-1, B is M2+1, D is C2+1, seguro([A,C,B,D]).
oper(trazMC, [M1,C1,M2,C2,L], [A,C,B,D,1]) :-
    L==2, M2>0, C2>0, 
    A is M1+1, C is C1+1, B is M2-1, D is C2-1, seguro([A,C,B,D]).

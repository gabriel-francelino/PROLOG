:- use_rendering(chess).

solucao(N,S) :-
    findall(X,between(1,N,X),L), N2 is N - 1, N1 is -1 * (N - 1),
    findall(X,between(N1,N2,X),DS), N3 is 2 * N,
    findall(X,between(2,N3,X),DI),
    resolve(S,L,L,DS,DI).

resolve([],[],_,_,_).
resolve([C|LC],[L|LL],CO,DS,DI) :- 
    apaga(C,CO,CO1), NS is L - C,
    apaga(NS,DS,DS1),NI is L + C,
	apaga(NI,DI,DI1),
	resolve(LC,LL,CO1,DS1,DI1).

apaga(A,[A|B],B).
apaga(A,[B|C],[B|D]) :- apaga(A,C,D).

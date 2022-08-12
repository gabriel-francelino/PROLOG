pai(francisco, helenise).
pai(francisco, keila).
pai(chico, ricardo).
pai(chico, vandriele).
pai(chico, patricia).
pai(ricardo, gabriel).
pai(ricardo, ana).
pai(ricardo, luiz).
pai(ricardo, giovanna).

mae(helenise, gabriel).
mae(helenise, ana).
mae(helenise, luiz).
mae(helenise, giovanna).
mae(nilsa, ricardo).
mae(cleusa, helenise).
mae(nilsa, vandriele).
mae(vandriele, nicole).
mae(nilsa, patricia).
mae(cleusa, keila).
mae(keila, karine).
mae(keila, kaio).
mae(keila, kemily).
mae(patricia, matheus).
mae(patricia, ruth).

irmao(A,B) :- (pai(C,A);mae(C,A)),(pai(C,B);mae(C,B)), A\==B.

avo(A,B) :- pai(C,B),pai(A,C).
avo(A,B) :- mae(C,B),pai(A,C).
avoh(A,B) :- pai(C,B),mae(A,C).
avoh(A,B) :- mae(C,B),mae(A,C).

tio(A,B) :- pai(C,B),irmao(A,C), \+pai(A,B).
tio(A,B) :- mae(C,B),irmao(A,C), \+mae(A,B).

primo(A,B) :- tio(C,B),pai(C,A).
primo(A,B) :- tio(C,B),mae(C,A).

neto(A,B) :- avo(B,A).
neto(A,B) :- avoh(B,A).

antecessor(X,Y) :- pai(X,Y).
antecessor(X,Y) :- mae(X,Y).
antecessor(X,Y) :- pai(X,Z), antecessor(Z,Y).
antecessor(X,Y) :- mae(X,Z), antecessor(Z,Y).

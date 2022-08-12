prog :- ledado(D), calcula(D,R), escreve(R).

ledado(X) :- write("Digite um valor :"), read(X).

calcula(D,R) :- R is D * D.

escreve(X) :- write("O quadrado eh "), write(X) ,nl.

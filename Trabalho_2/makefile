relata:relata.tab.o lex.yy.o
	gcc relata.tab.o lex.yy.o -o relata -ly -lm

relata.tab.o: relata.tab.c
	gcc -c relata.tab.c

lex.yy.o: lex.yy.c
	gcc -c lex.yy.c

relata.tab.c: relata.y
	bison -d relata.y

lex.yy.c: relata.l
	flex relata.l

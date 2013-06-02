relata:relata.tab.c lex.yy.c
	gcc relata.tab.c -o relata


relata.tab.c: relata.y
	bison -d relata.y

lex.yy.c: relata.l
	flex relata.l

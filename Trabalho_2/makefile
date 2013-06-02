relata:relata.tab.c lex.yy.c
	gcc relata.tab.c -o relata
	pdflatex main.tex


relata.tab.c: relata.y
	bison -d relata.y

lex.yy.c: relata.l
	flex relata.l

clean:
	-rm relata
	-rm lex.yy.c
	-rm relata.tab.c
	-rm relata.tab.h
	-rm *.html

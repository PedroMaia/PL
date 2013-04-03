main:pppHtml pppLaTeX

pppHtml:pppHtml.o lList.o
	gcc pppHtml.o lList.o -o pppHtml -lfl

pppHtml.o:pppHtml.c
	gcc pppHtml.c -c

pppHtml.c:pppHtml.fl lList.h lList.c
	flex pppHtml.fl

pppLaTeX:pppLaTeX.o lList.o
	gcc pppLaTeX.o lList.o -o pppLaTeX -lfl

pppLaTeX.o:pppLaTeX.c
	gcc pppLaTeX.c -c

pppLaTeX.c:pppLaTeX.fl lList.h lList.c
	flex pppLaTeX.fl


lList.o: lList.c lList.h
	gcc lList.c -c	

clean:
	rm *.o
	rm pppHtml.c
	rm pppLaTeX.c
	rm pppHtml
	rm pppLaTeX

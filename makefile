ppp:ppp.o
	gcc ppp.o -o ppp

ppp.o:ppp.c
	gcc ppp.c -c

ppp.c:ppp.fl
	flex ppp.lf

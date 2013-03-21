ppp:ppp.o lList.o
	gcc ppp.o lList.o -o ppp -lfl

ppp.o:ppp.c
	gcc ppp.c -c

lList.o: lList.c lList.h
	gcc lList.c -c

ppp.c:ppp.fl lList.h lList.c
	flex ppp.fl


	

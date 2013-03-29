pppHtml:pppHtml.o lList.o
	gcc pppHtml.o lList.o -o pppHtml -lfl

pppHtml.o:pppHtml.c
	gcc pppHtml.c -c

lList.o: lList.c lList.h
	gcc lList.c -c

pppHtml.c:pppHtml.fl lList.h lList.c
	flex pppHtml.fl


	

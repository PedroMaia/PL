#include "lList.h"
#include <stdlib.h>
#include <string.h>


/**
 * \file
 * \author César Pedigão.
 * \author Luís Caseiro.
 * \author Pedro Maia.
 * \date 17/03/2012.
 * \version 1.0
 * */

/*	controlo de erros	*/
static char *err_msg[]={"No error","Element does not exist","Element already exists","File not open"};

static int err=OK;


/*	estrutura de dados	*/

typedef struct slList
{
	void *elem;
	struct slList *next;
} lListNode;

/*	definiçao das funçoes	*/


int err_lList(void)
{
	return err;
}

void err_msg_lList(void)
{
	fprintf(stderr,"%s",err_msg[err]);
}


lList push(lList l,void	*e,int size)
{
	lList aux;
	aux = (lList) malloc(sizeof(lListNode));
	aux->elem=malloc(size);
	memcpy(aux->elem,e,size);
	aux->next=l;
	err=OK;
	return aux;
}


void list_lList(lList l, void(*visit)(void*))
{
	if(l)
	{
		visit(l->elem);
		list_lList(l->next,visit);
	}
}


lList destroy_lList(lList l,void(*del_elem)(void*))
{
	if(l)
	{
		destroy_lList(l->next,del_elem);
		del_elem(l->elem);
		free(l);
	}
	err=OK;
	return NULL;
}

void *head(lList l)
{
	if(l)
	{
		err=OK;
		return l->elem;
	}
	else
	{
		err=NO_EXIST;
		return NULL;
	}
}

lList tail(lList l)
{
	if(l)
	{
		err=OK;
		return l->next;
	}
	else
	{
		err=NO_EXIST;
		return NULL;
	}
}

lList map(lList l, void (*visit)(void*))
{
	lList aux=l;
	while(l)
	{
		visit(l->elem);
		l=l->next;
	}
	err=OK;
	return aux;
}


lList filter(lList l,int(*fun)(void*),int size)
{
	lList aux=NULL;
	if(l)
	{
		if(fun(l->elem))
		{
			aux = push(aux,l->elem,size);
			aux->next=filter(l->next,fun,size);
		}
		else aux=filter(l->next,fun,size);
	}
	err=OK;
	return aux;
}


lList pop(lList l, void *e,int size,void(*del_elem)(void*))
{
	lList aux=NULL;
	
	if(l)
	{
		memcpy(e,l->elem,size);
		aux=l->next;
		del_elem(l->elem);
		free(l);
		err=OK;
	}
	else err=NO_EXIST;
	return aux;
}


lList sorted_insert(lList l,void *e,int size,int (*comp)(void*,void*))
{
	if((!l)||(comp(e,l->elem)>0))
	{
		err=OK;
		return push(l,e,size);
	}
	else
	if(comp(e,l->elem)<0)
	{
		l->next=sorted_insert(l->next,e,size,comp);
	}
	else err=EXIST;
	return l;
}

void *procura_lList(lList l, void *e,int (*comp)(void*,void*))
{
	if(!l)
	{
		err=NO_EXIST;
		return NULL;
	}
	else
	{
		if(comp(l->elem,e)==0)
		{
			err=OK;
			return l->elem;
		}
		else 
		{
			return procura_lList(l->next,e,comp);
		}
	}
}





lList remove_lList(lList l, void *e, int (*comp)(void*,void*),void(*del_elem)(void*))
{
	lList aux;
	if(!l)
	{
		err=NO_EXIST;
		return l;
	}
	else
	{
		if(comp(e,l->elem)==0)
		{
			aux=l->next;
			del_elem(l->elem);
			free(l);
			err=OK;
			return aux;
		}
		else
		{
			l->next=remove_lList(l->next,e,comp,del_elem);
			return l;
		}
	}
}


int lenght_lList(lList l)
{
	int res=0;
	while(l)
	{
		res++;
		l=l->next;
	}
	return res;
}


/*Função auxiliar que recebe Dile, o elemento void*/
int write_elem  (void* elem,FILE * File,int size)
{ int ct;

  if (elem==NULL)
  {
	perror("erro_list");
  }
	
	if(elem!=NULL)
	ct=fwrite(elem,size,1,File);
	
	if(ct<1)
	perror("No write to file");
return 1;
}

/*Funçaõ de escrita da lista, recebe um ficheiro f, o tamanho dos elemntos */
int write_List(lList l,FILE* f,int size)
{ 
 if(!f)
	{
	err=FILE_NOT_OPEN;
	return 0; 
	}
	else
	
	if (l)
	{
		write_List(l->next, f,size);
		write_elem(l->elem, f,size);
	}

return 1;
}

/*dá como resultado a lista carregada, le o ficheiro f, e vai alocando espaço para os elementos*/
lList read_List(FILE *f,int data_size)
{ 
	void* buffer=NULL;
	lList l=NULL;
	if(f==NULL)
	{
		err=FILE_NOT_OPEN;
		return NULL;
	}


	buffer=malloc(data_size);

	while(fread(buffer,data_size,1,f))
	{
		l=push(l,buffer,data_size);
	}

	free(buffer);

	return l;
}


lList read_List_length(FILE *f,int data_size,int length)
{
	void* buffer=NULL;
	int i;
	lList l=NULL;
	
	if(f==NULL)
	{
		err=FILE_NOT_OPEN;
		return NULL;
	}


	buffer=malloc(data_size);
	for(i=0;i<length;i++)
	{
	if(fread(buffer,data_size,1,f))
		{
			l=push(l,buffer,data_size);
		}
	}

	free(buffer);

	return l;
}

void list_reverse_lList(lList l, void(*visit)(void*))
{
	if(l)
	{
		list_lList(l->next,visit);
		visit(l->elem);
	}
}

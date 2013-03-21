
#ifndef _lList
#define _lList
#include <stdio.h>
/**
 * \file
 * \author César Pedigão.
 * \author Luís Caseiro.
 * \author Pedro Maia.
 * \date 17/03/2012.
 * \version 1.0
 * */

/**		Estruturas de dados			*/
typedef struct slList *lList;

/**		Codigos de Erro 			*/
#define OK 0
#define NO_EXIST 1
#define EXIST 2
#define FILE_NOT_OPEN 3

/**	Prototipos de Funções de Erro	*/

int err_lList(void); 

void err_msg_lList(void); 

/** 		Prototipo das Funções		*/

/**\brief A Função push aloca espaço para um novo elemento na lista e coloca-o na head da lista.
 * \param l lista de entrada.
 * \param *e, elemento a colocar na cabeça da lista.
 * \param size comprimento que é necessário alocar para colocar o elemento e na lista lList.
 * \return aux lista com o elemento e na sua primeira posição.
 * 
 * */

lList push(lList l,void	*e,int size); 

/**\brief A função pop vai guardar um elemento numa posição de memoria retirar esse elemento da lList.
 * \param l lista de entrada.
 * \param *e posição de memoria.
 * \param *del_elem função que elimina elementos.
 * \param size comprimento que é necessário alocar a posição de memoria.
 * \return aux nova lista sem a head.
 * */

lList pop(lList l, void *e,int size,void(*del_elem)(void*));

/**\brief A Função list_lList vai fazer a listagem de dados.
 * \param l lista de entrada.
 * \param *visit função que define o output da listagem.
 * */

void list_lList(lList l, void(*visit)(void*));

/**\brief A Função list_lList vai fazer a listagem de dados de ordem inversa.
 * \param l lista de entrada.
 * \param *visit função que define o output da listagem.
 * */
 
void list_reverse_lList(lList l, void(*visit)(void*));

/**\brief A função insere elementos na lista de maneira a esta estar ordena.
 * \param l lista de entrada.
 * \param *e elemento a inserir.
 * \param size comprimento que é necessário alocar para colocar elemento.
 * \param *comp função de comparação que retorna 1 se menor,-1 se maior e 0 se igual.
 * \return l lista ordenada pela função comp.
 * */
 


lList sorted_insert(lList l,void *e,int size,int (*comp)(void*,void*)); 


/**\brief A Função procura um elemento numa lList.
 * \param l lista de entrada.
 * \param *e elemento a procurar na lista.
 * \param *comp função de comparação que retorna 0 se encontrar o elemento.
 * \return NULL se o elemento não estiver na lList.
 * \return l->elem o elemento já está na lista.
 * */

void *procura_lList(lList l, void *e,int (*comp)(void*,void*)); 

/**\brief A Função head vai procurar o primeiro elemento da lista.
 * \param l lista de entrada.
 * \return l->elem head da lList l.
 * \return NULL caso a lista não contenha nenhum elemento.
 * */

void *head(lList l); 

/**\brief A Função tail vai procurar todos os elementos da lista excepto o primeiro. 
 * \param l lista de entrada.
 * \return l->next tail da lList l.
 * \return NULL caso a lista não contenha nenhum elemento.
 * */

lList tail(lList l);

/**\brief A Função filter vai filtrar os elementos da lList através da Função fun.
 * \param l lista de entrada.
 * \param *fun função aplicada à lList l.
 * \param size comprimento que é necessário alocar para criar uma nova lList.
 * \return aux lista filtrada por a função fun. 
 * */

lList filter(lList l,int(*fun)(void*),int size); 

/**\brief A Função map vai aplicar a todos os elementos da lList l a função visit.
 * \param l lista de entrada.
 * \param *visit
 * \return aux lista resultante da aplicação da função visit à lList l.
 * */

lList map(lList l, void (*visit)(void*)); 

/**\brief A função destroi uma lList.
 * \param l lista de entrada.
 * \param *del_elem função que apaga um elemento de uma lista.
 * \return NULL a lista foi eliminada.
 * */


lList destroy_lList(lList l,void(*del_elem)(void*));

/**\brief A função calcula o comprimento da lList.
 * \param l lista de entrada.
 * \return res comprimento da lList.
 * */

int lenght_lList(lList l);

/**\brief A função retira um elemento de uma lList.
 * \param l lista deint write_List(lList l,FILE* f,int size) entrada.
 * \param *e elemento a retirar da lista.
 * \param *comp função de comparação que retorna 0 se encontrar o elemento.
 * \param *del_elem função para retirar um elemento.
 * \return l caso o elemento não esteja na lista.
 * \return aux lista sem o elemento que queriamos retirar.
 * */

lList remove_lList(lList l, void *e, int (*comp)(void*,void*),void(*del_elem)(void*));

/**\brief Função que escreve uma lista l num ficheiro.
 * \param l Lista de entrada.
 * \param f ficheiro que vai ser escrito.
 * \param size tamanho dos elementos a inserir.
 * \return 1 caso a lista tenha sido escrita no ficheiro.
 * \return 0 caso o ficheiro não se encontre aberto.
 * */
 
int write_List(lList l,FILE*f,int size);

/**\brief Função que carrega para uma lista o conteudo de um ficheiro.
 * \param f ficheiro com a informação.
 * \param data_size tamanho da estrutura de entrada.
 * \return NULL caso o ficheiro esteja aberto.
 * \return lista com os elementos do ficheiro. 
 * */

lList read_List(FILE*f,int data_size);

/**\brief Função que carrega para uma lista, com tamanho limitado, o conteudo de um ficheiro.
 * \param f ficheiro com a informação.
 * \param data_size tamanho da estrutura de entrada.
 * \param lenght tamanho final da lista.
 * \return NULL caso o ficheiro esteja aberto.
 * \return lista com os elementos do ficheiro. 
 * */

lList read_List_length(FILE *f,int data_size,int length);

#endif

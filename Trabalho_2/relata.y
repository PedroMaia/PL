%{
	#include <stdio.h>
	#include "lex.yy.c"
	#define MODE_INDEX 0
	#define MODE_REPORT 1
	char toc[10000];
	char lof[10000];
	char lot[10000];
	char temp[1000];
	int mode=MODE_INDEX;
	int footnoteNo=0;
	int nindex=0;
%}

%token BREPORT EREPORT BFM EFM BTITLE ETITLE BSUBTITLE ESUBTITLE BAUTHOR EAUTHOR BNAME ENAME BNIDENT ENIDENT BEMAIL EEMAIL BURL EURL BAFFILIATION EAFFILIATION BABS EABS BAKN EAKN TOC LOF LOT BBODY EBODY BCHAP ECHAP BSEC ESEC BPARA EPARA BREF EREF BXREF EXREF BCIT ECIT BITERM EITERM BBOLD EBOLD BITALIC EITALIC BUNDERLINE EUNDERLINE BFIG EFIG BGRAPH EGRAPH BCAPTION ECAPTION BTABLE ETABLE BTROW ETROW BTDATA ETDATA TEXTO BDATE EDATE BINST EINST BKEYW EKEYW BFORMAT EFORMAT BLIST ELIST BITEM EITEM BACRON EACRON BCODE ECODE BCODEL ECODEL BFOOT EFOOT BSUMMARY ESUMMARY

%union
{
	char* texto;
	
}

%type <texto> TEXTO Caption Title SubTitle

%start Report


%%

Report: BREPORT {if(mode==MODE_REPORT){
	printf("<!DOCTYPE html>\n<html>\n <a href='./index.html'>Indice</a> ");
	/*Para os acentos*/
	printf("<meta charset='utf-8'>\n");
	printf("<html><body>");}} 
	FrontMatter Body BackMatter EREPORT {if(mode==MODE_REPORT) printf("</body></html>");}'$' {return 0;};

FrontMatter:BFM Title SubTitle {if(mode==MODE_REPORT){
					printf("<h1>%s</h1>\n",$2);
					printf("<h2>%s</h2>\n",$3);
				} } Authors {if(mode==MODE_REPORT) printf("<hr>\n");} Date Institution Keywords Abstract Aknowledgements Toc Lof Lot EFM ;

Title: BTITLE TEXTO ETITLE {$$=$2;};

SubTitle:BSUBTITLE TEXTO ESUBTITLE {$$=$2;}
	|{$$=strdup("");}
	;

Authors: Authors Author
	|Author;

Author: BAUTHOR {if(mode==MODE_REPORT) printf("<address>");} Name Nident Email Url Affiliation EAUTHOR 
		{if(mode==MODE_REPORT) printf("</address>\n");};

Name: BNAME TEXTO ENAME {if(mode==MODE_REPORT) printf("%s<br>\n",$2);};
Nident: BNIDENT TEXTO ENIDENT {if(mode==MODE_REPORT) printf("%s<br>\n",$2);}
	|;
Email: BEMAIL TEXTO EEMAIL {if(mode==MODE_REPORT) printf("<a href=\"mailto:%s\">%s</a><br>",$2,$2);}
	|;
Url: BURL TEXTO EURL {if(mode==MODE_REPORT) printf("<a href=\"%s\">%s</a><br>",$2,$2);}
	|;
Affiliation: BAFFILIATION TEXTO EAFFILIATION {if(mode==MODE_REPORT) printf("%s<br>\n",$2);}
	|;

Date: BDATE TEXTO EDATE {if(mode==MODE_REPORT) printf("%s\n",$2);};

Institution: BINST TEXTO EINST {if(mode==MODE_REPORT) printf("%s\n",$2);}
	|
	;

Keywords: BKEYW TEXTO EKEYW {if(mode==MODE_REPORT) printf("<hr><p><i>%s</i></p>\n",$2);}
	| 
	;

Abstract: BABS {if(mode==MODE_REPORT) printf("<hr>"); } ParaList EABS;

Aknowledgements: BAKN {if(mode==MODE_REPORT) printf("<hr>"); } ParaList EAKN;

Toc: TOC {if(mode==MODE_REPORT) printf("<hr><h2>Índice</h2> %s",toc);} | ;
Lof:LOF {if(mode==MODE_REPORT) printf("%s",lof);} | ;
Lot: LOT {if(mode==MODE_REPORT) printf("%s",lot);} | ;

Body: BBODY ChapterList EBODY;
ChapterList: ChapterList Chapter
	| Chapter;

Chapter: BCHAP Title {if(mode==MODE_REPORT) {
			printf("<hr><h1><a name=\"ind%d\"> %s </a></h1>\n",nindex,$2); nindex++;}
		else{
			sprintf(temp,"<h5><p><a href=\"#ind%d\"> %s </a></p></h5>\n",nindex,$2);
			strcat(toc,temp);
			nindex++;
		}
		} ElemList ECHAP;

Section: BSEC Title {if(mode==MODE_REPORT) {
			printf("<h2><a name=\"ind%d\"> %s </a></h2>\n",nindex,$2); 
			nindex++;}
		else{
			sprintf(temp,"<h6><p><a href=\"#ind%d\"> %s </a></p></h6>\n",nindex,$2);
			strcat(toc,temp);
			nindex++;
		}
		} ElemList ESEC ;

ElemList: ElemList Elem
	|Elem;

Elem: Paragraph
	|Float
	|List
	|CodeBlock
	|Section;

ParaList: ParaList Paragraph
	|Paragraph;
Paragraph: BPARA {if(mode==MODE_REPORT) printf("<p>");} ParaContent EPARA {if(mode==MODE_REPORT) printf("</p>");};
ParaContent:ParaContent TEXTO {if(mode==MODE_REPORT) printf("%s",$2);}
	|ParaContent FreeElem
	|;

FreeElem:Ref
	|Bold
	|Italic
	|Underline
	|InlineCode
	|Acronym;

Ref: BREF TEXTO EREF {if(mode==MODE_REPORT) printf("<a href=\"%s\">%s</a>",$2,$2);};

Bold: BBOLD {if(mode==MODE_REPORT) printf("<b>");} BContent EBOLD {if(mode==MODE_REPORT) printf("</b>");}
BContent: BContent TEXTO {if(mode==MODE_REPORT) printf("%s",$2);}
	| BContent Italic
	| BContent Underline
	| ;

Italic: BITALIC {if(mode==MODE_REPORT) printf("<i>");} IContent EITALIC {if(mode==MODE_REPORT) printf("</i>");}
IContent: IContent TEXTO {if(mode==MODE_REPORT) printf("%s",$2);}
	| IContent Bold
	| IContent Underline
	| ;

Underline: BUNDERLINE {if(mode==MODE_REPORT) printf("<u>");} UContent EUNDERLINE {if(mode==MODE_REPORT) printf("</u>");}
UContent: UContent TEXTO {if(mode==MODE_REPORT) printf("%s",$2);}
	| UContent Italic
	| UContent Bold
	| ;

Float: Figure|Table;

Figure: BFIG {if(mode==MODE_REPORT) printf("<figure>");} Graphic Caption EFIG 
	{if(mode==MODE_REPORT) {
		printf("<figcaption>%s</figcaption>\n",$4);
		printf("</figure>");
	}};
Graphic: BGRAPH TEXTO EGRAPH {if(mode==MODE_REPORT) printf("<img src=\"%s\">",$2);};

Caption: BCAPTION TEXTO ECAPTION{$$=$2;};

List: BLIST {if(mode==MODE_REPORT) printf("<ul>");}Items ELIST{if(mode==MODE_REPORT) printf("</ul>");};
Items:Items Item
	|;

Item: BITEM {if(mode==MODE_REPORT) printf("<li>");}ParaContent EITEM {if(mode==MODE_REPORT) printf("</li>");};

Acronym: BACRON TEXTO EACRON {if(mode==MODE_REPORT) printf("<i>%s</i>",$2);};

CodeBlock: BCODE TEXTO ECODE{if(mode==MODE_REPORT) printf("<p><code> %s </code></p>\n",$2);};

InlineCode: BCODEL TEXTO ECODEL{if(mode==MODE_REPORT) printf("<code> %s </code>\n",$2);};

Table: ;

BackMatter: ;

%%

int yyerror(){

	


	fprintf(stderr, "Erro sintatico:(%s) na linha:%d",yytext, yylineno);
	return 1;
}

int main(int argc, char **argv){
	

	FILE *input = fopen(argv[1],"r");
	
	yyin = input;
	yyparse();
	mode=MODE_REPORT;
	nindex=0;
	fseek(yyin,0,SEEK_SET);
	yyparse();
}






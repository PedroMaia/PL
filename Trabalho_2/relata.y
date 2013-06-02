%{
	#include <stdio.h>
	#include "lex.yy.c"
	#define MODE_INDEX 0
	#define MODE_REPORT 1
	char toc[1000];
	char lof[1000];
	char lot[1000];
	int mode=MODE_INDEX;
	int footnoteNo=1;
%}

%token BREPORT EREPORT BFM EFM BTITLE ETITLE BSUBTITLE ESUBTITLE BAUTHOR EAUTHOR BNAME ENAME BNIDENT ENIDENT BEMAIL EEMAIL BURL EURL BAFFILIATION EAFFILIATION BABS EABS BAKN EAKN TOC LOF LOT BBODY EBODY BCHAP ECHAP BSEC ESEC BPARA EPARA BREF EREF BXREF EXREF BCIT ECIT BITERM EITERM BBOLD EBOLD BITALIC EITALIC BUNDERLINE EUNDERLINE BFIG EFIG BGRAPH EGRAPH BCAPTION ECAPTION BTABLE ETABLE BTROW ETROW BTDATA ETDATA TEXTO BDATE EDATE BINST EINST BKEYW EKEYW BFORMAT EFORMAT BLIST ELIST BITEM EITEM BACRON EACRON BCODE ECODE BCODEL ECODEL BFOOT EFOOT BSUMMARY ESUMMARY

%union
{
	char* texto;
	
}

%type <texto> TEXTO Caption

%start Report


%%

Report: BREPORT FrontMatter Body BackMatter EREPORT '$'
	{if(mode==MODE_INDEX) {
		mode=MODE_REPORT;
		
	}};

FrontMatter:BFM Title SubTitle Authors Date Institution Keywords Abstract Aknowledgements Toc Lof Lot EFM ;

Title: BTITLE TEXTO ETITLE {if(mode==MODE_REPORT){printf("<h1>%s</h1>\n",$2);}};

SubTitle:BSUBTITLE TEXTO ESUBTITLE {if(mode==MODE_REPORT){printf("<h2>%s</h2>\n",$2);}}
	|
	;

Authors: Authors Author
	|Author;

Author: BAUTHOR Name Nident Email Url Affiliation EAUTHOR;

Name: BNAME TEXTO ENAME;
Nident: BNIDENT TEXTO ENIDENT 
	|;
Email: BEMAIL TEXTO EEMAIL
	|;
Url: BURL TEXTO EURL
	|;
Affiliation: BAFFILIATION TEXTO EAFFILIATION 
	|;

Date: BDATE TEXTO EDATE;

Institution: BINST TEXTO EINST
	|
	;

Keywords: BKEYW TEXTO EKEYW 
	| 
	;

Abstract: BABS ParaList EABS;

Aknowledgements: BAKN ParaList EAKN;

Toc: TOC {if(mode==MODE_REPORT) printf("%s",toc);} | ;
Lof:LOF {if(mode==MODE_REPORT) printf("%s",lof);} | ;
Lot: LOT {if(mode==MODE_REPORT) printf("%s",lot);} | ;

Body: BBODY ChapterList EBODY;
ChapterList: ChapterList Chapter
	| Chapter;

Chapter: BCHAP Title ElemList ECHAP;

Section: BSEC Title ElemList ESEC;

ElemList: ElemList Elem
	|Elem;

Elem: Paragraph
	|Float
	|List
	|CodeBlock
	|Section
	|Summary;

ParaList: ParaList Paragraph
	|Paragraph;
Paragraph: BPARA {if(mode==MODE_REPORT) printf("<p>");} ParaContent EPARA {if(mode==MODE_REPORT) printf("</p>");};
ParaContent:ParaContent TEXTO {if(mode==MODE_REPORT) printf("%s",$2);}
	|ParaContent FreeElem
	|;

FreeElem: Footnote
	|Ref
	|Xref
	|Citref
	|Iterm
	|Bold
	|Italic
	|Underline
	|InlineCode
	|Acronym;

Ref: BREF TEXTO EREF;
Xref: BXREF TEXTO EXREF;
Citref: BCIT TEXTO ECIT;
Iterm: BITERM TEXTO EITERM;

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

Acronym: BACRON TEXTO EACRON;

CodeBlock: BCODE TEXTO ECODE{if(mode==MODE_REPORT) printf("<p><code> %s </code></p>\n",$2);};

InlineCode: BCODEL TEXTO ECODEL{if(mode==MODE_REPORT) printf("<code> %s </code>\n",$2);};

Footnote: BFOOT TEXTO EFOOT ;

Summary: BSUMMARY TEXTO ESUMMARY;

Table: ;

BackMatter: ;

%%

int yyerror(){

	fprintf(stderr, "Erro sintatico:(%s) na linha:%d",yytext, yylineno);
	return 1;
}

int main(){
	yyparse();

}






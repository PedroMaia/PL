%{

%}

%token BREPORT EREPORT BFM EFM BTITLE ETITLE BSUBTITLE ESUBTITLE BAUTHOR EAUTHOR BNAME ENAME BNIDENT ENIDENT BEMAIL EEMAIL BURL EURL BAFFILIATION EAFFILIATION BABS EABS BAKN EAKN TOC LOF LOT BBODY EBODY BCHAP ECHAP BSEC ESEC BPARA EPARA BREF EREF BXREF EXREF BCIT ECIT BITERM EITERM BBOLD EBOLD BITALIC EITALIC BUNDERLINE EUNDERLINE BFIG EFIG BGRAPH EGRAPH BCAPTION ECAPTION BTABLE ETABLE BTROW ETROW BTDATA ETDATA TEXTO BDATE EDATE BINST EINST BKEYW EKEYW BFORMAT EFORMAT

%union
{
	char* texto;

}

%type <texto> TEXTO
%start Report


%%

Report: BREPORT FrontMatter Body BackMatter EREPORT;

FrontMatter:BFM Title SubTitle Authors Date Institution Keywords Abstract Aknowledgements Toc Lof Lot EFM;

Title: BTITLE TEXTO ETITLE;

SubTitle:BSUBTITLE TEXTO ESUBTITLE
	|
	;

Authors: Authors Author
	|Author;

Author: BAUTHOR Name Nident Email Url Affiliation EAUTHOR;

Name: BNAME TEXTO ENAME;

Nident: BNIDENT TEXTO ENIDENT ;
Email: BEMAIL TEXTO EEMAIL ;
Url: BURL TEXTO EURL ;
Affiliation: BAFFILIATION TEXTO EAFFILIATION ;

Date: BDATE TEXTO EDATE;

Institution: BINST TEXTO EINST
	|
	;

Keywords: BKEYW TEXTO EKEYW
	|
	;

Abstract: BABS ParaList EABS;

Aknowledgements: BAKN ParaList EAKN;

Toc: TOC | ;
Lof:LOF | ;
Lot: LOT | ;

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

Paragraph: BPARA ParaContent EPARA;
ParaContent:ParaContent texto
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
Citref: BCIT TETXO ECIT;
Iterm: BITERM TEXTO EITERM;

Bold: BBOLD BContent EBOLD;
BContent: BContent TEXTO
	| BContent Italic
	| BContent Underline
	| ;

Italic: BITALIC IContent EITALIC;
IContent: IContent TEXTO
	| IContent Bold
	| IContent Underline
	| ;

Underline: BUNDERLINE UContent EUNDERLINE;
UContent: UContent TEXTO
	| UContent Italic
	| UContent Bold
	| ;

Float: Figure|Table;

Figure: BFIG Graphic Caption EFIG;
Graphic: BGRAPH TEXTO Format EGRAPF;

Format: BFORMAT TEXTO EFORMAT
	|;

Caption: BCAPTION TEXTO ECAPTION;




%%



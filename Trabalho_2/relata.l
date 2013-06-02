%option noyywrap

%{
	#include "relata.tab.h"
%}



%%

"<report>"	return BREPORT;
"</report>"	return EREPORT;

"<fm>"	return BFM;
"</fm>"	return EFM;

"<title>"	return BTITLE;
"</title>"	return ETITLE;

"<subtitle>"	return BSUBTITLE;
"</subtitle>"	return ESUBTITLE;

"<author>"	return BAUTHOR;
"</author>"	return EAUTHOR;

"<name>"	return BNAME;
"</name>"	return ENAME;

"<nident>"	return BNIDENT;
"</nident>"	return ENIDENT;

"<email>"	return BEMAIL;
"</email>"	return EEMAIL;

"<url>"		return BURL;
"</url>"	return EURL;

"<affiliation>"	return BAFFILIATION;
"</affiliation>"	return EAFFILIATION;

"<abs>"	return BABS;
"</abs>"	return EABS;

"<akn>"	return BAKN;
"</akn>"	return EAKN;

"<toc/>"	return TOC;
"<lof/>"	return LOF;
"<lot/>"	return LOT;

"<body>"	return BBODY;
"</body>"	return EBODY;

"<chap>"	return BCHAP;
"</chap>"	return ECHAP;

"<sec>"	return BSEC;
"</sec>"	return ESEC;

"<para>"	return BPARA;
"</para>"	return EPARA;

"<ref>"	return BREF;
"</ref>"	return EREF;

"<xref>" return BXREF;
"</xref>" return EXREF;

"<cit>" return BCIT;
"</cit>" return ECIT;

"<iterm>" return BITERM;
"</iterm>" return EITERM;


"<bold>" return BBOLD;
"</bold>" return EBOLD;


"<italic>" return BITALIC;
"</italic>" return EITALIC;

"<underline>" return BUNDERLINE;
"</underline>" return EUNDERLINE;

"<fig>" return BFIG;
"</fig>" return EFIG;

"<graph>" return BGRAPH;
"</graph>" return EGRAPH;

"<caption>" return BCAPTION;
"</caption>" return ECAPTION;

"<table>" return BTABLE;
"</table>" return ETABLE;

"<trow>" return BTROW;
"</trow>" return ETROW;

"<tdata>" return BTDATA;
"</tdata>" return ETDATA;

"<date>"	return BDATE ;
"</date>"	return EDATE;

"<inst>"	return BINST;
"</inst>"	return EINST;

"<keyw>"	return BKEYW;
"</keyw>"	return EKEYW;

"<format>"	return BFORMAT;
"</format>"	return EFORMAT;

"<list>"	return BLIST;
"</list>"	return ELIST;

"<item>"	return BITEM;
"</item>"	return EITEM;

"<acron>"	return BACRON;
"</acron>"	return EACRON;

"<code>"	return BCODE;
"</code>"	return ECODE;

"<codel>"	return BCODEL;
"</codel>"	return ECODEL;

"<foot>"	return BFOOT;
"</foot>"	return EFOOT;

"<summary>"	return BSUMMARY;
"</summary>"	return ESUMMARY;

[\n\t]*		{}

[^<>]*	{yylval.texto=strdup(yytext); return TEXTO;}

<<EOF>>		return '$';

%%



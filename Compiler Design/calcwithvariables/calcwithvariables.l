%option noyywrap

%{
# include "calcwithvariables.tab.h"
void yyerror(char *s);
%}

%%
"+"	{ return ADD; }
"-"	{ return SUB; }
"*"	{ return MUL; }
"/"	{ return DIV; }
":="    {return ASSIGN;}
"print" {return PRINT;}
";"     {return SEMIC;}
[a-z]{1} {yylval = yytext[0] - '0'; return VAR;}
[0-9]+	{ yylval = atoi(yytext); return NUMBER; }

\n      { /* ignore white space */  }
[ \t]   { /* ignore white space */ }
.	{ yyerror("syntax error");}
%%
%{
	char notComments[1000];
%}

%%
\"[^\"]*\"	{ strcat(notComments,yytext); }
\*\*.*		{}
\{[^\}]*\}	{}
\{[^\}]*	{ strcat(notComments, "syntax error\n"); return 0; }
\[^\{]*\}	{ strcat(notComments, "syntax error\n"); return 0; }
\}		{ strcat(notComments, "syntax error\n"); return 0; }
\n		{ strcat(notComments,yytext); }
.		{ strcat(notComments,yytext); }
%%

int main()
{
  yylex();
  printf("%s", notComments);
  return 0;
}
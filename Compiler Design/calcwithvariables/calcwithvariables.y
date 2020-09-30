%{
#  include <stdio.h>
#  include <stdlib.h>
#  include <string.h>
int yylex();
void yyerror(char *s);

int varArray[26] = { };

%}

/* declare tokens */
%token NUMBER
%token ADD SUB MUL DIV
%token ASSIGN
%token PRINT
%token VAR
%token SEMIC

%%

input: 
 | input VAR ASSIGN exp SEMIC {/*printf("= %d\n> ", $4 /*, ($1)-49);*/ varArray[($2)-49] = $4;}
 | input PRINT VAR SEMIC {printf("%d\n", varArray[($3)-49]);}
;

exp: factor 
 | exp ADD factor { $$ = $1 + $3; }
 | exp SUB factor { $$ = $1 - $3; }
 ;

factor: term
 | factor MUL term { $$ = $1 * $3; }
 | factor DIV term { $$ = $1 / $3; }
 ;

term: NUMBER
 | SUB NUMBER {$$ = 0 - $2;}
 | VAR {$$ = varArray[($1)-49];}
 ;

%%
int main()
{
  /*printf("> "); */
  yyparse();
  return 0;
}

void yyerror(char *s)
{
  fprintf(stderr, "%s\n", s);
}
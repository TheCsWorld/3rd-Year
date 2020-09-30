%{
int evenCount = 0;
%}

%%
[0-9]*[02468]	{ evenCount++; }
[0-9]*[13579]	{ }
(\n|.)		{ }
%%

int main()
{
  yylex();
  printf("%d\n", evenCount);
  return 0;
}
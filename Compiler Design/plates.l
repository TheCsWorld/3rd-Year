%{
%}
YEAR80  87|88|89
YEAR90  90|91|92|93|94|95|96|97|98|99
YEAR00  00|01|02|03|04|05|06|07|08|09
YEAR10  10|11|12
YEAR131  131|132|141|142|151|152|161|162|171|172|181|182|191|192
COUNTY14  C|CE|CN|CW|D|DL|G|KE|KK|KY|L|LD|LH|LM|LS|MH|MN|MO|OY|RN|SO|T|W|WH|WX|WW
COUNTY13  C|CE|CN|CW|D|DL|G|KE|KK|KY|L|LD|LK|LH|LM|LS|MH|MN|MO|OY|RN|SO|TN|TS|W|WD|WH|WX|WW
NUMBER  [0-9]{1,6}
INVALID = "INVALID"


%%
{YEAR80{1}\-{COUNTY13}{1}\-{NUMBER}{1}(" "|\t|\n)+		{yearDiff(yytext);}
{YEAR90}{1}\-{COUNTY13}{1}\-{NUMBER}{1}(" "|\t|\n)+		{yearDiff(yytext);}	
{YEAR00}{1}\-{COUNTY13}{1}\-{NUMBER}{1}(" "|\t|\n)+		{yearDiff(yytext);}	
{YEAR10}{1}\-{COUNTY13}{1}\-{NUMBER}{1}(" "|\t|\n)+		{yearDiff(yytext);}	
{YEAR131}{1}\-{COUNTY13}{1}\-{NUMBER}{1}(" "|\t|\n)+	{yearDiff(yytext);}	
{YEAR131}{1}\-{COUNTY14}{1}\-{NUMBER}{1}(" "|\t|\n)+	{yearDiff(yytext);}	
.*				{printf("INVALID");}
"\n"+ 	{}

%%

int yearDiff(char plate[]){
		char year[2];
		int p = plate[0]-'0';
		int i = 0;
		
		if(p<2)
		{
			for(i=0;i<2;i++){
				year[i]=plate[i];
			}
			int diff = 19-atoi(year);
			printf("%d\n",diff);
		}
		char dYear[] = "1900";
		if(p>=8){
			for(i=0;i<2;i++){
				dYear[i+2]=plate[i];
			}
			int diff =2019-atoi(dYear);
			printf("d\n",diff);
		}
}

int main()
{
  yylex()
  return 0;
}
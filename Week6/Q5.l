%{
#include "y.tab.h"
#include <stdlib.h>
%}

%%
"true"  { yylval = 1; return BOOL; }
"false" { yylval = 0; return BOOL; }
"&&"    { return AND; }
"||"    { return OR; }
"!"     { return NOT; }
[0-9]+  { yylval = atoi(yytext); return NUM; }
[ \t\n] ;
.       { return yytext[0]; }
%%
int yywrap() { return 1; }
%{
#include "y.tab.h"
#include <stdlib.h>
#include <stdio.h>
%}

%%

[0-9]+\.[0-9]+  { yylval.fval = atof(yytext); return FLOAT_NUM; }
[0-9]+          { yylval.fval = (float)atoi(yytext); return INT_NUM; }
[a-zA-Z]+       { return ID; }
[ \t]           ;
\n              { return 0; }
.               { return yytext[0]; }

%%

int yywrap() { return 1; }
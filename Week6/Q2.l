%{
#include "y.tab.h"
#include <string.h>
%}

%%

"int"       { yylval.ival = 1; return INT_TYPE; }
"float"     { yylval.ival = 2; return FLOAT_TYPE; }
"char"      { yylval.ival = 3; return CHAR_TYPE; }

[a-zA-Z][a-zA-Z0-9]* { 
    yylval.str = strdup(yytext); 
    return ID; 
}

[ \t\n]     ;
.           { return yytext[0]; }

%%

int yywrap() { return 1; }
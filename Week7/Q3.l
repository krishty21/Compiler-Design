%{
#include "y.tab.h"
#include <string.h>
%}

%%

[A-Z]       { yylval.str = strdup(yytext); return NT; }
[a-z]       { yylval.str = strdup(yytext); return T; }
"->"        { return ARROW; }
"|"         { return OR; }
";"         { return SEMICOLON; }
[ \t\n]     ;
.           { return yytext[0]; }

%%

int yywrap() { return 1; }
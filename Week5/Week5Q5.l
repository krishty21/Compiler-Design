%{
#include "y.tab.h"
%}

%%
[01] { yylval = yytext[0] - '0'; return BIN; }
"."  return DOT;
\n   return 0;
%%

int yywrap(){ return 1; }

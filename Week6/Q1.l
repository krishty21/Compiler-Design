%{
#include "y.tab.h"
%}

%%

[a-zA-Z0-9]+    { return ID; }
[ \t]           ;
\n              { return yytext[0]; }  /* This was the fix: return newline, don't return 0 */
.               { return yytext[0]; }

%%

int yywrap() {
    return 1;
}
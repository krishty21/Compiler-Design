%{
#include "y.tab.h"
int pos = 0;
%}

%%
"("     { pos++; return LPAREN; }
")"     { pos++; return RPAREN; }
\n      { return 0; }
.       { pos++; }
%%

int yywrap() { return 1; }
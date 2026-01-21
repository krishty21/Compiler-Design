%{
#include "y.tab.h"
%}
%%
[a-z] return ID;
"&&" return AND;
"||" return OR;
"<<" return SHL;
">>" return SHR;
"==" return EQ;
"!=" return NE;
[+\-*/%<>=|&()] return yytext[0];
\n return 0;
%%
int yywrap(){ return 1; }

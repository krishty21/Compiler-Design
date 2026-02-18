/*1. Given the grammar: (2 Marks)
E → E + T
E → T
T → T * F
T → F
F → P ^ F
F → P
P → (E)
P → id
Task:
Write an SDT to generate postfix notation.*/

%{
#include "y.tab.h"
%}

%%
[0-9]+      { yylval = atoi(yytext); return NUM; }
[a-zA-Z]+   { return ID; }
[ \t\n]     ;
.           { return yytext[0]; }
%%

int yywrap() { return 1;

}
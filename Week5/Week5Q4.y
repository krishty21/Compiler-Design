%{
#include <stdio.h>
int yylex();
void yyerror(const char *s);
%}
%%
E: E'+'T { printf("+"); }
 | E'-'T { printf("-"); }
 | T
 ;
T: T'*'F { printf("*"); }
 | T'/'F { printf("/"); }
 | F
 ;
F: '('E')'
 | [a-z] { printf("%c",$1); }
 ;
%%
int main(){ yyparse(); }
void yyerror(const char *s){}

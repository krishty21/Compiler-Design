%{
#include <stdio.h>
#include <stdlib.h>
int yylex();
void yyerror(const char *s);
%}
%token NUM
%%
E: E'+'T { printf("%d\n",$1+$3); }
 | E'-'T { printf("%d\n",$1-$3); }
 | T
 ;
T: T'*'F { printf("%d\n",$1*$3); }
 | T'/'F { printf("%d\n",$1/$3); }
 | F
 ;
F: '('E')'
 | NUM
 ;
%%
int main(){ yyparse(); }
void yyerror(const char *s){}

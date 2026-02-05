%{
#include <stdio.h>
#include <stdlib.h>
int yylex();
void yyerror(char *s);
%}
%token ID
%%
input:
    input line
    | 
    ;

line:
    E '\n' { printf("Valid Expression\n"); }
    | error '\n' { yyerrok; }
    ;

E:
    E '+' T
    | T
    ;
T:
    T '*' F
    | F
    ;

F:
    '(' E ')'
    | ID
    ;

%%
void yyerror(char *s) {
    printf("Error: %s\n", s);
}
int main() {
    yyparse();
    return 0;
}

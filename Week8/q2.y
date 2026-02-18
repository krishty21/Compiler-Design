%{
#include <stdio.h>
#include <stdlib.h>
extern int pos;
int yylex();
void yyerror(char* s);
%}

%token LPAREN RPAREN
%%
S   : LPAREN S RPAREN S
    | S S
    | /* epsilon */
    ;
%%

int main() {
    printf("Enter Parentheses String: ");
    if (yyparse() == 0) printf("Balanced\n");
    return 0;
}
void yyerror(char* s) 
{
    printf("Error at position %d : %s \n", pos, s);
    exit(1);
}

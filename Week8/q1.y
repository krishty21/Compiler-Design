%{
#include <stdio.h>
int yylex();
void yyerror(char* s);
%}

%token NUM ID
%left '+'
%left '*'
%right '^'

%%
S   : E { printf("\n"); }
    ;

E   : E '+' T { printf("+"); }
    | T
    ;

T   : T '*' F { printf("*"); }
    | F
    ;

F   : P '^' F { printf("^"); }
    | P
    ;

P   : '(' E ')'
    | ID      { printf("id"); }
    | NUM     { printf("%d", $1); }
    ;
%%

int main() {
    printf("Enter Expression: ");
    yyparse();
    return 0;
}

void yyerror(char* s) { printf("Error: %s\n", s); }
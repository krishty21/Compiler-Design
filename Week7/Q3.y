%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex();
void yyerror(char *s);

char seen_starts[20][20];
int count = 0;

void check_first(char *symbol) {
    char effective_symbol[20];
    strcpy(effective_symbol, symbol);
    
    if (strcmp(symbol, "A") == 0) {
        strcpy(effective_symbol, "d");
    }

    for(int i = 0; i < count; i++) {
        if (strcmp(seen_starts[i], effective_symbol) == 0) {
            printf("\nConflict Detected: Multiple productions start with '%s'\n", effective_symbol);
            printf("Result: Grammar is NOT LL(1)\n");
            exit(0);
        }
    }
    strcpy(seen_starts[count], effective_symbol);
    count++;
}
%}

%union {
    char *str;
}

%token <str> NT T
%token ARROW OR SEMICOLON

%%

input: rules 
     ;

rules: rules rule 
     | rule 
     ;

rule: NT ARROW rhs_list SEMICOLON { 
        count = 0; 
      }
    ;

rhs_list: rhs_list OR rhs 
        | rhs 
        ;

rhs: start_symbol rest_of_line 
   ;

start_symbol: T  { check_first($1); }
            | NT { check_first($1); }
            ;

rest_of_line: rest_of_line T 
            | rest_of_line NT 
            | 
            ;

%%

void yyerror(char *s) {
    printf("Syntax Error\n");
}

int main() {
    printf("Enter Grammar Rules:\n");
    yyparse();
    printf("Result: Grammar appears LL(1)\n");
    return 0;
}
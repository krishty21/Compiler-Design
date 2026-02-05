%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    int yylex();
    void yyerror(char *s);

    struct Data {
        int type; // 0=int, 1=string
        int ival;
        char *sval;
    };
%}

%union {
    int ival;
    char *str;
    struct Data *dval;

%token <ival> NUMBER
%token <str> STRING
%type <dval> expr

%left '+'

%%

input: expr { 
        if ($1->type == 0) 
            printf("Result: %d\n", $1->ival);
        else 
            printf("Result: \"%s\"\n", $1->sval);
      }
      ;

expr: NUMBER { 
        $$ = malloc(sizeof(struct Data)); /* Allocate memory */
        $$->type = 0; 
        $$->ival = $1; 
      }
    | STRING { 
        $$ = malloc(sizeof(struct Data)); /* Allocate memory */
        $$->type = 1; 
        $$->sval = $1; 
      }
    | expr '+' expr {
        if ($1->type != $3->type) {
            printf("Invalid: Cannot add Number and String\n");
            exit(1);
        }
        
        $$ = malloc(sizeof(struct Data));
        $$->type = $1->type;
        
        if ($1->type == 0) {
            // Arithmetic Addition
            $$->ival = $1->ival + $3->ival;
        } else {
            // String Concatenation
            $$->sval = malloc(strlen($1->sval) + strlen($3->sval) + 1);
            strcpy($$->sval, $1->sval);
            strcat($$->sval, $3->sval);
        }
    }
    ;

%%

void yyerror(char *s) { printf("Syntax Error\n"); }
int main() { yyparse(); return 0; }
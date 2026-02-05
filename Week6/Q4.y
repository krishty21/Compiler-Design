%{
#include <stdio.h>
#include <stdlib.h>
int yylex();
void yyerror(char *);
%}

%union {
    float fval;
}

%token <fval> INT_NUM FLOAT_NUM
%token ID
%type <fval> E

/* Precedence Rules */
%left '+' '-'
%left '*' '/'

%%

input: E { printf("\nFinal Result: %.2f\n", $1); };

E: E '+' E { 
        printf("+ "); 
        $$ = $1 + $3; 
   }
 | E '-' E { 
        printf("- "); 
        $$ = $1 - $3; 
   }
 | E '*' E { 
        printf("* "); 
        $$ = $1 * $3; 
   }
 | E '/' E { 
        printf("/ "); 
        if($3 == 0) { yyerror("Divide by Zero"); exit(1); }
        $$ = $1 / $3; 
   }
 | '(' E ')' { $$ = $2; }
 | INT_NUM { 
        printf("%.0f ", $1); 
        $$ = $1; 
   }
 | FLOAT_NUM { 
        printf("%.2f ", $1); 
        $$ = $1; 
   }
 | ID {
        printf("id ");
        $$ = 0; /* Default value for ID */
   }
 ;

%%
void yyerror(char *s) { printf("Error: %s\n", s); }
int main() { 
    printf("Enter Expression (e.g. 3.5 * 2 + 5): "); 
    yyparse(); 
    return 0; 
}

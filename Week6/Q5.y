%{
#include <stdio.h>
#include <stdlib.h>
int yylex();
void yyerror(char *);
int skip_eval = 0; 
%}

%token NUM AND OR NOT BOOL
%left OR
%left AND
%right NOT

%%

start: expr { 
    if(!skip_eval) 
        printf("Result: %s\n", $1 ? "true" : "false"); 
};

expr: 
      /* SHORT CIRCUIT AND: If left is false, skip right */
      expr AND { 
          if($1 == 0) { 
              printf("Short-circuit: Skipping Right Operand of &&\n"); 
              skip_eval = 1; 
          } 
      } expr { 
          if(skip_eval) $$ = 0; /* Result is false regardless */
          else $$ = $1 && $4;
          skip_eval = 0; /* Reset flag */
      }
    | expr OR { 
          if($1 == 1) { 
              printf("Short-circuit: Skipping Right Operand of ||\n"); 
              skip_eval = 1; 
          } 
      } expr { 
          if(skip_eval) $$ = 1; /* Result is true regardless */
          else $$ = $1 || $4;
          skip_eval = 0; 
      }
      
    | '!' expr { $$ = !$2; }
    | '(' expr ')' { $$ = $2; }
    | BOOL { $$ = $1; }
    | NUM '/' NUM {
        if (skip_eval) {
            $$ = 0; 
        } else {
            if ($3 == 0) { 
                printf("Error: Division by zero!\n"); 
                exit(1); 
            }
            $$ = $1 / $3;
        }
    }
    | NUM { $$ = $1; }
    ;

%%
void yyerror(char *s) { printf("%s\n", s); }
int main() { 
    printf("Enter Boolean Expr (e.g. false && 1/0): "); 
    yyparse(); 
    return 0; 
}
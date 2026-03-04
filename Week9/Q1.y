%{
#include <stdio.h>
#include <stdlib.h>

extern int yylex();
void yyerror(const char *s);

/* Enable Yacc/Bison debugging to show stack contents at each step */
int yydebug = 1; 
%}

%union {
    int val;
}

%token <val> DIGIT
%type <val> S A B C M

%%

Start : S '\n' { exit(0); }
      ;

S : A { 
        printf("\nOutput final number: %d\n", $1); 
      }
  ;

A : B M C { 
        /* Synthesize final value from B and C */
        $$ = $1 * 100 + $3; 
        printf("-> Reduce A -> B M C (Synthesized A.val = %d)\n", $$); 
    }
  ;

B : DIGIT DIGIT { 
        /* Synthesize value for B */
        $$ = $1 * 10 + $2; 
        printf("-> Reduce B -> digit digit (Synthesized B.val = %d)\n", $$); 
    }
  ;

M : /* Marker non-terminal */ { 
        /* Pass inherited attribute: access B's value (symbol at position 0 relative to M) */
        $<val>$ = $<val>0; 
        printf("-> Reduce M -> epsilon (Inherited attribute from B = %d passed forward)\n", $<val>$); 
    }
  ;

C : DIGIT DIGIT { 
        /* Synthesize value for C */
        $$ = $1 * 10 + $2; 
        printf("-> Reduce C -> digit digit (Synthesized C.val = %d)\n", $$); 
    }
  ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    /* Set yydebug to 1 to print the stack contents at each shift/reduce step */
    yydebug = 1; 
    
    printf("Enter a 4-digit number (e.g., 1234):\n");
    yyparse();
    return 0;
}
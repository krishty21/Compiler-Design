%{
    #include <stdio.h>
    #include <string.h>
    #include <stdlib.h>

    void yyerror(const char* s);
    int yylex();

    int base = 1000;
%}

%union {
    int num;
    char idname[50];
}

%token <num> NUM
%token <idname> ID
%token LB RB PLUS

%type <num> E T

%%

S: ID LB E RB   {
                    int addr = base + ($3 * 4);
                    printf("\nArray: %s", $1);
                    printf("\nIndex value: %d", $3);
                    printf("\nEffective address: %d", addr);
                }
;

E: E PLUS T    {
                    $$ = $1 + $3;
                }
 | T            {
                    $$ = $1;
                }
;

T: NUM          {
                    $$ = $1;
                }
;

%%

void yyerror(const char* s)
{
    printf("Invalid input\n");
}

int main()
{
    printf("Enter input: ");
    yyparse();
    return 0;
}
%{
    #include <stdio.h>

    void yyerror(const char* s);
    int yylex();
%}

%union{
    int num;
}

%token <num> NUM
%token INT FLOAT ID LB RB

%type <num> T

%%

D: T ID LB NUM RB LB NUM RB {
                                int rows = $4;
                                int cols = $7;
                                int width = $1;
                                int total = rows * cols * width;

                                printf("Rows: %d", rows);
                                printf("Columns: %d", cols);
                                printf("Element size: %d", width);
                                printf("Total size: %d", total);
                            }
;

T: INT {
            $$ = 4;
        }
 | FLOAT {
            $$ = 8;
        }
;

%%

void yyerror(const char* s)
{
    printf("invalid\n");
}

int main()
{
    printf("Enter input: ");
    yyparse();
    return 0;
}
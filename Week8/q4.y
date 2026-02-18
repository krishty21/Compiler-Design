%{
    #include <stdio.h>

    void yyerror(const char* s);
    int yylex();

    int count = 0;
%}

%token ID COMMA LP RP

%%

F: ID LP A RP   { printf("\nNo. of arguments: %d", count); }
 ;

A: A COMMA ID   { count++; }
 | ID           { count = 1; }
 | /*epsilon*/  { count = 0; }
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
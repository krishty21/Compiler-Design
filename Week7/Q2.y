%{
    #include <stdio.h>

    void yyerror(const char* s);
    int yylex();
%}


%token ASSIGNMENT ID STAR

%%

S:  L ASSIGNMENT R {
                        printf("VALID EXPRESSION\n");
                    }
    
    ;

L: STAR R   {
            printf("Reduction: L -> *R\n");
            }
 | ID        {
            printf("Reduction: L -> ID\n");
            }
 ;

R: L        {
            printf("Reduction: R -> L\n");
            }
 ;

 %%

 void yyerror(const char *s)
 {
    printf("Invalid expression");
 }

 int main()
 {
    printf("Enter input: ");
    yyparse();
    return 0;
 }
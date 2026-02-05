%{
#include <stdio.h>
#include <stdlib.h>
int yylex();
void yyerror(const char *s);
%}

%token SELECT FROM WHERE ID NUMBER

%%

query : SELECT select_list FROM table where_clause ';' { printf("Valid SQL Query\n"); exit(0); }
      ;
select_list : column
            | select_list ',' column
            ;
column : ID
       ;

table : ID
      ;

where_clause : WHERE condition
             | 
             ;

condition : ID relop value
          ;

relop : '>'
      | '<'
      | '='
      ;

value : NUMBER
      | ID
      ;

%%

void yyerror(const char *s) {
    printf("Syntax Error in SQL Query\n");
    exit(1);
}
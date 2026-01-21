%{
#include <stdio.h>
int yylex();
void yyerror(const char *s);
%}
%token ID AND OR SHL SHR EQ NE
%left OR
%left AND
%left '|'
%left '^'
%left '&'
%left EQ NE
%left '<' '>'
%left SHL SHR
%left '+' '-'
%left '*' '/' '%'
%%
E: E'+'E | E'*'E | E SHL E | E AND E | E OR E | ID | '('E')';
%%
int main(){ yyparse(); }
void yyerror(const char *s){}

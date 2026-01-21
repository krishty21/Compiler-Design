%{
#include <stdio.h>
#include <math.h>

int yylex();
void yyerror(const char *s);

int fpos = 1;
%}

%token BIN DOT

%%
N: I DOT F { printf("%f\n", $1 + $3); }
 ;

I: I BIN { $$ = $1 * 2 + $2; }
 | BIN   { $$ = $1; }
 ;

F: BIN F { $$ = $1 * pow(2, -fpos++) + $2; }
 | BIN   { $$ = $1 * pow(2, -fpos++); }
 ;
%%

int main(){ yyparse(); }

void yyerror(const char *s){}

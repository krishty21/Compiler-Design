%{
#include "y.tab.h"
#include <stdlib.h>
#include <string.h>
%}

%%

"if"            { return IF; }
"else"          { return ELSE; }
"while"         { return WHILE; }

"{"             { return LBRACE; }
"}"             { return RBRACE; }
"("             { return LPAREN; }
")"             { return RPAREN; }

";"             { return SEMI; }
"="             { return ASSIGN; }

"+"             { return PLUS; }
"-"             { return MINUS; }
"*"             { return MUL; }
"/"             { return DIV; }

[0-9]+          {
                    yylval.num = atoi(yytext);
                    return NUM;
                }

[a-zA-Z][a-zA-Z0-9]*  {
                    yylval.id = strdup(yytext);
                    return ID;
                }

[ \t\n]         { }

.               { }

%%

int yywrap() { return 1; }

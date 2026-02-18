%{
    #include "y.tab.h"
    #include <string.h>
%}

%%

[a-zA-Z][a-zA-Z0-9]*   {
                          yylval.str = strdup(yytext);
                          return ID;
                       }

"="        { return ASSIGN; }
";"        { return SEMI; }
"{"        { return LBRACE; }
"}"        { return RBRACE; }

[ \t\n]    { }

.          { }

%%

int yywrap()
{
    return 1;
}

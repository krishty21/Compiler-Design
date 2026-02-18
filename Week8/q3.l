%{
    #include "y.tab.h"
    #include <stdlib.h>
    #include <string.h>
%}

%%

[0-9]+  {
    yylval.num = atoi(yytext);
    return NUM;
}

[a-zA-Z]+ {
    strcpy(yylval.idname, yytext);
    return ID;
}

"[" { return LB; }

"]" { return RB; }

"+" { return PLUS; }

[\t\n ] {}

.   {}

%%

int yywrap()
{
    return 1;
}
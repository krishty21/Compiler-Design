%{
    #include "y.tab.h"
%}

%%

[a-zA-Z]+ { return ID; }

"," {return COMMA; }

"(" {return LP; }

")" { return RP; }

[\n\t ] {}

. {}

%%

int yywrap()
{
    return 1;
}
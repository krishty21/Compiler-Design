%{
    #include "y.tab.h"
%}

%%

"i" {
    return ID;
}

"=" {
    return ASSIGNMENT;
}

"*" {
    return STAR;
}

[ \n\t] ;


%%

int yywrap()
{
    return 1;
}
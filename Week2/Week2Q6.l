%{
#include <stdio.h>
FILE *yyin;
%}

%%

"/*"([^*]|\*+[^*/])*\*+"/"   ;

.|\n                         { ECHO; }

%%

int main()
{
    yyin = fopen("input.c", "r");
    if (!yyin)
        return 1;
    yylex();
    fclose(yyin);
    return 0;
}

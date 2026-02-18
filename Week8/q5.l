%{
    #include "y.tab.h"
%}

%%

"int" { return INT; }
"float" { return FLOAT; }

[0-9]+  {
            yylval.num = atoi(yytext);
            return NUM;
        }

[a-zA-Z]+ { return ID; }

"[" { return LB; }
"]" { return RB; }

[\n\t ] {}

.   {}

%%

int yywrap()
{
    return 1;
}
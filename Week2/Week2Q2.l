%{
#include <stdio.h>
%}
WORD    [A-Za-z]+
%%
{WORD} {

    for (int i = yyleng - 1; i >= 0; i--) {
        putchar(yytext[i]);
    }
}
[ \t\n]+ {
    printf("%s", yytext);
}
. {

    putchar(yytext[0]);
}

<<EOF>> {

    printf("ZZ");
    return 0;
}
%%

int main(void)
{

    yylex();
    return 0;
}
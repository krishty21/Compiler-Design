%{
#include <stdio.h>
int count = 0;
%}
digit        [0-9]
nz_digit     [1-9]
leadingzero  0{digit}*
%%
{leadingzero} {
    printf("<ZERONUM>");
}
{nz_digit}{digit}* {
    if (yyleng >= 3) {
        printf("<LONGNUM>");
    } else {  /* yyleng is 1 or 2 here */
        printf("<SHORTNUM>");
    }
}
.|\n {
    printf("%s", yytext);
}
%%

int main(void)
{
    yylex();
    return 0;
}

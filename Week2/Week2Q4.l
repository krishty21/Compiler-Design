%{
#include <stdio.h>
int count_words(char *text);
int count_digits(char *text);
%}

%%
[^\n^\t]+   {
            printf("Words = %d\n", count_words(yytext));
            printf("Digits = %d\n", count_digits(yytext));
}
\n        ;
%%
int main()
{
    yylex();
    return 0;
}

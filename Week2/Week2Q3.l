/*3.Write a LEX program to recognize the following tokens over alphabet {0–9}:  2M
a) Strings that start with a 3 and end with a 7.
b) Strings containing at least two disjoint occurrences of “44”.
c) Strings where the total count of odd digits (1,3,5,7,9) is greater than the total count of even digits (0,2,4,6,8).
d) Strings representing decimal numbers that are divisible by 3.
e) Strings whose 5th symbol from the left is 9.
f) All three-digit numbers where the middle digit is the average of the first and last digit.
g) All five-digit numbers that form a strict palindrome.
*/

%{
#include <stdio.h>
#include <stdlib.h>

int evencount = 0;
int oddcount  = 0;
%}

DIGIT   [0-9]

fora    3{DIGIT}*7

forb    {DIGIT}*44{DIGIT}*44{DIGIT}*

forc    {DIGIT}

ford    {DIGIT}+
fore    {DIGIT}{DIGIT}{DIGIT}{DIGIT}9{DIGIT}*
forf    {DIGIT}{DIGIT}{DIGIT}
forg    {DIGIT}{DIGIT}{DIGIT}{DIGIT}{DIGIT}
%%
{fora} {
    printf("%s : starts with 3 and ends with 7\n", yytext);
}
{forb} {
    printf("%s : contains at least two disjoint occurrences of 44\n", yytext);
}

{fore} {
    printf("%s : 5th symbol from the left is 9\n", yytext);
}

{forf} {
    int a = yytext[0] - '0';
    int b = yytext[1] - '0';
    int c = yytext[2] - '0';

    if (2 * b == a + c)
        printf("%s : middle digit is average of first and last\n", yytext);
}

{forg} {
    if (yytext[0] == yytext[4] && yytext[1] == yytext[3])
        printf("%s : 5-digit strict palindrome\n", yytext);
}

{forc}+ {
    evencount = 0;
    oddcount  = 0;

    for (int i = 0; i < yyleng; i++) {
        int num = yytext[i] - '0';
        if (num % 2 == 0)
            evencount++;
        else
            oddcount++;
    }

    if (oddcount > evencount)
        printf("%s : odd digits are more than even digits\n", yytext);
}

{ford} {
    int n = atoi(yytext);
    if (n % 3 == 0)
        printf("%s : divisible by 3\n", yytext);
}

[ \t\n]+   ;  
.          ;  
%%
int main(void)
{
    yylex();
    return 0;
}

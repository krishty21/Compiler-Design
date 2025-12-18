/*Task-1
1.Design a LEX program whose token recognition rules change dynamically based on input
tokens already seen.
Constraints
 Before encountering keyword mode1, digits should be recognized as:
NUMBER → sequence of digits
 After encountering keyword mode1, digits should be recognized as:
BIN_NUMBER → sequence of only 0s and 1s
 After encountering keyword mode2, digits should be recognized as:
HEX_NUMBER → valid hexadecimal
 Switching modes multiple times is allowed. Invalid numbers must be reported with
mode-specific error messages.
Example Input
123
45
mode1
101
102
mode2
1AF
19G
mode1
110
Output
NUMBER → 123
NUMBER → 45
[Mode switched to Binary]
BIN_NUMBER → 101
ERROR → Invalid binary number: 102

[Mode switched to Hexadecimal]

HEX_NUMBER → 1AF
ERROR → Invalid hexadecimal number: 19G
[Mode switched to Binary]
BIN_NUMBER → 110*/
%{
#include <stdio.h>
#include <string.h>

int mode = 0;   /* 0 = Decimal, 1 = Binary, 2 = Hex */

void switch_mode(int m)
{
    if (m == 1)
        printf("[Mode switched to Binary]\n");
    else if (m == 2)
        printf("\n[Mode switched to Hexadecimal]\n\n");
}
%}

%%
"mode1" {
    mode = 1;
    switch_mode(1);
}

"mode2" {
    mode = 2;
    switch_mode(2);
}

[0-9A-Fa-f]+ {
    if (mode == 0) {
        if (strspn(yytext, "0123456789") == strlen(yytext))
            printf("NUMBER → %s\n", yytext);
        else
            printf("ERROR → Invalid decimal number: %s\n", yytext);
    }
    else if (mode == 1) {
        if (strspn(yytext, "01") == strlen(yytext))
            printf("BIN_NUMBER → %s\n", yytext);
        else
            printf("ERROR → Invalid binary number: %s\n", yytext);
    }
    else if (mode == 2) {
        if (strspn(yytext, "0123456789ABCDEFabcdef") == strlen(yytext))
            printf("HEX_NUMBER → %s\n", yytext);
        else
            printf("ERROR → Invalid hexadecimal number: %s\n", yytext);
    }
}

[ \t\n]+   ;

. {
    printf("ERROR → Invalid token: %s\n", yytext);
}
%%

int main()
{
    yylex();
    return 0;
}

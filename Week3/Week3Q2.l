/*Task-2
Implement a lexical analyzer using LEX for a language where indentation defines block
structure.
Requirements
1. Generate tokens:
2. INDENT, DEDENT, NEWLINE
3. Tabs and spaces must be handled correctly (tab = 4 spaces).
4. Incorrect indentation must generate lexical errors.
5. Nested indentation blocks must be tracked using a stack inside LEX.
6. Mixing tabs and spaces in the same block is illegal.
Output Example
IF
INDENT
STATEMENT
DEDENT*/
%{
#include <stdio.h>
#include <stdlib.h>

int indent = 0;
int start = 1;
%}

newline     \n
identifier  [a-zA-Z_][a-zA-Z0-9_]*
number      [0-9]+
tab         \t

%%
[ ]+\t|\t+[ ]+ {
    printf(" Mixing tabs and spaces\n");
}

{newline} {
    printf("NEWLINE\n");
    start = 1;
}

tab     {
    printf("TAB\n");
    start = 0;
}
[ ]+ {
    if (start) {
        int spaces = yyleng;

        if (spaces > indent) {
            printf("INDENT\n");
        } else if (spaces < indent) {
            printf("DEDENT\n");
        }

        if (spaces % 4 != 0) {
            printf("DEDENT Wrong indent\n");
        }

        indent = spaces;
        start = 0;
    }
}

{ \t}+ {
    if (start) {
        int spaces = yyleng * 4;

        if (spaces > indent) {
            printf("INDENT\n");
            start = 0;
        } else if (spaces < indent) {
            printf("DEDENT\n");
            start = 0;
        }

        indent = spaces;
        start = 0;
    }
}

{identifier} {
    printf("IDENTIFIER(%s)\n", yytext);
    start = 0;
}


{number} {
    printf("NUMBER(%s)\n", yytext);
    start = 0;
}

. {
    start = 0;
}
%%

int main() {
    yylex();
    return 0;
}

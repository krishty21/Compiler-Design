%{
#include <stdio.h>
#include <stdlib.h>

char stack[100];
int top = -1;

void push(char c) {
    stack[++top] = c;
}

char pop() {
    if (top == -1)
        return '\0';
    return stack[top--];
}

int match(char open, char close) {
    return (open == '(' && close == ')') ||
           (open == '{' && close == '}') ||
           (open == '[' && close == ']');
}
%}

bracket [\(\)\{\}\[\]]

%%

{bracket} {
    char c = yytext[0];

    if (c == '(' || c == '{' || c == '[') {
        push(c);
    }
    else {
        char open = pop();
        if (!match(open, c)) {
            printf("ERROR: Mismatched brackets\n");
        }
    }
}

.|\n   ;

%%

int main() {
    yylex();

    if (top != -1) {
        printf("ERROR: Missing closing bracket\n");
    }

    printf("SUCCESS: Brackets are balanced\n");
    return 0;
}

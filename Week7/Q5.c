#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define MAX 100

char stk[MAX][20];
int top = -1;
int line = 1;

void push(char *s) {
    top++;
    strcpy(stk[top], s);
}

void pop(int n) {
    top = top - n;
}
void check() {
    if(top >= 0) {
        if(strcmp(stk[top], "int") == 0 || strcmp(stk[top], "float") == 0) {
            strcpy(stk[top], "T");
            return;
        }
    }

    if(top >= 0) {
        if(strcmp(stk[top], "num") == 0) {
            strcpy(stk[top], "T");
            check(); 
            return;
        }
    }

    if(top >= 2) {
        if(strcmp(stk[top], ";") == 0 && strcmp(stk[top-1], "id") == 0 && strcmp(stk[top-2], "T") == 0) {
            pop(3);
            push("D");
            check(); return;
        }
    }

    if(top >= 2) {
        if((strcmp(stk[top], "T") == 0 || strcmp(stk[top], "E") == 0) && 
           strcmp(stk[top-1], "+") == 0 && 
           strcmp(stk[top-2], "E") == 0) {
            pop(3);
            push("E");
            check(); return;
        }
    }
    
    if(top >= 0 && strcmp(stk[top], "T") == 0) {
        if(top == 0 || strcmp(stk[top-1], "+") == 0 || strcmp(stk[top-1], "=") == 0 || strcmp(stk[top-1], "(") == 0 || strcmp(stk[top-1], ">") == 0) {
            strcpy(stk[top], "E");
            check(); return;
        }
    }

    if(top >= 3) {
        if(strcmp(stk[top], ";") == 0 && strcmp(stk[top-1], "E") == 0 && 
           strcmp(stk[top-2], "=") == 0 && strcmp(stk[top-3], "id") == 0) {
            pop(4);
            push("S");
            check(); return;
        }
    }

    if(top >= 8) {
        if(strcmp(stk[top], "}") == 0 && strcmp(stk[top-1], "S") == 0 && strcmp(stk[top-2], "{") == 0 &&
           strcmp(stk[top-3], ")") == 0 && strcmp(stk[top-4], "E") == 0 && 
           (strcmp(stk[top-5], ">") == 0 || strcmp(stk[top-5], "<") == 0 || strcmp(stk[top-5], "==") == 0) &&
           strcmp(stk[top-6], "E") == 0 && strcmp(stk[top-7], "(") == 0 && strcmp(stk[top-8], "if") == 0) {
               pop(9);
               push("S");
               check(); return;
           }
    }
    if(top >= 1) {
        if(strcmp(stk[top], "S") == 0 && strcmp(stk[top-1], "S") == 0) {
            pop(1);
            check(); return;
        }
    }

    if(top >= 1) {
        if(strcmp(stk[top], "D") == 0 && strcmp(stk[top-1], "D") == 0) {
            pop(1);
            check(); return;
        }
    }
}

int main() {
    printf("Enter code (end with $):\n");
    char token[20];
    char ch;
    int k = 0;
    while(1) {
        ch = getchar();
        if (ch == '$' || ch == EOF) break;
        if (isspace(ch)) {
            if (ch == '\n') line++;
            continue;
        }
        if (isdigit(ch)) {
            k = 0;
            token[k++] = ch;
            while(isdigit(ch = getchar())) {
                token[k++] = ch;
            }
            token[k] = '\0';
            ungetc(ch, stdin);
            push("num");
            check();
        }
        else if (isalpha(ch)) {
            k = 0;
            token[k++] = ch;
            while(isalnum(ch = getchar())) {
                token[k++] = ch;
            }
            token[k] = '\0';
            ungetc(ch, stdin);

            if(strcmp(token, "int")==0 || strcmp(token, "float")==0 || strcmp(token, "if")==0) {
                push(token);
            } else {
                push("id");
            }
            check();
        }
        else {
            token[0] = ch;
            token[1] = '\0';
            
            if(ch == '=') {
                char next = getchar();
                if(next == '=') {
                    strcpy(token, "==");
                } else {
                    ungetc(next, stdin);
                }
            }
            push(token);
            check();
        }
    }

    int valid = 0;
    if(top == 1 && strcmp(stk[0], "D") == 0 && strcmp(stk[1], "S") == 0) valid = 1;
    if(top == 0 && strcmp(stk[0], "D") == 0) valid = 1;
    if(top == 0 && strcmp(stk[0], "S") == 0) valid = 1;

    if(valid)
        printf("\nStatus: ACCEPT\n");
    else {
        printf("\nStatus: SYNTAX ERROR\n");
        printf("Error around Line %d\n", line);
    }
    return 0;
}
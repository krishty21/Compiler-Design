/*Problem Statement
Build a lexer that can rewind its own token stream.
Requirements
1. Special token:
2. @rollback N;
3. When encountered, lexer must:
o Undo last N tokens
o Re-emit them with updated line numbers
4. Rollback across multiple lines must work.
5. Rollback beyond start of file → error.

Example
int x;
int y;
@rollback 2;
Expected Behavior
 Removes tokens for int y;
 Reprocesses from previous state*/
%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAXTOK 1000
#define TOKLEN 50

char tokens[MAXTOK][TOKLEN];
int tok_count = 0;
int cur = 0;

void store(char *t) {
    strcpy(tokens[tok_count++], t);
}

void emit(char *t) {
    printf("TOKEN: %s\n", t);
}
%}

keyword   int
id        [a-zA-Z_][a-zA-Z0-9_]*
number    [0-9]+
rollback  "@rollback"[ ]+[0-9]+";"

%%

{rollback} {
    int n;
    sscanf(yytext, "@rollback %d;", &n);

    if (cur - n < 0) {
        printf("ERROR: Rollback beyond start of file\n");
        exit(1);
    }

    cur = cur - n;
    printf("ROLLBACK %d TOKENS\n", n);

    for (int i = cur; i < tok_count; i++) {
        emit(tokens[i]);
    }
}

{keyword} {
    store(yytext);
    emit(yytext);
    cur++;
}

{id} {
    store(yytext);
    emit(yytext);
    cur++;
}

{number} {
    store(yytext);
    emit(yytext);
    cur++;
}

";" {
    store(";");
    emit(";");
    cur++;
}

[ \t\n]+   ;
.          ;

%%

int main() {
    yylex();
    return 0;
}

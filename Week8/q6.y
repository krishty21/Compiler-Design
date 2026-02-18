%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char *s);
int yylex();

#define MAX_SCOPE 100
#define MAX_SYMBOLS 100

typedef struct {
    char name[50];
    int scope;
} Symbol;

Symbol table[MAX_SYMBOLS];
int symbolCount = 0;

int scopeStack[MAX_SCOPE];
int top = -1;
int currentScope = 0;

void enterScope() {
    currentScope++;
    scopeStack[++top] = currentScope;
}

void exitScope() {
    int scopeToRemove = scopeStack[top--];
    for(int i = symbolCount - 1; i >= 0; i--) {
        if(table[i].scope == scopeToRemove) {
            symbolCount--;
        }
    }
}

int lookup(char *name) {
    for(int i = symbolCount - 1; i >= 0; i--) {
        if(strcmp(table[i].name, name) == 0)
            return 1;
    }
    return 0;
}

void insert(char *name) {
    strcpy(table[symbolCount].name, name);
    table[symbolCount].scope = currentScope;
    symbolCount++;
}

%}

%union {
    char* str;
}

%token <str> ID
%token ASSIGN SEMI LBRACE RBRACE

%%

S : S Stmt
  | /* epsilon */
  ;

Stmt : ID ASSIGN ID SEMI
        {
            if(!lookup($1)) {
                insert($1);
                printf("Declared variable: %s (scope %d)\n", $1, currentScope);
            }
            if(!lookup($3)) {
                printf("Error: Undeclared variable %s\n", $3);
            }
        }
     | LBRACE
        {
            enterScope();
            printf("Entered new scope %d\n", currentScope);
        }
       S
       RBRACE
        {
            exitScope();
            printf("Exited scope\n");
        }
     ;

%%

void yyerror(const char *s)
{
    printf("Syntax Error\n");
}

int main()
{
    printf("Enter program:\n");
    enterScope();
    yyparse();
    return 0;
}

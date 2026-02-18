%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char *s);
int yylex();

typedef struct {
    char* id;
    int val;
} Var;

#define MAX_VARS 100
Var symtab[MAX_VARS];
int varCount = 0;

int lookup(char* id) {
    for(int i=0; i<varCount; i++) {
        if(strcmp(symtab[i].id,id)==0) return i;
    }
    return -1;
}

int getValue(char* id) {
    int idx = lookup(id);
    if(idx>=0) return symtab[idx].val;
    printf("Warning: Variable %s used before declaration. Defaulting to 0.\n", id);
    return 0;
}

void setValue(char* id, int val) {
    int idx = lookup(id);
    if(idx>=0) symtab[idx].val = val;
    else {
        symtab[varCount].id = strdup(id);
        symtab[varCount].val = val;
        varCount++;
    }
}
%}

%union {
    int num;
    char* id;
}

%token <num> NUM
%token <id> ID
%token IF ELSE WHILE
%token LBRACE RBRACE LPAREN RPAREN SEMI ASSIGN
%token PLUS MINUS MUL DIV

%type <num> expr

%%

program : stmt_list
        ;

stmt_list : stmt_list stmt
          | /* epsilon */
          ;

stmt : ID ASSIGN expr SEMI
        {
            setValue($1, $3);
            printf("%s = %d\n", $1, $3);
        }
     | IF LPAREN expr RPAREN stmt ELSE stmt
        {
            if($3) { /* execute first stmt */
                printf("Executing IF branch\n");
            } else {
                printf("Executing ELSE branch\n");
            }
        }
     | IF LPAREN expr RPAREN stmt
        {
            if($3) printf("Executing IF branch\n");
        }
     | WHILE LPAREN expr RPAREN stmt
        {
            printf("While loop with condition = %d (not looping for demo)\n", $3);
        }
     | block
        {}
     ;

block : LBRACE stmt_list RBRACE
        {}
     ;

expr : expr PLUS expr
        { $$ = $1 + $3; }
     | expr MINUS expr
        { $$ = $1 - $3; }
     | expr MUL expr
        { $$ = $1 * $3; }
     | expr DIV expr
        { $$ = $1 / $3; }
     | NUM
        { $$ = $1; }
     | ID
        { $$ = getValue($1); }
     | LPAREN expr RPAREN
        { $$ = $2; }
     ;

%%

void yyerror(const char *s)
{
    printf("Syntax Error: %s\n", s);
}

int main()
{
    printf("Enter mini-language code:\n");
    yyparse();
    return 0;
}

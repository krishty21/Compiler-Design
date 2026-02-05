%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex();
void yyerror(char *s);

struct Symbol {
    char name[20];
    int type;
} sym_table[100];

int count = 0;

void install(char *name, int type) {
    for(int i=0; i<count; i++) {
        if(strcmp(sym_table[i].name, name) == 0) {
            printf("Error: Variable %s already declared\n", name);
            exit(1);
        }
    }
    strcpy(sym_table[count].name, name);
    sym_table[count].type = type;
    count++;
}

int get_type(char *name) {
    for(int i=0; i<count; i++) {
        if(strcmp(sym_table[i].name, name) == 0)
            return sym_table[i].type;
    }
    return -1;
}

char* type_name(int type) {
    if(type == 1) return "int";
    if(type == 2) return "float";
    if(type == 3) return "char";
    return "unknown";
}
%}

%union {
    int ival;
    char *str;
}

/* Tokens */
%token <ival> INT_TYPE FLOAT_TYPE CHAR_TYPE
%token <str> ID
%type <ival> expr
%type <ival> type  

%left '+' '-'
%left '*' '/'

%%

program: 
    decl_list expr_list 
    ;

decl_list: 
    decl_list decl 
    | decl 
    ;

decl: 
    type ID ';' { install($2, $1); }
    ;

type: 
    INT_TYPE   { $$ = 1; }
    | FLOAT_TYPE { $$ = 2; }
    | CHAR_TYPE  { $$ = 3; }
    ;

expr_list:
    expr_list stmt
    | stmt
    ;

stmt: 
    expr ';' { printf("Type Check OK\n"); }
    ;

expr: 
    ID { 
        int t = get_type($1);
        if (t == -1) { 
            printf("Error: Variable %s not declared\n", $1); 
            exit(1); 
        }
        $$ = t; 
    }
    | expr '+' expr { 
        if ($1 != $3) {
            printf("Type Error: %s + %s not allowed\n", type_name($1), type_name($3));
            exit(1);
        }
        $$ = $1;
    }
    | expr '-' expr { 
        if ($1 != $3) {
            printf("Type Error: %s - %s not allowed\n", type_name($1), type_name($3));
            exit(1);
        }
        $$ = $1;
    }
    | expr '*' expr { 
        if ($1 != $3) {
            printf("Type Error: %s * %s not allowed\n", type_name($1), type_name($3));
            exit(1);
        }
        $$ = $1;
    }
    | expr '/' expr { 
        if ($1 != $3) {
            printf("Type Error: %s / %s not allowed\n", type_name($1), type_name($3));
            exit(1);
        }
        $$ = $1;
    }
    ;

%%

void yyerror(char *s) {
    printf("Syntax Error\n");
}

int main() {
    yyparse();
    return 0;
}
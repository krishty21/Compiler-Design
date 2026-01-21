/*
1. Design a LEX program where two identical tokens must appear exactly K
tokens apart.
Rules
 Value of K is set using:
 @distance K;
 If the same token appears:
o before K → ERROR (too close)
o after K → ERROR (too far)
 Only exact distance → VALID
Example
Input
@distance 3;
a b c a
x y x
Output
VALID a
ERROR x: distance mismatch
*/

%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

typedef struct {
    char name[50];
    int last_position;
} Symbol;

int K = 0;
int current_position = 0;
Symbol table[1000];
int table_size = 0;

int get_index(char *text) {
    for(int i = 0; i < table_size; i++) {
        if(strcmp(table[i].name, text) == 0) return i;
    }
    return -1;
}
%}

%option noyywrap

%%

@distance[ \t]+[0-9]+; {
    char *ptr = yytext;
    while (!isdigit(*ptr)) ptr++;
    K = atoi(ptr);
}

[a-zA-Z]+ {
    current_position++;
    int index = get_index(yytext);
    
    if(index == -1) {
        if (table_size < 1000) {
            strcpy(table[table_size].name, yytext);
            table[table_size].last_position = current_position;
            table_size++;
        }
    } else {
        int distance = current_position - table[index].last_position;
        
        if(distance < K) {
            printf("ERROR %s (too close)\n", yytext);
        } else if(distance > K) {
            printf("ERROR %s: (too far)\n", yytext);
        } else {
            printf("VALID %s\n", yytext);
        }
        table[index].last_position = current_position;
    }
}

[ \t\n] ;
. ; 

%%

int main() {
    yylex();
    return 0;
}

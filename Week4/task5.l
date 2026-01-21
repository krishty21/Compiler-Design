%{
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

int window_size = 0;
int current_count = 0;
%}

%%

@window[ \t]+[0-9]+; {
    char *ptr = yytext;
    while (!isdigit(*ptr)) ptr++;
    window_size = atoi(ptr);
    current_count = 0;
}

[a-zA-Z]+ {
    current_count++;
    if(current_count <= window_size) {
        printf("TOKEN %s\n", yytext);
    } else {
        printf("ERROR token outside window: %s\n", yytext);
    }
}

[ \t\n] ;
. ;

%%

int main() {
    yylex();
    return 0;
}
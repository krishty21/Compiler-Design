%{
#include <stdio.h>

int logical_line = 1;
int is_start = 1;
%}

%%

";;" {
    printf("\n");
    logical_line++;
    is_start = 1;
}

\n {
    printf(" ");
}

[ \t]+ {
    printf(" ");
}

. {
    if(is_start) {
        printf("LOGICAL LINE %d: ", logical_line);
        is_start = 0;
    }
    printf("%s", yytext);
}

%%

int main() {
    yylex();
    return 0;
}
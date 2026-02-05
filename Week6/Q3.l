%{
    #include "y.tab.h"
    #include <string.h>
    #include <stdlib.h>
%}

%%

[0-9]+      { 
              yylval.ival = atoi(yytext); 
              return NUMBER; 
            }

\"[^\"]*\"  { 
              /* Remove quotes */
              yytext[strlen(yytext)-1] = 0; 
              yylval.str = strdup(yytext+1); 
              return STRING; 
            }

[ \t\n]     ;
.           { return yytext[0]; }

%%

int yywrap() { return 1; }
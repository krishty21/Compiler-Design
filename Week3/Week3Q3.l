/*Task-3
Problem Statement
In this language, keywords are not reserved words.
Rules
1. A word is treated as a keyword only if it appears in a specific syntactic context.
2. Example:
3. begin x = 10; end → begin, end are keywords
4. int begin = 5; → begin is an identifier
5. Lexer must decide based only on previously seen tokens, not parsing.
6. Using a keyword as identifier in a keyword-only context should raise an error.

Constraints
 No YACC
 Decision must be made in LEX
 Must use look-back logic*/
%{
#include <stdio.h>
#include <string.h>

int last_was_begin_context = 0;
%}

ws      [ \t\n]+
id      [A-Za-z_][A-Za-z0-9_]*
num     [0-9]+

%%

"begin"     {
                if(last_was_begin_context==0)
                {
                    last_was_begin_context = 1;
                    printf("KEYWORD(begin)\n");
                }
                else
                {
                    printf("ID(begin)\n");
                }
            }

"end"       {
                if(last_was_begin_context==1)
                {
                    last_was_begin_context = 0;
                    printf("KEYWORD(end)\n");
                }
                else
                {
                    printf("ERROR: end without begin\n");
                }
            }

{ws}        ;

"="         { printf("ASSIGN\n"); }

";"         { printf("SEMI\n"); }

{num}       { printf("NUM(%s)\n", yytext); }

{id}        {
                if(last_was_begin_context==1 && 
                   (!strcmp(yytext,"begin") || !strcmp(yytext,"end")))
                {
                    printf("ERROR: keyword used as identifier\n");
                }
                else
                {
                    printf("ID(%s)\n", yytext);
                }
            }

.           { printf("SYM(%s)\n", yytext); }

%%

int main()
{
    yylex();
    return 0;
}

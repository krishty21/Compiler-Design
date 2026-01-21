/*2. A token is valid only if confirmed by the next line.
Rules
 A line containing declare X is valid only if next line contains use X
 If not, error must point to declaration line
Example
Input
declare a
use a
declare b
x = 10
Output

DECLARATION OK: a
ERROR at line 3: unused declaration b
Constraints
 Lexer must remember future requirements
 Forward dependency checking
*/

%{
    #include <stdio.h>
    #include <string.h>

    int pending_line_no;
    char pending_variable[50];
    char used_variable[50];
    int is_pending = 0;
%}

%%

^declare[ ][a-zA-Z]+ {
    if(is_pending)
    {
        printf("ERROR at line %d(unused declaration %s)", pending_line_no, pending_variable);
    }
    pending_line_no = yylineno;
    sscanf(yytext, "declare %s", pending_variable);
}

^use[ ][a-zA-Z]+ {
    sscanf(yytext, "use %s", used_variable);
    if(strcmp(pending_variable, used_variable) == 0)
    {
        is_pending = 0;
        printf("DECLARATION OK: %s\n", used_variable);
    }
    else
    {
        printf("ERROR at line %d: undeclared variable %s\n", yylineno, used_variable);
    }
}

%%

int main()
{
    yylex();
    return 0;
}
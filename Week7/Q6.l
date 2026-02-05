/*6. Write a LEX and YACC program to validate the syntax of a basic SQL SELECT
query with an optional WHERE clause.
The program should only check syntax, not semantics.
query : SELECT select_list FROM table where_clause &#39;;&#39;
;

select_list : column
| select_list &#39;,&#39; column
;

column : ID
;

table : ID
;

where_clause: WHERE condition
| /* empty 
;

condition : ID relop value

;

relop : &#39;&gt;&#39; | &#39;&lt;&#39; | &#39;=&#39;
;

value : NUMBER
| ID
;
Steps to perform task:
1.Write a LEX program to tokenize:
SQL keywords (SELECT, FROM, WHERE)
Identifiers
Numbers
Operators
2.Write a YACC program using the above grammar
3.Integrate LEX + YACC
4.Validate:
 Correct SQL query
 Incorrect SQL query
5.Display:
 &quot;Valid SQL Query&quot;
 &quot;Syntax Error in SQL Query&quot;
*/

%{
#include "y.tab.h"
%}
%%
"SELECT"    { return SELECT; }
"FROM"      { return FROM; }
"WHERE"     { return WHERE; }
","         { return ','; }
";"         { return ';'; }
">"         { return '>'; }
"<"         { return '<'; }
"="         { return '='; }
[0-9]+      { yylval = atoi(yytext); return NUMBER;}

[a-zA-Z][a-zA-Z0-9]*      { yylval = strdup(yytext); return ID;
    
}
[ \t\n]     {}
.           { return yytext[0]; }
%%
int yywrap() {
    return 1;
}  
int main() {
    return yyparse();
}
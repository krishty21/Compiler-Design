/*1. Multi-Digit Number Constructor Using Inherited Attributes (Bottom-Up)
Objective
Simulate bottom-up evaluation of inherited attributes.
Grammar
S → A
A → B C
B → digit digit
C → digit digit
Input Example
1 2 3 4
Program Requirements
 Modify grammar using marker non-terminal
 Implement stack-based shift-reduce simulation
 Pass inherited attributes correctly
 Show:
o Stack contents at each step
o Attribute values at each reduction
Output final number:
1234*/

%{
    #include "y.tab.h"
%}

%%
[0-9] { yyval = yytext[0] - '0';
        return DIGIT; }
[ \t\n] { }
.   { printf("Invalid character: %c\n", yytext[0]); }
%%

int yywrap() {
    return 1;
}
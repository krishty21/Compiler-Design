/*
3. Recognize identifiers only outside comments, but comments may appear inside
tokens.
Constraints
 Nested comments allowed
 Token reconstruction after comment removal
 Must preserve order
*/

%{
    #include <stdio.h>

    int comment_level = 0;
%}

%%

"/*" {
    comment_level++;
}

"*/" {
    if(comment_level > 0)
    {
        comment_level--;
    }
}

[a-zA-Z]+ {
    if(comment_level == 0)
    {
        for(int i = 0; i < yyleng; i++)
        {
            if(yytext[i] == '/' && yytext[i + 1] == '*')
            {
                comment_level++;
                i++;
            }
            else if(yytext[i] == '*' && yytext[i + 1] == '/')
            {
                if(comment_level > 0)
                {
                    comment_level--;
                }
                else
                {
                    printf("%c", yytext[i]);
                }
            }
            else
            {
                if(comment_level == 0)
                {
                    printf("%c", yytext[i]);
                }
            }
        }
    }
}

%%

int main()
{
    yylex();
    return 0;
}
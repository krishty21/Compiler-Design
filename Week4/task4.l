/*
4. Certain token pairs cannot coexist in the same file.
Rules
 Mutual exclusions defined as:
 @mutex a b;
 If both appear → error
Example
Input
@mutex read write;
read

write
Output
ERROR mutex violation: read &amp; write
*/

%{
    #include <stdio.h>
    #include <string.h>

    typedef struct{
        char word1[50];
        char word2[50];
        int locked;
    } mutex_pair;

    mutex_pair mutexes[100];
    char words_seen[100][50];
    int mutex_count = 0;
    int seen_count = 0;
%}

%%

@mutex[ ][a-zA-Z]+[ ][a-zA-Z]+ {
    sscanf(yytext, "@mutex %s %s", mutexes[mutex_count].word1, mutexes[mutex_count].word2);
    mutexes[mutex_count].locked = 1;
    mutex_count++;
}

[a-zA-Z]+ {
    for(int i = 0; i < mutex_count; i++) {
        if(strcmp(yytext, mutexes[i].word1) == 0) {
            for(int j = 0; j < seen_count; j++) {
                if(strcmp(words_seen[j], mutexes[i].word2) == 0) {
                     printf("ERROR mutex violation: %s & %s\n", yytext, words_seen[j]);
                     return 0;
                }
            }
        }
        if(strcmp(yytext, mutexes[i].word2) == 0) {
            for(int j = 0; j < seen_count; j++) {
                if(strcmp(words_seen[j], mutexes[i].word1) == 0) {
                     printf("ERROR mutex violation: %s & %s\n", words_seen[j], yytext);
                     return 0;
                }
            }
        }
    }

    int already_seen = 0;
    for(int k=0; k < seen_count; k++) {
        if(strcmp(words_seen[k], yytext) == 0) {
            already_seen = 1;
            break;
        }
    }
    
    if(!already_seen && seen_count < 100) {
        strcpy(words_seen[seen_count], yytext);
        seen_count++;
    }
}

%%

/* You need the global variable for counting seen words */
/* Add this to your %{ section if you haven't already: int seen_count = 0; */

int main() {
    yylex();
    return 0;
}


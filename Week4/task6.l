%{
#include <stdio.h>
#include <string.h>

typedef struct {
    char name[50];
    int in_degree;
    int out_degree;
} Node;

Node graph[100];
int node_count = 0;
char prev_token[50];
int first_in_sequence = 1;

int get_node_index(char *name) {
    for(int i = 0; i < node_count; i++) {
        if(strcmp(graph[i].name, name) == 0) return i;
    }
    strcpy(graph[node_count].name, name);
    graph[node_count].in_degree = 0;
    graph[node_count].out_degree = 0;
    return node_count++;
}
%}

%%

[a-zA-Z]+ {
    int curr = get_node_index(yytext);
    
    if(!first_in_sequence) {
        int prev = get_node_index(prev_token);
        graph[prev].out_degree++;
        graph[curr].in_degree++;
    }
    
    strcpy(prev_token, yytext);
    first_in_sequence = 0;
}

\n {
    first_in_sequence = 1;
}

[ \t] ;
. ;

%%

int main() {
    yylex();
    
    printf("Branching nodes: ");
    for(int i = 0; i < node_count; i++) {
        if(graph[i].out_degree >= 2) {
            printf("%s ", graph[i].name);
        }
    }
    printf("\n");

    printf("Roots: ");
    for(int i = 0; i < node_count; i++) {
        if(graph[i].in_degree == 0) {
            printf("%s ", graph[i].name);
        }
    }
    printf("\n");
    return 0;
}
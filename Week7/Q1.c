#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int stack[100];
int top = -1;

char input[100];
int pos = 0;

int get_col(char c) {
    if (c == 'i') return 0;
    if (c == '=') return 1;
    if (c == '*') return 2;
    if (c == '$') return 3;
    return -1;
}

int lhs[] = {0, 4, 4, 5, 5, 6};

int rhs_len[] = {0, 3, 1, 2, 1, 1};

int table[13][7] = {
    {  2,  0,  1,  0,  3, 4, 5 },
    {  2,  0,  1,  0,  0, 6, 0 },
    {  0, -4,  0, -4,  0, 0, 0 },
    {  0,  0,  0, 99,  0, 0, 0 },
    {  0,  7,  0, -5,  0, 0, 0 },
    {  0,  0,  0, -2,  0, 0, 0 },
    {  0, -3,  0, -3,  0, 0, 0 },
    {  9,  0,  8,  0,  0, 11, 10},
    {  9,  0,  8,  0,  0, 12, 0 },
    {  0,  0,  0, -4,  0, 0, 0 },
    {  0,  0,  0, -1,  0, 0, 0 },
    {  0,  0,  0, -5,  0, 0, 0 },
    {  0,  0,  0, -3,  0, 0, 0 }
};

void push(int val) {
    stack[++top] = val;
}

void pop(int n) {
    top -= n;
}

void print_stack() {
    printf("Stack: ");
    for (int i = 0; i <= top; i++) {
        printf("%d ", stack[i]);
    }
    printf("\tInput: %s\n", &input[pos]);
}

int main() {
    strcpy(input, "***i=**i$"); 
    
    printf("Grammar:\n");
    printf("1. S -> L = R\n2. S -> R\n3. L -> * L\n4. L -> id\n5. R -> L\n\n");
    
    push(0);
    print_stack();

    while (1) {
        int state = stack[top];
        char current_char = input[pos];
        int col = get_col(current_char);

        int action = table[state][col];

        if (action > 0 && action != 99) {
            printf("Action: Shift %d\n", action);
            push(action);
            
            if (current_char == 'i' || current_char == '*' || current_char == '=' || current_char == '$') {
                 pos++;
            }
        } 
        else if (action < 0) {
            int rule = -action;
            printf("Action: Reduce by Rule %d\n", rule);
            
            pop(rhs_len[rule]);
            
            int top_state = stack[top];
            int non_terminal_col = 0;
            
            if (lhs[rule] == 4) non_terminal_col = 4;
            if (lhs[rule] == 5) non_terminal_col = 5;
            if (lhs[rule] == 6) non_terminal_col = 6;
            
            int goto_state = table[top_state][non_terminal_col];
            push(goto_state);
        } 
        else if (action == 99) {
            printf("Action: ACCEPT\n");
            break;
        } 
        else {
            printf("Action: ERROR\n");
            break;
        }
        print_stack();
    }

    return 0;
}
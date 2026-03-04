#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

char stk[100][20];
int top = -1;

void reduce()
{
    if (top >= 0 && (strcmp(stk[top], "int") == 0 || strcmp(stk[top], "float") == 0))
    {
        strcpy(stk[top], "T");
        reduce();
    }
    else if (top >= 0 && (strcmp(stk[top], "id") == 0 || strcmp(stk[top], "num") == 0))
    {
        if (top > 0 && (strcmp(stk[top - 1], "int") == 0 || strcmp(stk[top - 1], "float") == 0))
            return;
        strcpy(stk[top], "T");
        reduce();
    }
    else if (top >= 0 && strcmp(stk[top], "T") == 0)
    {
        if (top >= 2 && strcmp(stk[top - 1], "+") == 0 && strcmp(stk[top - 2], "E") == 0)
        {
            top -= 2;
        }
        else
        {
            strcpy(stk[top], "E");
        }
        reduce();
    }
    else if (top >= 2 && strcmp(stk[top], ";") == 0 && strcmp(stk[top - 1], "id") == 0 && strcmp(stk[top - 2], "T") == 0)
    {
        top -= 2;
        strcpy(stk[top], "D");
        reduce();
    }
    else if (top >= 3 && strcmp(stk[top], ";") == 0 && strcmp(stk[top - 1], "E") == 0 && strcmp(stk[top - 2], "=") == 0 && strcmp(stk[top - 3], "id") == 0)
    {
        top -= 3;
        strcpy(stk[top], "S");
        reduce();
    }
    else if (top >= 0 && (strcmp(stk[top], ">") == 0 || strcmp(stk[top], "<") == 0 || strcmp(stk[top], "==") == 0))
    {
        strcpy(stk[top], "R");
        reduce();
    }
    else if (top >= 8 && strcmp(stk[top], "}") == 0 && strcmp(stk[top - 1], "S") == 0 && strcmp(stk[top - 2], "{") == 0 && strcmp(stk[top - 3], ")") == 0 && strcmp(stk[top - 4], "E") == 0 && strcmp(stk[top - 5], "R") == 0 && strcmp(stk[top - 6], "E") == 0 && strcmp(stk[top - 7], "(") == 0 && strcmp(stk[top - 8], "if") == 0)
    {
        top -= 8;
        strcpy(stk[top], "S");
        reduce();
    }
    else if (top >= 1)
    {
        if ((strcmp(stk[top], "D") == 0 && strcmp(stk[top - 1], "D") == 0) || (strcmp(stk[top], "S") == 0 && strcmp(stk[top - 1], "S") == 0))
        {
            top--;
            reduce();
        }
        else if (strcmp(stk[top], "S") == 0 && strcmp(stk[top - 1], "D") == 0)
        {
            top--;
            strcpy(stk[top], "P");
            reduce();
        }
    }
}

int main()
{
    char input[20];
    printf("Enter tokens with spaces (end with $):\n");
    while (scanf("%s", input) && strcmp(input, "$") != 0)
    {
        if (isdigit(input[0]))
            strcpy(stk[++top], "num");
        else if (strcmp(input, "int") == 0 || strcmp(input, "float") == 0 || strcmp(input, "if") == 0)
            strcpy(stk[++top], input);
        else if (isalpha(input[0]))
            strcpy(stk[++top], "id");
        else
            strcpy(stk[++top], input);
        reduce();
    }
    if (top == 0 && (strcmp(stk[0], "P") == 0 || strcmp(stk[0], "D") == 0 || strcmp(stk[0], "S") == 0))
        printf("\nStatus: ACCEPT\n");
    else
        printf("\nStatus: SYNTAX ERROR BRO\n");
    return 0;
}

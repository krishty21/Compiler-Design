/*Code in c to implement a DFA which recognizes a identifier in C*/
#include <stdio.h>
#include <ctype.h>

int main() {
    char s[100];
    printf("Enter the identifier: ");
    scanf("%s", s);

    if (isalpha(s[0]) || s[0] == '_') {
        for (int i = 1; s[i] != '\0'; i++) {
            if (!isalnum(s[i]) && s[i] != '_') {
                printf("Invalid identifier\n");
                return 0;
            }
        }
        printf("Valid identifier\n");
    } else {
        printf("Invalid identifier\n");
    }

    return 0;
}

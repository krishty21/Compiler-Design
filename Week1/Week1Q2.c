/*Implent a DFa to recognize strings with all valid binary numbers without leading zeros 
meaning 1(1+0)*    */
#include <stdio.h>
#include <ctype.h>
#include <string.h>

int main() {
    char s[100];
    scanf("%s", s);

    if (s[0] != '1') {
        printf("Invalid");
        return 0;
    }
    for (int i = 1; i < strlen(s); i++) {
        if (s[i] != '0' && s[i] != '1') {
            printf("Invalid");
            return 0;
        }
    }
    printf("Valid");
    return 0;
}


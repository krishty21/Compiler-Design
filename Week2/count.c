#include <string.h>
#include <ctype.h>
int count_words(char *text)
{
    int count = 0;
    char *token = strtok(text, " ");
    while (token != NULL)
    {
        count++;
        token = strtok(NULL, " ");
    }
    return count;
}
int count_digits(char *text)
{
    int i, count = 0;
    for (i = 0; text[i] != '\0'; i++)
    {
        if (isdigit(text[i]))
            count++;
    }
    return count;
}

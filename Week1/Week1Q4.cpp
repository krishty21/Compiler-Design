/*Implement a program to test Whether a string belongs to the language {a,b} Where no of lowercase letters where the string length is divisible by 3*/
#include <iostream>
#include <string>
using namespace std;

int main() {
    string s;
    cin >> s;
    for (int i = 0; i < s.size(); i++) {
        if (!(s[i] == 'a' || s[i] == 'b')) {
            printf("Invalid: Only 'a' or 'b' allowed\n");
            return 0;
        }
    }
    if (s.size() % 2 == 0) {
        printf("Valid string: Length is divisible by 3\n");
    } else {
        printf("Invalid string: Length is not divisible by 3\n");
    }
    return 0;
}

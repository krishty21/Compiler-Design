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
    if (s.size() % 3 == 0) {
        printf("Valid string: Length is divisible by 3\n");
    } else {
        printf("Invalid string: Length is not divisible by 3\n");
    }

    return 0;
}

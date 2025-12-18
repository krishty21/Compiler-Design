#include <iostream>
#include <string>
using namespace std;
bool language(const string& str) {
    int state = 0;
    for (char c : str) {
        if (state == 0) {                                     
            if (c == 'a') state = 1;
            else if (c != 'b') return false;
        } else if (state == 1) {
            if (c == 'b') state = 0;
            else return false;
        }
    }
    return state == 0;
}
int main() {
    string test_str = "ababb";
    cout << (language(test_str) ? "Accepted" : "Rejected") <<endl;
    return 0;
}

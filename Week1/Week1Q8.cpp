/*Implement a DFA for checking balanced numbers of 0's and 1;s in Cpp language must accept 0  or 1s */
//Alternative way to do this question si taking Counts for both 
#include <iostream>
using namespace std;
int main() {
    string s;
    cin >> s;
    int state = 0;
    for (char c : s) {
        if (c == '0') {
            state++;
        } else if (c == '1') {
            state--;
        } else {
            cout << "Invalid BOZO" << endl;
            return 0;
        }
    }
    if (state == 0) {
        cout << "Accepted" << endl;
    } else {
        cout << "Rejected" << endl;
    }
    return 0;
}

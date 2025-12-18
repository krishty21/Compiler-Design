/*Implement a DFA for valid octal number from 0 -7 
meaning reject any input which is greater than 7 
Reject alphabets*/;
    
#include <iostream>
using namespace std;

int main()
{
    cout << "Enter the string: ";
    string s;
    cin >> s;
    bool isValid = true;
    for (char c : s) {
        if (c < '0' || c > '7') {
            isValid = false;
            break;
        }
    }
    if (isValid)
        cout << "Valid octal number" << endl;
    else
        cout << "Invalid octal number" << endl;
    return 0;
}

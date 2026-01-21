/*1. Write a c/c++ program to implement 
(a) Recursive Descent Parsing with back tracking (Brute Force Method). 
S cAd 
A ab/ a
(b) Recursive Descent Parsing with back tracking (Brute Force Method).
S -> cAd 
A->a / ab  */
#include <iostream>
#include <string>

using namespace std;

int pos = 0;
string input;
bool S();
bool A();

// S -> cAd
bool S() {
    int startPos = pos;
    if (input[pos] == 'c') {
        pos++;
        if (A()) {
            if (input[pos] == 'd') {
                pos++;
                return true;
            }
        }
    }
    pos = startPos; // Backtrack if S fails
    return false;
}

bool A() {
    int startPos = pos;
    if (input[pos] == 'a') {
        pos++;
        if (input[pos] == 'b') {
            pos++;
            return true;
        }
    }
    pos = startPos; 
    if (input[pos] == 'a') {
        pos++;
        return true;
    }

    pos = startPos; 
    return false;
}
int main() {
    cout << "Enter input string: ";
    cin >> input;
    pos = 0;

    if (S() && pos == input.length()) {
        cout << "String accepted\n";
    } else {
        cout << "String rejected\n";
    }
    return 0;
}

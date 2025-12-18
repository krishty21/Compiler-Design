/*Implement a program to test Whether a string belongs to the language (a+b)*abb */
#include <iostream>
#include <string>
using namespace std;

int main() {
    string s;
    cin >> s;
    for(int i = 0; i <s.size(); i++)
    {
        if(!(s[i] == 'a' || s[i] == 'b'))
        {
            printf("Invalid only a or b");
            return 0;
        }
    }
    if (s[s.size()-3] == 'a' && s[s.size()-2] == 'b' && s[s.size()-1] == 'b')
        cout << "Valid";
    else
        cout << "Invalid";
    
    return 0;
}


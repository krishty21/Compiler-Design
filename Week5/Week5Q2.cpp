#include <iostream>
#include <cstring>
using namespace std;

string prod[10];
char firstSet[26], followSet[26];
string table[26][26];
char NT[10], T[10];
int n, ntc=0, tc=0;

bool isNT(char c){for(int i=0;i<ntc;i++) if(NT[i]==c) return true; return false;}
void addNT(char c){if(!isNT(c)) NT[ntc++]=c;}
bool isT(char c){for(int i=0;i<tc;i++) if(T[i]==c) return true; return false;}
void addT(char c){if(!isT(c) && c!='#') T[tc++]=c;}

void findFirst(){
    for(int i=0;i<n;i++){
        char A=prod[i][0];
        char B=prod[i][2];
        addNT(A);
        if(B>='a'&&B<='z'){
            addT(B);
            firstSet[A-'A']=B;
        }
    }
}

void findFollow(){
    followSet[prod[0][0]-'A']='$';
    for(int i=0;i<n;i++){
        char A=prod[i][0];
        for(int j=2;j<prod[i].length();j++){
            char B=prod[i][j];
            if(isNT(B)){
                if(j+1<prod[i].length() && prod[i][j+1]>='a' && prod[i][j+1]<='z')
                    followSet[B-'A']=prod[i][j+1];
                else
                    followSet[B-'A']=followSet[A-'A'];
            }
        }
    }
}

void buildTable(){
    for(int i=0;i<n;i++){
        char A=prod[i][0];
        char B=prod[i][2];
        int r=A-'A', c=0;
        if(B>='a'&&B<='z'){for(int k=0;k<tc;k++) if(T[k]==B) c=k;}
        else{for(int k=0;k<tc;k++) if(T[k]==followSet[r]) c=k;}
        table[r][c]=prod[i];
    }
}

int main(){
    cin>>n;
    for(int i=0;i<n;i++) cin>>prod[i];
    findFirst();
    findFollow();
    buildTable();
    for(int i=0;i<ntc;i++) cout<<"FIRST("<<NT[i]<<")={"<<firstSet[NT[i]-'A']<<"}
";
    for(int i=0;i<ntc;i++) cout<<"FOLLOW("<<NT[i]<<")={"<<followSet[NT[i]-'A']<<"}
";
    for(int i=0;i<ntc;i++){
        cout<<NT[i]<<" ";
        for(int j=0;j<tc;j++){
            if(table[NT[i]-'A'][j].empty()) cout<<"- ";
            else cout<<table[NT[i]-'A'][j]<<" ";
        }
        cout<<"
";
    }
}

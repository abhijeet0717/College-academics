#include <iostream>
#include <string>
using namespace std;

string addParityBit(string data){
    int count = 0 ;
    for (char bit : data){
        if (bit == '1'){
            count++;
        }
    }
    if (count % 2 == 0){
        data += '0';
    }else{
        data += '1';
    }
    return data;
}
string checkParity(string dataWithParity){
    int count = 0 ;
    for(char bit : dataWithParity){
        if(bit == '1'){
            count++;
        }
    }
    if (count % 2 == 0){
        return "No errors detected.";
    }else{
        return "Erros detected in transmission.";
    }
}

int main(){
    string data;
    cout << "enter the binary data :";
    cin >> data ;
    string dataWithParity = addParityBit(data);
    cout << "Data with parity bit :" ;
    cout << checkParity(dataWithParity) << endl;
    return 0;
}

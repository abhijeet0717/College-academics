//CRC

#include <bits/stdc++.h> 
using namespace std; 
string xor1(string a, string b) 
{ 
	string result = ""; 
	int n = b.length(); 
	for (int i = 1; i < n; i++) { 
		if (a[i] == b[i]) 
			result += "0"; 
		else
			result += "1"; 
	} 
	return result; 
} 
string mod2div(string dividend, string divisor) 
{ 
	int pick = divisor.length(); 
	string tmp = dividend.substr(0, pick); 
	int n = dividend.length(); 
	while (pick < n) { 
		if (tmp[0] == '1') 
			tmp = xor1(divisor, tmp) + dividend[pick]; 
		else
			tmp = xor1(string(pick, '0'), tmp) 
				+ dividend[pick]; 
		pick += 1; 
	} 
	if (tmp[0] == '1') 
		tmp = xor1(divisor, tmp); 
	else
		tmp = xor1(string(pick, '0'), tmp); 
	return tmp; 
} 
string encodeData(string data, string key) 
{ 
    if(data.size()<key.size()){
        cout<<"Error! data size less than key \n";
        return "";
    }
	int l_key = key.length(); 
	string appended_data 
		= (data + string(l_key - 1, '0')); 
	string remainder = mod2div(appended_data, key); 

	string codeword = data + remainder; 
	cout << "Remainder : " << remainder << "\n"; 
	cout << "Encoded Data (Data + Remainder) :" << codeword 
		<< "\n"; 
    return codeword;
} 
void receiver(string data, string key) 
{ 
	string currxor 
		= mod2div(data, key); 
	if (currxor.find('1') != string::npos) { 
		cout << "there is some error in data" << endl; 
	} 
	else { 
		cout << "correct message received" << endl; 
	} 
} 
int main() 
{ 
    cout<<"Enter the number in bits \n";   
	string data; 
    cin>>data;
	string key = "1101"; 
	cout << "Sender side..." << endl; 
	string encoded=encodeData(data, key); 
    if(encoded=="")
     return 0;
	cout << "\nReceiver side..." << endl; 
	receiver(encoded, key); 
	return 0; 
} 


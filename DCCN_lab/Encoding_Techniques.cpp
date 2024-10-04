//ENCODING TECHNIQUES //


#include <iostream>
#include <bitset>
#include <string>

using namespace std;

string manchesterEncoding(const string& data) {
    string encoded;
    for (char c : data) {
        bitset<8> bits(c);
        for (int i = 0; i < 8; ++i) {
            bool bit = bits[i];
            encoded += (bit ? "01" : "10");
        }
    }
    return encoded;
}

string differentialManchesterEncoding(const string& data) {
    bool last_level = false; 
    string encoded;
    
    for (char c : data) {
        bitset<8> bits(c);
        for (int i = 0; i < 8; ++i) {
            bool bit = bits[i];
            
            if (bit) {
                encoded += last_level ? "10" : "01";
                last_level = !last_level; 
            } else {
                encoded += last_level ? "01" : "10";
            }
        }
    }
    return encoded;
}

string bipolarAMIEncoding(const string& data) {
    string encoded;
    bool last_signal = false; // tracks the last signal level
    for (char c : data) {
        bitset<8> bits(c);
        for (int i = 0; i < 8; ++i) {
            bool bit = bits[i];
            if (bit) {
                // Alternate between + and - signals
                encoded += last_signal ? "-1" : "+1";
                last_signal = !last_signal;
            } else {
                // No change for 0s
                encoded += "0";
            }
        }
    }
    return encoded;
}

int main() {
    cout << "Enter the string to encode with Manchester Encoding: " << endl;
    string input;
    getline(cin, input);
    
    string output1 = manchesterEncoding(input);
    cout << "Manchester Encoding: " << output1 << endl;

    cout << "Enter the string to encode with Differential Manchester Encoding: " << endl;
    string data;
    getline(cin, data);
    
    string output2 = differentialManchesterEncoding(data);
    cout << "Differential Manchester Encoding of \"" << data << "\" is: " << output2 << endl;

    cout << "Enter the string to encode with Bipolar AMI Encoding: " << endl;
    string amiData;
    getline(cin, amiData);
    
    string output3 = bipolarAMIEncoding(amiData);
    cout << "Bipolar AMI Encoding of \"" << amiData << "\" is: " << output3 << endl;
    
    return 0;
}

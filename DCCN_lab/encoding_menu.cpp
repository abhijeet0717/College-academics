#include <iostream>
#include <vector>

using namespace std;

// Function for NRZ-L encoding
vector<int> nrzLEncode(const vector<int>& data) {
    vector<int> encoded;
    for (int bit : data) {
        encoded.push_back(bit == 1 ? 1 : -1);  // 1 -> +1, 0 -> -1
    }
    return encoded;
}

// Function for NRZI encoding
vector<int> nrziEncode(const vector<int>& data) {
    vector<int> encoded;
    int current_level = 1;  // Starting with high level (you can change to 0)
    for (int bit : data) {
        if (bit == 1) {
            current_level = (current_level == 1) ? -1 : 1;  // Toggle signal level
        }
        encoded.push_back(current_level);
    }
    return encoded;
}

// Function for AMI encoding
vector<int> amiEncode(const vector<int>& data) {
    vector<int> encoded;
    int last_pulse = -1;  // Last pulse starts as negative
    for (int bit : data) {
        if (bit == 0) {
            encoded.push_back(0);  // Binary 0 is 0 voltage
        } else {
            last_pulse = -last_pulse;  // Alternate between +1 and -1
            encoded.push_back(last_pulse);
        }
    }
    return encoded;
}

// Function for Pseudoternary encoding
vector<int> pseudoternaryEncode(const vector<int>& data) {
    vector<int> encoded;
    int last_pulse = -1;  // Last pulse starts as negative
    for (int bit : data) {
        if (bit == 1) {
            encoded.push_back(0);  // Binary 1 is 0 voltage
        } else {
            last_pulse = -last_pulse;  // Alternate between +1 and -1
            encoded.push_back(last_pulse);
        }
    }
    return encoded;
}

// Function to display the encoded signal
void displayEncodedSignal(const vector<int>& encoded) {
    for (int value : encoded) {
        cout << value << " ";
    }
    cout << endl;
}

int main() {
    // Binary data input
    vector<int> data;
    int n, choice, bit;

    cout << "Enter the number of bits in the binary data: ";
    cin >> n;

    cout << "Enter the binary data (0s and 1s):" << endl;
    for (int i = 0; i < n; i++) {
        cin >> bit;
        data.push_back(bit);
    }

    do {
        // Menu for encoding schemes
        cout << "\nChoose the encoding scheme:" << endl;
        cout << "1. NRZ-L Encoding" << endl;
        cout << "2. NRZI Encoding" << endl;
        cout << "3. AMI Encoding" << endl;
        cout << "4. Pseudoternary Encoding" << endl;
        cout << "5. Exit" << endl;
        cout << "Enter your choice: \n";
        cin >> choice;
        vector<int> encodedData;

        switch (choice) {
            case 1:
                encodedData = nrzLEncode(data);
                cout << "NRZ-L Encoded Signal: ";
                displayEncodedSignal(encodedData);
                break;
            case 2:
                encodedData = nrziEncode(data);
                cout << "NRZI Encoded Signal: ";
                displayEncodedSignal(encodedData);
                break;
            case 3:
                encodedData = amiEncode(data);
                cout << "AMI Encoded Signal: ";
                displayEncodedSignal(encodedData);
                break;
            case 4:
                encodedData = pseudoternaryEncode(data);
                cout << "Pseudoternary Encoded Signal: ";
                displayEncodedSignal(encodedData);
                break;
            case 5:
                cout << "Exiting..." << endl;
                return 0;
            default:
                cout << "Invalid choice! Please try again." << endl;
        }
    }while(choice!=5);

    return 0;
}

#include <iostream>
#include <vector>

using namespace std;

// Function to calculate row parity
vector<int> calculateRowParity(const vector<vector<int>>& data) {
    vector<int> rowParity(data.size(), 0);
    for (size_t i = 0; i < data.size(); ++i) {
        for (size_t j = 0; j < data[i].size(); ++j) {
            rowParity[i] ^= data[i][j];
        }
    }
    return rowParity;
}

// Function to calculate column parity
vector<int> calculateColumnParity(const vector<vector<int>>& data) {
    vector<int> colParity(data[0].size(), 0);
    for (size_t j = 0; j < data[0].size(); ++j) {
        for (size_t i = 0; i < data.size(); ++i) {
            colParity[j] ^= data[i][j];
        }
    }
    return colParity;
}

// Function to display the data with parity bits
void displayDataWithParity(const vector<vector<int>>& data, const vector<int>& rowParity, const vector<int>& colParity) {
    for (size_t i = 0; i < data.size(); ++i) {
        for (size_t j = 0; j < data[i].size(); ++j) {
            cout << data[i][j] << " ";
        }
        cout << "| " << rowParity[i] << endl;
    }
    for (size_t j = 0; j < colParity.size(); ++j) {
        cout << "--";
    }
    cout << endl;
    for (size_t j = 0; j < colParity.size(); ++j) {
        cout << colParity[j] << " ";
    }
    cout << endl;
}

int main() {
    // Example data
    vector<vector<int>> data = {
        {1, 0, 1, 1},
        {0, 1, 0, 0},
        {1, 1, 1, 0}
    };

    // Calculate row and column parity
    vector<int> rowParity = calculateRowParity(data);
    vector<int> colParity = calculateColumnParity(data);

    // Display data with parity bits
    displayDataWithParity(data, rowParity, colParity);

    return 0;
}

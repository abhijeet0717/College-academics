    #include<bits/stdc++.h>
    using namespace std;

    void nrz_l(string data)
    {
        int n=data.size();
        string graph[2];
        string gzero[2];
        string gone[2];
        gzero[0]="¯¯";
        gzero[1]="  ";
        gone[0]="  ";
        gone[1]="__";
        if(data[0]=='0'){
                graph[0]+=gzero[0];
                graph[1]+=gzero[1];
        }
        else{
                graph[0]+=gone[0];
                graph[1]+=gone[1];
                
        }
        for(int i=1;i<n;i++)
        {
            if(data[i]!=data[i-1])
            {
                graph[0]+='|';
                graph[1]+='|';
            }
            if(data[i]=='0')
            {
                graph[0]+=gzero[0];
                graph[1]+=gzero[1];
            }
            else
            {
                graph[0]+=gone[0];
                graph[1]+=gone[1];
            }
        }
        cout<<"graph:\n";
        cout<<graph[0]<<endl;
        cout<<graph[1]<<endl;

    }

    void nrz_i(string data)
    {
        int n=data.size();
        string graph[2];
        
        string g[2][2];
        g[0][0]="¯¯";
        g[0][1]="  ";
        g[1][0]="  ";
        g[1][1]="__";
        if(data[0]=='0'){
                graph[0]+=g[0][0];
                graph[1]+=g[0][1];
        }
        else{            
                graph[0]+=g[1][0];
                graph[1]+=g[1][1];
        }
        for(int i=1;i<n;i++)
        {
            int prev1=data[i-1]-'0';
            if(data[i]=='0')
            {
                int prev=data[i-1]-'0';
                data[i]=prev+'0';
                graph[0]+=g[prev][0];
                graph[1]+=g[prev][1];
            }
            else
            {
                graph[0]+='|';
                graph[1]+='|';
                int prev=data[i-1]-'0';
                graph[0]+=g[!prev][0];
                graph[1]+=g[!prev][1];
                data[i]=!prev+'0';
            }
        }
        cout<<"graph:\n";
        cout<<graph[0]<<endl;
        cout<<graph[1]<<endl;

    }
    void ami(string data)
    {
        int n=data.size();
        string graph[2];
        graph[0]="";
        graph[1]="";
        string g[3][2];
        g[2][0]="  ";//for zero as it is fixed
        g[2][1]="¯¯";
        g[1][0]="¯¯";//for + ive 1 voltage
        g[1][1]="  ";
        g[0][0]="  ";
        g[0][1]="__";//for -ive 1 voltage
        int prev=1;
        if(data[0]=='0'){
                graph[0]=g[2][0];
                graph[1]=g[2][1];
        }
        else{ 
                graph[0]=g[prev][0];
                graph[1]=g[prev][1];
                prev=!prev;
        }
        for(int i=1;i<n;i++){
            if(data[i]=='0'){
                if(data[i-1]=='1')
                {
                    if(prev)
                    {
                        graph[0]+=' ';
                        graph[1]+='|';
                    }
                    else
                    {
                        graph[0]+='|';
                        graph[1]+=' ';
                    }
                }
                graph[0]+=g[2][0];
                graph[1]+=g[2][1];
            }
            else{
                if(data[i-1]=='1')
                {
                    graph[0]+='|';
                    graph[1]+='|';
                    
                }
                else
                {
                    if(prev==1){
                    graph[0]+='|';
                    graph[1]+=' ';
                    }
                    else{
                    graph[0]+=' ';
                    graph[1]+='|';
                    }
                }
                
                graph[0]+=g[prev][0];
                graph[1]+=g[prev][1];
                prev=!prev;
            }
        }
        cout<<"graph:\n";
        cout<<graph[0]<<endl;
        cout<<graph[1]<<endl;
    }
    void psedoternary(string data)
    {
        int n=data.size();
        string graph[2];
        graph[0]="";
        graph[1]="";
        string g[3][2];
        g[2][0]="  ";//for 1 as it is fixed
        g[2][1]="¯¯";
        g[1][0]="¯¯";//for + ive 0 voltage
        g[1][1]="  ";
        g[0][0]="  ";
        g[0][1]="__";//for -ive 0 voltage
        int prev=1;
        if(data[0]=='1'){
                graph[0]=g[2][0];
                graph[1]=g[2][1];
        }
        else{ 
                graph[0]=g[prev][0];
                graph[1]=g[prev][1];
                prev=!prev;
        }
        for(int i=1;i<n;i++){
            if(data[i]=='1'){
                if(data[i-1]=='0')
                {
                    if(prev)
                    {
                        graph[0]+=' ';
                        graph[1]+='|';
                    }
                    else
                    {
                        graph[0]+='|';
                        graph[1]+=' ';
                    }
                }
                graph[0]+=g[2][0];
                graph[1]+=g[2][1];
            }
            else{
                if(data[i-1]=='0')
                {
                    graph[0]+='|';
                    graph[1]+='|';
                    
                }
                else
                {
                    if(prev==1){
                    graph[0]+='|';
                    graph[1]+=' ';
                    }
                    else{
                    graph[0]+=' ';
                    graph[1]+='|';
                    }
                }
                
                graph[0]+=g[prev][0];
                graph[1]+=g[prev][1];
                prev=!prev;
            }
        }
        cout<<"graph:\n";
        cout<<graph[0]<<endl;
        cout<<graph[1]<<endl;
    }    

int main()
{
    string inputsignal;
    cout << "Input Signal: ";
    cin >> inputsignal;

    while (true) {
        cout << "\nMenu:\n";
        cout << "1. Non-return-to-zero Level (NRZ-L)\n";
        cout << "2. Non-return-to-zero Inverted (NRZ-I)\n";
        cout << "3. Alternate Mark Inversion (AMI)\n";
        cout << "4. Pseudoternary Encoding\n";
        cout << "5. Exit\n";
        cout << "Choose an option (1-5): ";

        int choice;
        cin >> choice;

        switch (choice) {
            case 1:
                nrz_l(inputsignal);
                break;
            case 2:
                nrz_i(inputsignal);
                break;
            case 3:
                ami(inputsignal);
                break;
            case 4:
                psedoternary(inputsignal);
                break;
            case 5:
                cout << "Exiting the program.\n";
                return 0;
            default:
                cout << "Invalid choice! Please choose again.\n";
        }
    }
}
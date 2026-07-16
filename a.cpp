#include<iostream>
using namespace std;

int main(){
    int n,m;

    cout<<"Enter number of processes: ";
    cin>>n;

    cout<<"Enter number of resource types: ";
    cin>>m;

    int alloc[n][m],maxm[n][m],need[n][m];
    int avail[m];

    cout<<"\nEnter Allocation Matrix:\n";
    for(int i=0;i<n;i++)
        for(int j=0;j<m;j++)
            cin>>alloc[i][j];

    cout<<"\nEnter Maximum Matrix:\n";
    for(int i=0;i<n;i++)
        for(int j=0;j<m;j++)
            cin>>maxm[i][j];

    cout<<"\nEnter Available Resources:\n";
    for(int i=0;i<m;i++)
        cin>>avail[i];

    for(int i=0;i<n;i++)
        for(int j=0;j<m;j++)
            need[i][j]=maxm[i][j]-alloc[i][j];

    bool finish[n]={false};
    int safeSeq[n];
    int count=0;

    while(count<n){
        bool found=false;

        for(int i=0;i<n;i++){
            if(!finish[i]){
                bool possible=true;

                for(int j=0;j<m;j++){
                    if(need[i][j]>avail[j]){
                        possible=false;
                        break;
                    }
                }

                if(possible){
                    for(int j=0;j<m;j++)
                        avail[j]+=alloc[i][j];

                    safeSeq[count++]=i;
                    finish[i]=true;
                    found=true;
                }
            }
        }

        if(!found){
            cout<<"\nSystem is NOT in a safe state.\n";
            return 0;
        }
    }

    cout<<"\nSystem is in a SAFE state.\n";
    cout<<"Safe Sequence: ";

    for(int i=0;i<n;i++){
        cout<<"P"<<safeSeq[i];
        if(i!=n-1)
            cout<<" -> ";
    }

    cout<<endl;
    return 0;
}

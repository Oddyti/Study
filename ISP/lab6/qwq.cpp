#include <bits/stdc++.h>
using namespace std;
int main()
{

    freopen("qwq.txt", "w", stdout);

    for (int j = 0; j < 256; j++)
    {
        int i = j * 5000 / 256;
        cout << "if (in == 9'd" << j << ") begin" << endl;

        cout << "\tout1 = 4'd";
        cout << i % 10 << ";" << endl;
        i /= 10;

        cout << "\tout2 = 4'd";
        cout << i % 10 << ";" << endl;
        i /= 10;

        cout << "\tout3 = 4'd";
        cout << i % 10 << ";" << endl;
        i /= 10;

        cout << "\tout4 = 4'd";
        cout << i % 10 << ";" << endl;
        i /= 10;

        cout << "end" << endl;
    }
}
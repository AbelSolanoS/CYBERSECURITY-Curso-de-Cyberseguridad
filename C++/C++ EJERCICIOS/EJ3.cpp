#include <iostream>
using namespace std;

int main() {
    float celsius;
    cout << "Ingrese grados Celsius: ";
    cin >> celsius;
    float fahrenheit = (celsius * 9/5) + 32;
    cout << celsius << "°C = " << fahrenheit << "°F" << endl;
    return 0;
}
#include <iostream>
using namespace std;

int main() {
    float base, altura;
    cout << "Base del rectangulo: ";
    cin >> base;
    cout << "Altura del rectangulo: ";
    cin >> altura;
    float area = base * altura;
    cout << "Area: " << area << endl;
    return 0;
}
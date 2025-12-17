#include <iostream>
using namespace std;

int main() {
    int a, b;
    cout << "Ingrese dos numeros enteros: ";
    cin >> a >> b;
    cout << "Suma: " << a + b << endl;
    cout << "Resta: " << a - b << endl;
    cout << "Multiplicacion: " << a * b << endl;
    if (b != 0) {
        cout << "Division: " << (float)a / b << endl;
    } else {
        cout << "No se puede dividir por cero" << endl;
    }
    return 0;
}
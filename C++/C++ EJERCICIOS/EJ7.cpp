#include <iostream>
using namespace std;

int main() {
    int numero;
    cout << "Ingrese un numero para ver su tabla: ";
    cin >> numero;
    
    cout << "Tabla del " << numero << ":" << endl;
    for (int i = 1; i <= 12; i++) {
        cout << numero << " x " << i << " = " << numero * i << endl;
    }
    
    return 0;
}
#include <iostream>
using namespace std;

int main() {
    int opcion;
    float a, b;
    
    do {
        cout << "\n=== MENU ===" << endl;
        cout << "1. Sumar" << endl;
        cout << "2. Restar" << endl;
        cout << "3. Multiplicar" << endl;
        cout << "4. Salir" << endl;
        cout << "Opcion: ";
        cin >> opcion;
        
        if (opcion >= 1 && opcion <= 3) {
            cout << "Ingrese dos numeros: ";
            cin >> a >> b;
        }
        
        switch (opcion) {
            case 1:
                cout << "Resultado: " << a + b << endl;
                break;
            case 2:
                cout << "Resultado: " << a - b << endl;
                break;
            case 3:
                cout << "Resultado: " << a * b << endl;
                break;
            case 4:
                cout << "Saliendo..." << endl;
                break;
            default:
                cout << "Opcion invalida" << endl;
        }
    } while (opcion != 4);
    
    return 0;
}
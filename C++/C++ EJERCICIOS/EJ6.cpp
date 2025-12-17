#include <iostream>
#include <string>
using namespace std;

struct Producto {
    string nombre;
    float precio;
    int cantidad;
};

int main() {
    Producto productos[5];
    float total = 0;
    
    for (int i = 0; i < 5; i++) {
        cout << "Producto " << i + 1 << ":" << endl;
        cout << "Nombre: ";
        cin.ignore();
        getline(cin, productos[i].nombre);
        cout << "Precio: ";
        cin >> productos[i].precio;
        cout << "Cantidad: ";
        cin >> productos[i].cantidad;
        
        total += productos[i].precio * productos[i].cantidad;
    }
    
    cout << "\nValor total del inventario: $" << total << endl;
    return 0;
}
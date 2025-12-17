#include <iostream>
#include <string>
using namespace std;

struct Estudiante {
    string nombre;
    int edad;
    float promedio;
};

int main() {
    Estudiante estudiantes[3];
    
    for (int i = 0; i < 3; i++) {
        cout << "Estudiante " << i + 1 << ":" << endl;
        cout << "Nombre: ";
        cin.ignore();
        getline(cin, estudiantes[i].nombre);
        cout << "Edad: ";
        cin >> estudiantes[i].edad;
        cout << "Promedio: ";
        cin >> estudiantes[i].promedio;
    }
    
    int mejor = 0;
    for (int i = 1; i < 3; i++) {
        if (estudiantes[i].promedio > estudiantes[mejor].promedio) {
            mejor = i;
        }
    }
    
    cout << "\nMejor promedio:" << endl;
    cout << "Nombre: " << estudiantes[mejor].nombre << endl;
    cout << "Promedio: " << estudiantes[mejor].promedio << endl;
    
    return 0;
}
#include <iostream>
#include <mysql/mysql.h>
#include <vector>
#include <string>
#include <iomanip>
#include <ctime>
#include <regex>
#include <limits>

using namespace std;

class ControlAccesoWifi {
private:
    MYSQL* conexion;
    MYSQL_RES* resultado;
    MYSQL_ROW fila;
    
    struct Dispositivo {
        string mac;
        string ip;
        string nombre;
        string usuario;
        string estado;
    };
    
    struct Conexion {
        string mac;
        string ip;
        string fecha;
    };
    
    struct Alerta {
        string tipo;
        string descripcion;
        string mac;
        string ip;
        string fecha;
    };
    
public:
    ControlAccesoWifi() {
        conexion = mysql_init(NULL);
        if (!mysql_real_connect(conexion, "localhost", "root", "", "prproyecto", 3306, NULL, 0)) {
            cout << "Error al conectar a la base de datos: " << mysql_error(conexion) << endl;
            exit(1);
        }
        cout << "Conexión exitosa a la base de datos" << endl;
    }
    
    ~ControlAccesoWifi() {
        mysql_close(conexion);
    }
    
    bool validarFormatoMAC(const string& mac) {
        regex patron_mac("^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$");
        return regex_match(mac, patron_mac);
    }
    
    bool validarFormatoIP(const string& ip) {
        regex patron_ip("^(\\d{1,3}\\.){3}\\d{1,3}$");
        if (!regex_match(ip, patron_ip)) return false;
        
        int parte1, parte2, parte3, parte4;
        sscanf(ip.c_str(), "%d.%d.%d.%d", &parte1, &parte2, &parte3, &parte4);
        return (parte1 >= 0 && parte1 <= 255 &&
                parte2 >= 0 && parte2 <= 255 &&
                parte3 >= 0 && parte3 <= 255 &&
                parte4 >= 0 && parte4 <= 255);
    }
    
    void registrarDispositivo() {
        Dispositivo d;
        
        cout << "\n=== REGISTRAR DISPOSITIVO ===" << endl;
        cout << "MAC Address: ";
        getline(cin, d.mac);
        cout << "IP Address: ";
        getline(cin, d.ip);
        cout << "Nombre: ";
        getline(cin, d.nombre);
        cout << "Usuario: ";
        getline(cin, d.usuario);
        
        if (d.mac.empty() || d.ip.empty() || d.nombre.empty() || d.usuario.empty()) {
            cout << "Error: Todos los campos son obligatorios" << endl;
            return;
        }
        
        if (!validarFormatoMAC(d.mac)) {
            cout << "Error: Formato de MAC address inválido" << endl;
            return;
        }
        
        if (!validarFormatoIP(d.ip)) {
            cout << "Error: Formato de IP address inválido" << endl;
            return;
        }
        
        string query = "SELECT id FROM dispositivos WHERE mac_address = '" + d.mac + "'";
        if (mysql_query(conexion, query.c_str())) {
            cout << "Error en consulta: " << mysql_error(conexion) << endl;
            return;
        }
        
        resultado = mysql_store_result(conexion);
        if (mysql_num_rows(resultado) > 0) {
            cout << "Error: El dispositivo ya está registrado" << endl;
            mysql_free_result(resultado);
            return;
        }
        mysql_free_result(resultado);
        
        query = "INSERT INTO dispositivos (mac_address, ip_address, nombre_dispositivo, usuario, estado) VALUES ('" +
                d.mac + "', '" + d.ip + "', '" + d.nombre + "', '" + d.usuario + "', 'activo')";
        
        if (mysql_query(conexion, query.c_str())) {
            cout << "Error al registrar dispositivo: " << mysql_error(conexion) << endl;
        } else {
            cout << "Dispositivo registrado correctamente" << endl;
        }
    }
    
    void mostrarDispositivos() {
        cout << "\n=== DISPOSITIVOS REGISTRADOS ===" << endl;
        cout << left << setw(20) << "MAC" << setw(16) << "IP" 
             << setw(20) << "Nombre" << setw(15) << "Usuario" << "Estado" << endl;
        cout << string(85, '-') << endl;
        
        string query = "SELECT mac_address, ip_address, nombre_dispositivo, usuario, estado FROM dispositivos";
        if (mysql_query(conexion, query.c_str())) {
            cout << "Error: " << mysql_error(conexion) << endl;
            return;
        }
        
        resultado = mysql_store_result(conexion);
        while ((fila = mysql_fetch_row(resultado))) {
            cout << left << setw(20) << (fila[0] ? fila[0] : "") 
                 << setw(16) << (fila[1] ? fila[1] : "")
                 << setw(20) << (fila[2] ? fila[2] : "")
                 << setw(15) << (fila[3] ? fila[3] : "")
                 << (fila[4] ? fila[4] : "") << endl;
        }
        mysql_free_result(resultado);
    }
    
    void mostrarConexionesActivas() {
        cout << "\n=== CONEXIONES ACTIVAS ===" << endl;
        cout << left << setw(20) << "MAC" << setw(16) << "IP" << "Fecha Conexión" << endl;
        cout << string(55, '-') << endl;
        
        string query = "SELECT mac_address, ip_address, fecha_conexion FROM conexiones_activas WHERE estado = 'conectado' ORDER BY fecha_conexion DESC";
        if (mysql_query(conexion, query.c_str())) {
            cout << "Error: " << mysql_error(conexion) << endl;
            return;
        }
        
        resultado = mysql_store_result(conexion);
        while ((fila = mysql_fetch_row(resultado))) {
            cout << left << setw(20) << (fila[0] ? fila[0] : "") 
                 << setw(16) << (fila[1] ? fila[1] : "")
                 << (fila[2] ? fila[2] : "") << endl;
        }
        mysql_free_result(resultado);
    }
    
    void mostrarAlertas() {
        cout << "\n=== ALERTAS ===" << endl;
        cout << left << setw(20) << "Tipo" << setw(30) << "Descripción" 
             << setw(20) << "MAC" << setw(16) << "IP" << "Fecha" << endl;
        cout << string(105, '-') << endl;
        
        string query = "SELECT tipo_alerta, descripcion, mac_address, ip_address, fecha_alerta FROM alertas ORDER BY fecha_alerta DESC";
        if (mysql_query(conexion, query.c_str())) {
            cout << "Error: " << mysql_error(conexion) << endl;
            return;
        }
        
        resultado = mysql_store_result(conexion);
        while ((fila = mysql_fetch_row(resultado))) {
            cout << left << setw(20) << (fila[0] ? fila[0] : "") 
                 << setw(30) << (fila[1] ? fila[1] : "")
                 << setw(20) << (fila[2] ? fila[2] : "")
                 << setw(16) << (fila[3] ? fila[3] : "")
                 << (fila[4] ? fila[4] : "") << endl;
        }
        mysql_free_result(resultado);
    }
    
    void eliminarDispositivo() {
        string mac;
        cout << "\nMAC Address del dispositivo a eliminar: ";
        getline(cin, mac);
        
        string query = "DELETE FROM dispositivos WHERE mac_address = '" + mac + "'";
        if (mysql_query(conexion, query.c_str())) {
            cout << "Error: " << mysql_error(conexion) << endl;
        } else {
            if (mysql_affected_rows(conexion) > 0) {
                cout << "Dispositivo eliminado correctamente" << endl;
            } else {
                cout << "No se encontró el dispositivo" << endl;
            }
        }
    }
    
    void simularConexion() {
        string query = "SELECT mac_address, ip_address FROM dispositivos WHERE estado = 'activo' LIMIT 1";
        if (mysql_query(conexion, query.c_str())) {
            cout << "Error: " << mysql_error(conexion) << endl;
            return;
        }
        
        resultado = mysql_store_result(conexion);
        if (mysql_num_rows(resultado) == 0) {
            cout << "No hay dispositivos registrados para simular" << endl;
            mysql_free_result(resultado);
            return;
        }
        
        fila = mysql_fetch_row(resultado);
        string mac = fila[0] ? fila[0] : "";
        string ip = fila[1] ? fila[1] : "";
        mysql_free_result(resultado);
        
        if (validarAcceso(mac, ip)) {
            cout << "Conexión autorizada para " << mac << endl;
        } else {
            cout << "Conexión denegada para " << mac << endl;
        }
    }
    
    bool validarAcceso(const string& mac, const string& ip) {
        string query = "SELECT id, usuario FROM dispositivos WHERE mac_address = '" + mac + "' AND estado = 'activo'";
        if (mysql_query(conexion, query.c_str())) {
            cout << "Error: " << mysql_error(conexion) << endl;
            return false;
        }
        
        resultado = mysql_store_result(conexion);
        if (mysql_num_rows(resultado) == 0) {
            mysql_free_result(resultado);
            generarAlerta("Acceso no autorizado", 
                         "Intento de conexión desde dispositivo no registrado. MAC: " + mac + ", IP: " + ip,
                         mac, ip);
            return false;
        }
        
        fila = mysql_fetch_row(resultado);
        string usuario = fila[1] ? fila[1] : "";
        mysql_free_result(resultado);
        
        query = "SELECT COUNT(*) FROM conexiones_activas ca "
                "JOIN dispositivos d ON ca.mac_address = d.mac_address "
                "WHERE d.usuario = '" + usuario + "' AND ca.estado = 'conectado'";
        
        if (mysql_query(conexion, query.c_str())) {
            cout << "Error: " << mysql_error(conexion) << endl;
            return false;
        }
        
        resultado = mysql_store_result(conexion);
        fila = mysql_fetch_row(resultado);
        int conexionesActivas = atoi(fila[0]);
        mysql_free_result(resultado);
        
        int limite = 3; // Límite por defecto
        
        if (conexionesActivas >= limite) {
            generarAlerta("Límite de conexiones excedido",
                         "El usuario " + usuario + " ha excedido el límite de " + to_string(limite) + " conexiones simultáneas",
                         mac, ip);
            return false;
        }
        
        time_t ahora = time(NULL);
        char buffer[80];
        strftime(buffer, sizeof(buffer), "%Y-%m-%d %H:%M:%S", localtime(&ahora));
        
        query = "INSERT INTO conexiones_activas (mac_address, ip_address, fecha_conexion, estado) VALUES ('" +
                mac + "', '" + ip + "', '" + buffer + "', 'conectado')";
        
        if (mysql_query(conexion, query.c_str())) {
            cout << "Error: " << mysql_error(conexion) << endl;
            return false;
        }
        
        return true;
    }
    
    void generarAlerta(const string& tipo, const string& descripcion, const string& mac, const string& ip) {
        time_t ahora = time(NULL);
        char buffer[80];
        strftime(buffer, sizeof(buffer), "%Y-%m-%d %H:%M:%S", localtime(&ahora));
        
        string query = "INSERT INTO alertas (tipo_alerta, descripcion, mac_address, ip_address, fecha_alerta) VALUES ('" +
                       tipo + "', '" + descripcion + "', '" + mac + "', '" + ip + "', '" + buffer + "')";
        
        if (mysql_query(conexion, query.c_str())) {
            cout << "Error al generar alerta: " << mysql_error(conexion) << endl;
        } else {
            cout << "\n[ALERTA] " << tipo << ": " << descripcion << endl;
        }
    }
    
    void menuPrincipal() {
        int opcion;
        
        do {
            cout << "\n=== SISTEMA DE CONTROL DE ACCESO WiFi ===" << endl;
            cout << "1. Registrar dispositivo" << endl;
            cout << "2. Mostrar dispositivos" << endl;
            cout << "3. Mostrar conexiones activas" << endl;
            cout << "4. Mostrar alertas" << endl;
            cout << "5. Eliminar dispositivo" << endl;
            cout << "6. Simular conexión" << endl;
            cout << "7. Limpiar alertas" << endl;
            cout << "0. Salir" << endl;
            cout << "Opción: ";
            cin >> opcion;
            cin.ignore();
            
            switch (opcion) {
                case 1:
                    registrarDispositivo();
                    break;
                case 2:
                    mostrarDispositivos();
                    break;
                case 3:
                    mostrarConexionesActivas();
                    break;
                case 4:
                    mostrarAlertas();
                    break;
                case 5:
                    eliminarDispositivo();
                    break;
                case 6:
                    simularConexion();
                    break;
                case 7:
                    limpiarAlertas();
                    break;
                case 0:
                    cout << "Saliendo del sistema..." << endl;
                    break;
                default:
                    cout << "Opción inválida" << endl;
            }
        } while (opcion != 0);
    }
    
    void limpiarAlertas() {
        string query = "DELETE FROM alertas";
        if (mysql_query(conexion, query.c_str())) {
            cout << "Error: " << mysql_error(conexion) << endl;
        } else {
            cout << "Alertas limpiadas correctamente" << endl;
        }
    }
};

int main() {
    ControlAccesoWifi sistema;
    sistema.menuPrincipal();
    return 0;
}
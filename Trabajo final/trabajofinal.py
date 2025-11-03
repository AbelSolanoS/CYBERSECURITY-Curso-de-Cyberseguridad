
clientes = {}
claves = {}

def clave_fuerte(clave):
    mayus = any(c.isupper() for c in clave)
    minus = any(c.islower() for c in clave)
    numero = any(c.isdigit() for c in clave)
    especial = any(not c.isalnum() for c in clave)
    larga = len(clave) >= 8
    return mayus and minus and numero and especial and larga

def RegistrarCliente(nombre, clave):
    if nombre in clientes:
        print(f"¡Ey, {nombre}! Ya tú estás registrado.")
        return False
    clientes[nombre] = clave
    print(f"¡Listo, {nombre}! Ya estás en el sistema.")
    return True

def ChequearClave(nombre, clave):
    if nombre not in clientes:
        print(f"¿Quién es {nombre}? No te conozco.")
        return False
    return clientes[nombre] == clave

def AvisarClavesDebiles():
    malas = []
    for nombre, clave in clientes.items():
        if not clave_fuerte(clave):
            malas.append(f"¡Cuidado, {nombre}! Esa clave es floja, cámbiala.")
    if malas:
        for msg in malas:
            print(msg)
    else:
        print("¡Todo bien! Todas las claves están bacanas.")


RegistrarCliente("Yadira", "SantoDomingo2023!")
RegistrarCliente("Ramfis", "12345")
ChequearClave("Yadira", "SantoDomingo2023!")
AvisarClavesDebiles()

print("\n--- Prueba tú mismo ---")
nombre = input("Dime tu nombre: ")
clave = input("Crea tu clave: ")
RegistrarCliente(nombre, clave)
if ChequearClave(nombre, clave):
    print("¡Entraste!")
AvisarClavesDebiles()

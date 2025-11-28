import tkinter as tk
from tkinter import ttk, messagebox
import mysql.connector
from mysql.connector import Error
import datetime
import re

class ControlAccesoWifi:
    def __init__(self, root):
        self.root = root
        self.root.title("Sistema de Control de Acceso WiFi")
        self.root.geometry("1000x700")
        
   
        self.db_config = {
            'host': 'localhost',
            'user': 'root',
            'password': '',
            'database': 'prproyecto'
        }
        
        self.conexion_db = None
        self.conectar_db()
        self.crear_interfaz()
        
    def conectar_db(self):
        """Conectar a la base de datos MySQL"""
        try:
            self.conexion_db = mysql.connector.connect(**self.db_config)
            print("Conexión exitosa a la base de datos")
        except Error as e:
            messagebox.showerror("Error", f"Error al conectar a la base de datos: {e}")
    
    def crear_interfaz(self):
        """Crear la interfaz gráfica principal"""
     
        notebook = ttk.Notebook(self.root)
        notebook.pack(fill='both', expand=True, padx=10, pady=10)
        
       
        self.crear_pestana_registro(notebook)
        
       
        self.crear_pestana_conexiones(notebook)
        
     
        self.crear_pestana_alertas(notebook)
        
      
        self.crear_pestana_configuracion(notebook)
    
    def crear_pestana_registro(self, notebook):
        """Crear pestaña para registrar dispositivos"""
        frame_registro = ttk.Frame(notebook)
        notebook.add(frame_registro, text="Registrar Dispositivos")
        
     
        ttk.Label(frame_registro, text="MAC Address:").grid(row=0, column=0, padx=5, pady=5, sticky='w')
        self.entry_mac = ttk.Entry(frame_registro, width=20)
        self.entry_mac.grid(row=0, column=1, padx=5, pady=5)
        
        ttk.Label(frame_registro, text="IP Address:").grid(row=1, column=0, padx=5, pady=5, sticky='w')
        self.entry_ip = ttk.Entry(frame_registro, width=20)
        self.entry_ip.grid(row=1, column=1, padx=5, pady=5)
        
        ttk.Label(frame_registro, text="Nombre:").grid(row=2, column=0, padx=5, pady=5, sticky='w')
        self.entry_nombre = ttk.Entry(frame_registro, width=20)
        self.entry_nombre.grid(row=2, column=1, padx=5, pady=5)
        
        ttk.Label(frame_registro, text="Usuario:").grid(row=3, column=0, padx=5, pady=5, sticky='w')
        self.entry_usuario = ttk.Entry(frame_registro, width=20)
        self.entry_usuario.grid(row=3, column=1, padx=5, pady=5)
        
    
        ttk.Button(frame_registro, text="Registrar Dispositivo", 
                  command=self.registrar_dispositivo).grid(row=4, column=0, columnspan=2, pady=10)
        
        ttk.Button(frame_registro, text="Limpiar Campos", 
                  command=self.limpiar_campos).grid(row=5, column=0, columnspan=2, pady=5)
        
       
        self.tree_dispositivos = ttk.Treeview(frame_registro, 
                                            columns=('MAC', 'IP', 'Nombre', 'Usuario', 'Estado'),
                                            show='headings')
        self.tree_dispositivos.heading('MAC', text='MAC Address')
        self.tree_dispositivos.heading('IP', text='IP Address')
        self.tree_dispositivos.heading('Nombre', text='Nombre')
        self.tree_dispositivos.heading('Usuario', text='Usuario')
        self.tree_dispositivos.heading('Estado', text='Estado')
        
        self.tree_dispositivos.grid(row=6, column=0, columnspan=2, padx=5, pady=5, sticky='nsew')
        
       
        scrollbar = ttk.Scrollbar(frame_registro, orient='vertical', 
                                 command=self.tree_dispositivos.yview)
        scrollbar.grid(row=6, column=2, sticky='ns')
        self.tree_dispositivos.configure(yscrollcommand=scrollbar.set)
        
        
        ttk.Button(frame_registro, text="Actualizar Lista", 
                  command=self.actualizar_lista_dispositivos).grid(row=7, column=0, pady=5)
        
        ttk.Button(frame_registro, text="Eliminar Seleccionado", 
                  command=self.eliminar_dispositivo).grid(row=7, column=1, pady=5)
        
        frame_registro.grid_rowconfigure(6, weight=1)
        frame_registro.grid_columnconfigure(1, weight=1)
        
      
        self.actualizar_lista_dispositivos()
    
    def crear_pestana_conexiones(self, notebook):
        """Crear pestaña para ver conexiones activas"""
        frame_conexiones = ttk.Frame(notebook)
        notebook.add(frame_conexiones, text="Conexiones Activas")
        
       
        self.tree_conexiones = ttk.Treeview(frame_conexiones, 
                                          columns=('MAC', 'IP', 'Fecha Conexión'),
                                          show='headings')
        self.tree_conexiones.heading('MAC', text='MAC Address')
        self.tree_conexiones.heading('IP', text='IP Address')
        self.tree_conexiones.heading('Fecha Conexión', text='Fecha de Conexión')
        
        self.tree_conexiones.pack(fill='both', expand=True, padx=5, pady=5)
        

        frame_botones = ttk.Frame(frame_conexiones)
        frame_botones.pack(fill='x', padx=5, pady=5)
        
        ttk.Button(frame_botones, text="Actualizar Conexiones", 
                  command=self.actualizar_conexiones).pack(side='left', padx=5)
        
        ttk.Button(frame_botones, text="Simular Conexión", 
                  command=self.simular_conexion).pack(side='left', padx=5)
        
        ttk.Button(frame_botones, text="Validar Todas las Conexiones", 
                  command=self.validar_todas_conexiones).pack(side='left', padx=5)
        

        self.actualizar_conexiones()
    
    def crear_pestana_alertas(self, notebook):
        """Crear pestaña para ver alertas"""
        frame_alertas = ttk.Frame(notebook)
        notebook.add(frame_alertas, text="Alertas")
        
   
        self.tree_alertas = ttk.Treeview(frame_alertas, 
                                       columns=('Tipo', 'Descripción', 'MAC', 'IP', 'Fecha'),
                                       show='headings')
        self.tree_alertas.heading('Tipo', text='Tipo de Alerta')
        self.tree_alertas.heading('Descripción', text='Descripción')
        self.tree_alertas.heading('MAC', text='MAC Address')
        self.tree_alertas.heading('IP', text='IP Address')
        self.tree_alertas.heading('Fecha', text='Fecha')
        
        self.tree_alertas.pack(fill='both', expand=True, padx=5, pady=5)
        
  
        frame_botones = ttk.Frame(frame_alertas)
        frame_botones.pack(fill='x', padx=5, pady=5)
        
        ttk.Button(frame_botones, text="Actualizar Alertas", 
                  command=self.actualizar_alertas).pack(side='left', padx=5)
        
        ttk.Button(frame_botones, text="Limpiar Alertas", 
                  command=self.limpiar_alertas).pack(side='left', padx=5)
        
  
        self.actualizar_alertas()
    
    def crear_pestana_configuracion(self, notebook):
        """Crear pestaña para configuración"""
        frame_config = ttk.Frame(notebook)
        notebook.add(frame_config, text="Configuración")
        
 
        ttk.Label(frame_config, text="Límite de Conexiones por Usuario:").grid(row=0, column=0, padx=5, pady=5, sticky='w')
        self.entry_limite = ttk.Entry(frame_config, width=10)
        self.entry_limite.grid(row=0, column=1, padx=5, pady=5)
        self.entry_limite.insert(0, "3")
        
        ttk.Button(frame_config, text="Establecer Límite", 
                  command=self.establecer_limite).grid(row=0, column=2, padx=5, pady=5)
        
   
        self.monitoreo_activo = tk.BooleanVar()
        ttk.Checkbutton(frame_config, text="Monitoreo Automático", 
                       variable=self.monitoreo_activo).grid(row=1, column=0, padx=5, pady=5, sticky='w')
    
  
    
    def validar_formato_mac(self, mac):
        """Validar formato de MAC address"""
        patron_mac = r'^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$'
        return re.match(patron_mac, mac) is not None
    
    def validar_formato_ip(self, ip):
        """Validar formato de IP address"""
        patron_ip = r'^(\d{1,3}\.){3}\d{1,3}$'
        if re.match(patron_ip, ip):
            partes = ip.split('.')
            for parte in partes:
                if not (0 <= int(parte) <= 255):
                    return False
            return True
        return False
    
    def registrar_dispositivo(self):
        """Función para registrar un nuevo dispositivo"""
        mac = self.entry_mac.get().strip()
        ip = self.entry_ip.get().strip()
        nombre = self.entry_nombre.get().strip()
        usuario = self.entry_usuario.get().strip()
        

        if not mac or not ip or not nombre or not usuario:
            messagebox.showerror("Error", "Todos los campos son obligatorios")
            return
        
        if not self.validar_formato_mac(mac):
            messagebox.showerror("Error", "Formato de MAC address inválido")
            return
        
        if not self.validar_formato_ip(ip):
            messagebox.showerror("Error", "Formato de IP address inválido")
            return
        
        try:
            cursor = self.conexion_db.cursor()
            
         
            cursor.execute("SELECT id FROM dispositivos WHERE mac_address = %s", (mac,))
            if cursor.fetchone():
                messagebox.showerror("Error", "El dispositivo ya está registrado")
                return
            
       
            cursor.execute("""
                INSERT INTO dispositivos (mac_address, ip_address, nombre_dispositivo, usuario)
                VALUES (%s, %s, %s, %s)
            """, (mac, ip, nombre, usuario))
            
            self.conexion_db.commit()
            messagebox.showinfo("Éxito", "Dispositivo registrado correctamente")
            self.limpiar_campos()
            self.actualizar_lista_dispositivos()
            
        except Error as e:
            messagebox.showerror("Error", f"Error al registrar dispositivo: {e}")
    
    def validar_acceso(self, mac, ip):
        """Función para validar el acceso de un dispositivo"""
        try:
            cursor = self.conexion_db.cursor()
            
       
            cursor.execute("""
                SELECT id, usuario FROM dispositivos 
                WHERE mac_address = %s AND estado = 'activo'
            """, (mac,))
            
            dispositivo = cursor.fetchone()
            
            if not dispositivo:
      
                self.generar_alerta("Acceso no autorizado", 
                                  f"Intento de conexión desde dispositivo no registrado. MAC: {mac}, IP: {ip}",
                                  mac, ip)
                return False
            
   
            usuario = dispositivo[1]
            cursor.execute("""
                SELECT COUNT(*) FROM conexiones_activas ca
                JOIN dispositivos d ON ca.mac_address = d.mac_address
                WHERE d.usuario = %s AND ca.estado = 'conectado'
            """, (usuario,))
            
            conexiones_activas = cursor.fetchone()[0]
            
            cursor.execute("""
                SELECT max_conexiones FROM limites_conexion 
                WHERE usuario = %s
            """, (usuario,))
            
            limite_result = cursor.fetchone()
            limite = limite_result[0] if limite_result else 3  # Límite por defecto
            
            if conexiones_activas >= limite:
                self.generar_alerta("Límite de conexiones excedido",
                                  f"El usuario {usuario} ha excedido el límite de {limite} conexiones simultáneas",
                                  mac, ip)
                return False
            

            cursor.execute("""
                INSERT INTO conexiones_activas (mac_address, ip_address)
                VALUES (%s, %s)
            """, (mac, ip))
            
            self.conexion_db.commit()
            return True
            
        except Error as e:
            print(f"Error en validar_acceso: {e}")
            return False
    
    def generar_alerta(self, tipo, descripcion, mac, ip):
        """Función para generar alertas"""
        try:
            cursor = self.conexion_db.cursor()
            cursor.execute("""
                INSERT INTO alertas (tipo_alerta, descripcion, mac_address, ip_address)
                VALUES (%s, %s, %s, %s)
            """, (tipo, descripcion, mac, ip))
            
            self.conexion_db.commit()
            

            messagebox.showwarning("Alerta de Seguridad", f"{tipo}: {descripcion}")
            
        except Error as e:
            print(f"Error al generar alerta: {e}")
    

    
    def limpiar_campos(self):
        """Limpiar campos del formulario"""
        self.entry_mac.delete(0, tk.END)
        self.entry_ip.delete(0, tk.END)
        self.entry_nombre.delete(0, tk.END)
        self.entry_usuario.delete(0, tk.END)
    
    def actualizar_lista_dispositivos(self):
        """Actualizar lista de dispositivos registrados"""
        try:

            for item in self.tree_dispositivos.get_children():
                self.tree_dispositivos.delete(item)
            
            cursor = self.conexion_db.cursor()
            cursor.execute("SELECT mac_address, ip_address, nombre_dispositivo, usuario, estado FROM dispositivos")
            
            for dispositivo in cursor.fetchall():
                self.tree_dispositivos.insert('', 'end', values=dispositivo)
                
        except Error as e:
            messagebox.showerror("Error", f"Error al cargar dispositivos: {e}")
    
    def actualizar_conexiones(self):
        """Actualizar lista de conexiones activas"""
        try:

            for item in self.tree_conexiones.get_children():
                self.tree_conexiones.delete(item)
            
            cursor = self.conexion_db.cursor()
            cursor.execute("""
                SELECT mac_address, ip_address, fecha_conexion 
                FROM conexiones_activas 
                WHERE estado = 'conectado'
                ORDER BY fecha_conexion DESC
            """)
            
            for conexion in cursor.fetchall():
                self.tree_conexiones.insert('', 'end', values=conexion)
                
        except Error as e:
            messagebox.showerror("Error", f"Error al cargar conexiones: {e}")
    
    def actualizar_alertas(self):
        """Actualizar lista de alertas"""
        try:
     
            for item in self.tree_alertas.get_children():
                self.tree_alertas.delete(item)
            
            cursor = self.conexion_db.cursor()
            cursor.execute("""
                SELECT tipo_alerta, descripcion, mac_address, ip_address, fecha_alerta 
                FROM alertas 
                ORDER BY fecha_alerta DESC
            """)
            
            for alerta in cursor.fetchall():
                self.tree_alertas.insert('', 'end', values=alerta)
                
        except Error as e:
            messagebox.showerror("Error", f"Error al cargar alertas: {e}")
    
    def eliminar_dispositivo(self):
        """Eliminar dispositivo seleccionado"""
        seleccion = self.tree_dispositivos.selection()
        if not seleccion:
            messagebox.showwarning("Advertencia", "Seleccione un dispositivo para eliminar")
            return
        
        item = seleccion[0]
        mac = self.tree_dispositivos.item(item)['values'][0]
        
        try:
            cursor = self.conexion_db.cursor()
            cursor.execute("DELETE FROM dispositivos WHERE mac_address = %s", (mac,))
            self.conexion_db.commit()
            
            messagebox.showinfo("Éxito", "Dispositivo eliminado correctamente")
            self.actualizar_lista_dispositivos()
            
        except Error as e:
            messagebox.showerror("Error", f"Error al eliminar dispositivo: {e}")
    
    def simular_conexion(self):
        """Simular una conexión para testing"""
        try:
            cursor = self.conexion_db.cursor()
            cursor.execute("SELECT mac_address, ip_address FROM dispositivos WHERE estado = 'activo' LIMIT 1")
            dispositivo = cursor.fetchone()
            
            if dispositivo:
                mac, ip = dispositivo
                if self.validar_acceso(mac, ip):
                    messagebox.showinfo("Éxito", f"Conexión autorizada para {mac}")
                else:
                    messagebox.showwarning("Denegado", f"Conexión denegada para {mac}")
                
                self.actualizar_conexiones()
                self.actualizar_alertas()
            else:
                messagebox.showwarning("Advertencia", "No hay dispositivos registrados para simular")
                
        except Error as e:
            messagebox.showerror("Error", f"Error en simulación: {e}")
    
    def validar_todas_conexiones(self):
        """Validar todas las conexiones activas"""
        try:
            cursor = self.conexion_db.cursor()
            cursor.execute("SELECT mac_address, ip_address FROM conexiones_activas WHERE estado = 'conectado'")
            
            conexiones = cursor.fetchall()
            for mac, ip in conexiones:
                if not self.validar_acceso(mac, ip):
           
                    cursor.execute("UPDATE conexiones_activas SET estado = 'desconectado' WHERE mac_address = %s", (mac,))
            
            self.conexion_db.commit()
            self.actualizar_conexiones()
            messagebox.showinfo("Éxito", "Validación completada")
            
        except Error as e:
            messagebox.showerror("Error", f"Error en validación: {e}")
    
    def establecer_limite(self):
        """Establecer límite de conexiones por usuario"""
        try:
            limite = int(self.entry_limite.get())
            if limite <= 0:
                messagebox.showerror("Error", "El límite debe ser mayor a 0")
                return
            
           
            messagebox.showinfo("Éxito", f"Límite establecido en {limite} conexiones por usuario")
            
        except ValueError:
            messagebox.showerror("Error", "El límite debe ser un número válido")
    
    def limpiar_alertas(self):
        """Limpiar todas las alertas"""
        try:
            cursor = self.conexion_db.cursor()
            cursor.execute("DELETE FROM alertas")
            self.conexion_db.commit()
            self.actualizar_alertas()
            messagebox.showinfo("Éxito", "Alertas limpiadas correctamente")
            
        except Error as e:
            messagebox.showerror("Error", f"Error al limpiar alertas: {e}")

def main():
    root = tk.Tk()
    app = ControlAccesoWifi(root)
    root.mainloop()

if __name__ == "__main__":
    main()
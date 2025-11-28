
import tkinter as tk
from tkinter import ttk

class Aplicacion:
    def __init__(self):
        self.ventana1 = tk.Tk()
        
        self.labelframe1 = ttk.LabelFrame(self.ventana1, text="Área de Login")
        self.labelframe1.grid(column=0, row=0, padx=5, pady=10)
        self.login()
        
        self.labelframe2 = ttk.LabelFrame(self.ventana1, text="Área de Botones")
        self.labelframe2.grid(column=0, row=1, padx=5, pady=10)
        self.botones()
        
        self.ventana1.mainloop()

    def login(self):
        self.label1 = ttk.Label(self.labelframe1, text="Usuario:")
        self.label1.grid(column=0, row=0, padx=4, pady=4)
        self.entry1 = ttk.Entry(self.labelframe1)
        self.entry1.grid(column=1, row=0, padx=4, pady=4)
        
        self.label2 = ttk.Label(self.labelframe1, text="Contraseña:")
        self.label2.grid(column=0, row=1, padx=4, pady=4)
        self.entry2 = ttk.Entry(self.labelframe1, show="*")
        self.entry2.grid(column=1, row=1, padx=4, pady=4)
        
        self.boton_login = ttk.Button(self.labelframe1, text="Ingresar")
        self.boton_login.grid(column=1, row=2, padx=4, pady=4)

    def botones(self):
        self.boton1 = ttk.Button(self.labelframe2, text="Opción 1")
        self.boton1.grid(column=0, row=0, padx=4, pady=4)
        
        self.boton2 = ttk.Button(self.labelframe2, text="Opción 2")
        self.boton2.grid(column=1, row=0, padx=4, pady=4)
        
        self.boton3 = ttk.Button(self.labelframe2, text="Opción 3")
        self.boton3.grid(column=2, row=0, padx=4, pady=4)

aplicacion1 = Aplicacion()

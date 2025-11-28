
import tkinter as tk
from tkinter import ttk

class Aplicacion:
    def __init__(self):
        self.ventana1 = tk.Tk()
        
        self.label_nombre = ttk.Label(self.ventana1, text="Nombre:")
        self.label_nombre.grid(column=0, row=0)
        self.dato_nombre = tk.StringVar()
        self.entry_nombre = ttk.Entry(self.ventana1, width=20, textvariable=self.dato_nombre)
        self.entry_nombre.grid(column=1, row=0)
        
        self.label_pais = ttk.Label(self.ventana1, text="País:")
        self.label_pais.grid(column=0, row=1)
        self.combo_pais = ttk.Combobox(self.ventana1, values=["Argentina", "Brasil", "Chile", "Colombia", "México", "España", "Perú"])
        self.combo_pais.grid(column=1, row=1)
        
        self.boton_mostrar = ttk.Button(self.ventana1, text="Mostrar", command=self.mostrar)
        self.boton_mostrar.grid(column=1, row=2)
        
        self.ventana1.mainloop()

    def mostrar(self):
        nombre = self.dato_nombre.get()
        pais = self.combo_pais.get()
        self.ventana1.title(f"Nombre: {nombre} - País: {pais}")

aplicacion1 = Aplicacion()

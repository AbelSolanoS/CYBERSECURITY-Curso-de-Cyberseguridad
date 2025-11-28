
import tkinter as tk
from tkinter import ttk

class Aplicacion:
    def __init__(self):
        self.ventana1 = tk.Tk()
        
        self.label_num1 = ttk.Label(self.ventana1, text="Ancho:")
        self.label_num1.grid(column=0, row=0)
        self.dato_ancho = tk.StringVar()
        self.entry_ancho = ttk.Entry(self.ventana1, width=10, textvariable=self.dato_ancho)
        self.entry_ancho.grid(column=1, row=0)
        
        self.label_num2 = ttk.Label(self.ventana1, text="Alto:")
        self.label_num2.grid(column=0, row=1)
        self.dato_alto = tk.StringVar()
        self.entry_alto = ttk.Entry(self.ventana1, width=10, textvariable=self.dato_alto)
        self.entry_alto.grid(column=1, row=1)
        
        menubar = tk.Menu(self.ventana1)
        self.ventana1.config(menu=menubar)
        
        opciones = tk.Menu(menubar, tearoff=0)
        opciones.add_command(label="Cambiar tamaño", command=self.cambiar_tamaño)
        opciones.add_command(label="Salir", command=self.salir)
        
        menubar.add_cascade(label="Opciones", menu=opciones)
        
        self.ventana1.mainloop()
    
    def cambiar_tamaño(self):
        try:
            ancho = int(self.dato_ancho.get())
            alto = int(self.dato_alto.get())
            self.ventana1.geometry(f"{ancho}x{alto}")
        except ValueError:
            pass
    
    def salir(self):
        self.ventana1.quit()

aplicacion1 = Aplicacion()

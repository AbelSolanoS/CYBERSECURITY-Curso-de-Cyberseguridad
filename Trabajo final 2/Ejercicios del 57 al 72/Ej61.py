
import tkinter as tk
from tkinter import ttk

class Aplicacion:
    def __init__(self):
        self.ventana1 = tk.Tk()
        
        self.navegadores = ["Chrome", "Firefox", "Edge", "Safari", "Opera"]
        self.selecciones = []
        
        for i, navegador in enumerate(self.navegadores):
            var = tk.IntVar()
            self.selecciones.append(var)
            check = ttk.Checkbutton(self.ventana1, text=navegador, variable=var, command=self.actualizar_titulo)
            check.grid(column=0, row=i)
        
        self.ventana1.mainloop()

    def actualizar_titulo(self):
        seleccionados = []
        for i, var in enumerate(self.selecciones):
            if var.get() == 1:
                seleccionados.append(self.navegadores[i])
        
        if seleccionados:
            self.ventana1.title("Navegadores: " + ", ".join(seleccionados))
        else:
            self.ventana1.title("Seleccione navegadores")

aplicacion1 = Aplicacion()

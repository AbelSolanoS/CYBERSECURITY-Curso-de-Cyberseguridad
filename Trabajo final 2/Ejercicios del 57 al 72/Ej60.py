
import tkinter as tk
from tkinter import ttk

class Aplicacion:
    def __init__(self):
        self.ventana1 = tk.Tk()
        self.seleccion = tk.IntVar()
        
        self.radio1 = ttk.Radiobutton(self.ventana1, text="Rojo", variable=self.seleccion, value=1)
        self.radio1.grid(column=0, row=0)
        
        self.radio2 = ttk.Radiobutton(self.ventana1, text="Verde", variable=self.seleccion, value=2)
        self.radio2.grid(column=0, row=1)
        
        self.radio3 = ttk.Radiobutton(self.ventana1, text="Azul", variable=self.seleccion, value=3)
        self.radio3.grid(column=0, row=2)
        
        self.boton1 = ttk.Button(self.ventana1, text="Cambiar color", command=self.cambiar_color)
        self.boton1.grid(column=0, row=3)
        
        self.ventana1.mainloop()

    def cambiar_color(self):
        if self.seleccion.get() == 1:
            self.ventana1.configure(bg="red")
        if self.seleccion.get() == 2:
            self.ventana1.configure(bg="green")
        if self.seleccion.get() == 3:
            self.ventana1.configure(bg="blue")

aplicacion1 = Aplicacion()


import tkinter as tk
from tkinter import ttk

class Aplicacion:
    def __init__(self):
        self.ventana1 = tk.Tk()
        self.ventana1.title("Botones")
        
        self.boton_varon = ttk.Button(self.ventana1, text="varón", command=self.varon)
        self.boton_varon.grid(column=0, row=0)
        
        self.boton_mujer = ttk.Button(self.ventana1, text="mujer", command=self.mujer)
        self.boton_mujer.grid(column=1, row=0)
        
        self.botones_presionados = []
        self.label_resultado = ttk.Label(self.ventana1, text="")
        self.label_resultado.grid(column=0, row=2, columnspan=5)
        
        for i in range(5):
            boton = ttk.Button(self.ventana1, text=str(i+1), command=lambda x=i+1: self.agregar_boton(x))
            boton.grid(column=i, row=1)
            
        self.ventana1.mainloop()
    
    def varon(self):
        self.ventana1.title("varón")
    
    def mujer(self):
        self.ventana1.title("mujer")
    
    def agregar_boton(self, numero):
        if numero not in self.botones_presionados:
            self.botones_presionados.append(numero)
            self.label_resultado.configure(text="Botones: " + ", ".join(map(str, self.botones_presionados)))

aplicacion1 = Aplicacion()

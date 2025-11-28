
import tkinter as tk
from tkinter import ttk

class Aplicacion:
    def __init__(self):
        self.ventana1 = tk.Tk()
        
        self.label_num1 = ttk.Label(self.ventana1, text="Primer número:")
        self.label_num1.grid(column=0, row=0)
        self.dato_num1 = tk.StringVar()
        self.entry_num1 = ttk.Entry(self.ventana1, width=10, textvariable=self.dato_num1)
        self.entry_num1.grid(column=1, row=0)
        
        self.label_num2 = ttk.Label(self.ventana1, text="Segundo número:")
        self.label_num2.grid(column=0, row=1)
        self.dato_num2 = tk.StringVar()
        self.entry_num2 = ttk.Entry(self.ventana1, width=10, textvariable=self.dato_num2)
        self.entry_num2.grid(column=1, row=1)
        
        self.boton_sumar = ttk.Button(self.ventana1, text="Sumar", command=self.sumar)
        self.boton_sumar.grid(column=1, row=2)
        
        self.label_resultado = ttk.Label(self.ventana1, text="Resultado:")
        self.label_resultado.grid(column=1, row=3)
        
        self.label_usuario = ttk.Label(self.ventana1, text="Usuario:")
        self.label_usuario.grid(column=0, row=4)
        self.dato_usuario = tk.StringVar()
        self.entry_usuario = ttk.Entry(self.ventana1, width=15, textvariable=self.dato_usuario)
        self.entry_usuario.grid(column=1, row=4)
        
        self.label_clave = ttk.Label(self.ventana1, text="Clave:")
        self.label_clave.grid(column=0, row=5)
        self.dato_clave = tk.StringVar()
        self.entry_clave = ttk.Entry(self.ventana1, width=15, textvariable=self.dato_clave, show="*")
        self.entry_clave.grid(column=1, row=5)
        
        self.boton_verificar = ttk.Button(self.ventana1, text="Verificar", command=self.verificar)
        self.boton_verificar.grid(column=1, row=6)
        
        self.ventana1.mainloop()
    
    def sumar(self):
        try:
            num1 = int(self.dato_num1.get())
            num2 = int(self.dato_num2.get())
            suma = num1 + num2
            self.label_resultado.configure(text=f"Resultado: {suma}")
        except ValueError:
            self.label_resultado.configure(text="Error: Ingrese números válidos")
    
    def verificar(self):
        usuario = self.dato_usuario.get()
        clave = self.dato_clave.get()
        if usuario == "juan" and clave == "abc123":
            self.ventana1.title("Correcto")
        else:
            self.ventana1.title("Incorrecto")

aplicacion1 = Aplicacion()

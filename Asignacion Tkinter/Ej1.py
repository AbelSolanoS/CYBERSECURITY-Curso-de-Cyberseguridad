import tkinter as tk

ventana = tk.Tk()
ventana.title("Bienvenida")
ventana.geometry("300x200")

etiqueta = tk.Label(ventana, text="¡Bienvenido/a!", font=("Arial", 18))
etiqueta.pack(expand=True)

ventana.mainloop()
import tkinter as tk

def mostrar_texto():
    label_resultado.config(text=entry.get())

ventana = tk.Tk()
ventana.title("Interfaz Texto")

entry = tk.Entry(ventana, width=30)
entry.pack(pady=10)

boton = tk.Button(ventana, text="Mostrar", command=mostrar_texto)
boton.pack(pady=5)

label_resultado = tk.Label(ventana, text="")
label_resultado.pack(pady=10)

ventana.mainloop()
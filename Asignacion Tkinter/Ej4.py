import tkinter as tk

def agregar_elemento():
    elemento = entry.get()
    if elemento:
        listbox.insert(tk.END, elemento)
        entry.delete(0, tk.END)

ventana = tk.Tk()
ventana.title("Lista de Elementos")

listbox = tk.Listbox(ventana)
listbox.pack(pady=10)

entry = tk.Entry(ventana)
entry.pack(pady=5)

boton_agregar = tk.Button(ventana, text="Agregar", command=agregar_elemento)
boton_agregar.pack(pady=5)

ventana.mainloop()
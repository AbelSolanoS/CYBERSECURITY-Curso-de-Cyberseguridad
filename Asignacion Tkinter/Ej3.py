import tkinter as tk

def sumar():
    try:
        num1 = float(entry1.get())
        num2 = float(entry2.get())
        resultado = num1 + num2
        label_resultado.config(text=f"Resultado: {resultado}")
    except ValueError:
        label_resultado.config(text="Error: Ingresa números")

ventana = tk.Tk()
ventana.title("Calculadora")

tk.Label(ventana, text="Número 1:").pack()
entry1 = tk.Entry(ventana)
entry1.pack()

tk.Label(ventana, text="Número 2:").pack()
entry2 = tk.Entry(ventana)
entry2.pack()

tk.Button(ventana, text="Sumar", command=sumar).pack()

label_resultado = tk.Label(ventana, text="Resultado: ")
label_resultado.pack()

ventana.mainloop()
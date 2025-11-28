import tkinter as tk
def iniciar_linea(event):
    global x1, y1
    x1, y1 = event.x, event.y
def dibujar_linea(event):
    global x1, y1
    x2, y2 = event.x, event.y
    canvas.create_line(x1, y1, x2, y2)
    x1, y1 = x2, y2
ventana = tk.Tk()
ventana.title("Dibujar Líneas")
canvas = tk.Canvas(ventana, width=400, height=400, bg="white")
canvas.pack()
canvas.bind("<Button-1>", iniciar_linea)
canvas.bind("<B1-Motion>", dibujar_linea)
ventana.mainloop()
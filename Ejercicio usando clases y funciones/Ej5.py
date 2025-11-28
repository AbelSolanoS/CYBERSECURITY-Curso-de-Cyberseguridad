class Estudiante:
    def __init__(self, nombre, calificaciones=[]):
        self.nombre = nombre
        self.calificaciones = calificaciones
    
    def calcular_promedio(self):
        if not self.calificaciones:
            return 0
        return sum(self.calificaciones) / len(self.calificaciones)
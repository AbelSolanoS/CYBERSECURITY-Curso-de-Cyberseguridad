class Coche:
    def __init__(self, marca, velocidad=0):
        self.marca = marca
        self.velocidad = velocidad
    
    def aumentar_velocidad(self, incremento):
        self.velocidad += incremento
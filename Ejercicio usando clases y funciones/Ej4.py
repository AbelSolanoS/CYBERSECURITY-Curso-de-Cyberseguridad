class CuentaBancaria:
    def __init__(self, titular, balance=0):
        self.titular = titular
        self.balance = balance
    
    def depositar(self, cantidad):
        self.balance += cantidad
    
    def retirar(self, cantidad):
        if cantidad <= self.balance:
            self.balance -= cantidad
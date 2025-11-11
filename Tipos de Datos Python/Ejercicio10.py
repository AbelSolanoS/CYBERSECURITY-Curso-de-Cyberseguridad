lado1 = float(input())
lado2 = float(input())
lado3 = float(input())
if lado1 == lado2 == lado3:
    print("Equilátero")
elif lado1 == lado2 or lado1 == lado3 or lado2 == lado3:
    print("Isósceles")
else:
    print("Escaleno")
vulnerabilidades = ('SQL Injection', 'Cross-Site Scripting', 'Buffer Overflow', 'Denegación de Servicio')
print(vulnerabilidades[1])
print(vulnerabilidades[-2:])
print(vulnerabilidades[-1])
print(len(vulnerabilidades))
print(vulnerabilidades[0:3])
print('SQL Injection' in vulnerabilidades)
print(vulnerabilidades.index('Buffer Overflow'))
for v in vulnerabilidades:
    print(v)
try:
    vulnerabilidades[0] = 'Nuevo'
except TypeError as e:
    print(e)
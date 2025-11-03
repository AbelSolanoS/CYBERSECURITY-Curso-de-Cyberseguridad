puertos_abiertos = [22, 80, 443, 8080]
puertos_abiertos.append(21)
puertos_abiertos.remove(8080)
print(sorted(puertos_abiertos))
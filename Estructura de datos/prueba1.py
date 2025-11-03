nota=int(input("Introduce la calificacion del alumno del mes de Enero: "))
nota2=int(input("Introduce la calificacion del alumno del mes de Febrero: "))
nota3=int(input("Introduce la calificacion del alumno del mes de Marzo: ")) 
nota4=int(input("Introduce la calificacion del alumno del mes de Abril: "))
nota5=int(input("Introduce la calificacion del alumno del mes de Mayo: "))

prom=(nota+nota2+nota3+nota4+nota5)/5
print("El promedio de las notas del alumno es: ",prom)
if prom>=70:
    print("El alumno esta pasado de las pruebas")
    nota_examen=int(input("Introduce la calificacion del examen final: "))
    print("La calificacion del examen final es: ",nota_examen)
    pregunta=str(input("Desea tener el resultado final?"))
    if pregunta=="si":
        resultado_final=nota_examen*0.30
        resultadog=prom+resultado_final
        print("El resultado final del alumno es: ",resultadog)
        if resultado_final>=70:
            print("El alumno ha aprobado el curso")
        else:
            print("El alumno ha reprobado el curso")
    



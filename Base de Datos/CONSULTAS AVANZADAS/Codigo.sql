
USE universidad2;

SELECT * FROM Estudiante LIMIT 20;

SELECT Nombre, Apellido FROM Estudiante LIMIT 20;

SELECT * FROM Estudiante 
WHERE DepartamentoID = 1 
LIMIT 20;

SELECT Nombre, Apellido, FechaNacimiento 
FROM Estudiante 
ORDER BY FechaNacimiento ASC 
LIMIT 10;

SELECT COUNT(*) AS TotalEstudiantes FROM Estudiante;

SELECT * FROM Estudiante 
WHERE Apellido = 'García' 
LIMIT 10;

SELECT * FROM Estudiante 
WHERE Apellido LIKE '%garc%' 
LIMIT 10;

SELECT Nombre, Apellido 
FROM Estudiante 
WHERE Nombre LIKE 'A%' 
LIMIT 15;

SELECT E.Nombre, E.Apellido, D.Nombre AS Departamento
FROM Estudiante E
JOIN Departamento D ON E.DepartamentoID = D.DepartamentoID
LIMIT 15;

SELECT 
    E.EstudianteID,
    CONCAT(E.Nombre, ' ', E.Apellido) AS Estudiante,
    ROUND(AVG(C.Nota), 2) AS Promedio,
    COUNT(C.CalificacionID) AS TotalCalificaciones
FROM Estudiante E
JOIN Inscripcion I ON E.EstudianteID = I.EstudianteID
JOIN Calificacion C ON I.InscripcionID = C.InscripcionID
GROUP BY E.EstudianteID
HAVING COUNT(C.CalificacionID) > 0
ORDER BY Promedio DESC
LIMIT 15;

SELECT 
    D.Nombre AS Departamento,
    COUNT(E.EstudianteID) AS TotalEstudiantes
FROM Estudiante E
JOIN Departamento D ON E.DepartamentoID = D.DepartamentoID
GROUP BY D.Nombre
ORDER BY TotalEstudiantes DESC
LIMIT 15;

SELECT 
    P.ProfesorID,
    CONCAT(P.Nombre, ' ', P.Apellido) AS Profesor,
    COUNT(DISTINCT C.ClaseID) AS TotalClasesImpartidas,
    COUNT(DISTINCT CUR.CursoID) AS CursosDiferentes
FROM Profesor P
JOIN Clase C ON P.ProfesorID = C.ProfesorID
JOIN Curso CUR ON C.CursoID = CUR.CursoID
GROUP BY P.ProfesorID
ORDER BY TotalClasesImpartidas DESC
LIMIT 15;

SELECT 
    E.EstudianteID,
    CONCAT(E.Nombre, ' ', E.Apellido) AS Estudiante,
    ROUND(AVG(C.Nota), 2) AS Promedio
FROM Estudiante E
JOIN Inscripcion I ON E.EstudianteID = I.EstudianteID
JOIN Calificacion C ON I.InscripcionID = C.InscripcionID
GROUP BY E.EstudianteID
HAVING AVG(C.Nota) > 90
ORDER BY Promedio DESC
LIMIT 15;

SELECT 
    E.EstudianteID,
    CONCAT(E.Nombre, ' ', E.Apellido) AS Estudiante,
    ROUND(AVG(C.Nota), 2) AS Promedio,
    COUNT(C.CalificacionID) AS TotalCalificaciones
FROM Estudiante E
JOIN Inscripcion I ON E.EstudianteID = I.EstudianteID
JOIN Calificacion C ON I.InscripcionID = C.InscripcionID
GROUP BY E.EstudianteID
HAVING COUNT(C.CalificacionID) > 0
ORDER BY Promedio DESC
LIMIT 5;

SELECT 
    D.Nombre AS Departamento,
    COUNT(E.EstudianteID) AS TotalEstudiantes
FROM Estudiante E
JOIN Departamento D ON E.DepartamentoID = D.DepartamentoID
GROUP BY D.Nombre
ORDER BY TotalEstudiantes DESC
LIMIT 1;

SELECT 
    CUR.CursoID,
    CUR.Nombre AS Curso,
    COUNT(DISTINCT I.EstudianteID) AS EstudiantesInscritos
FROM Curso CUR
JOIN Clase C ON CUR.CursoID = C.CursoID
JOIN Inscripcion I ON C.ClaseID = I.ClaseID
GROUP BY CUR.CursoID, CUR.Nombre
ORDER BY EstudiantesInscritos DESC
LIMIT 10;

SELECT 
    P.ProfesorID,
    CONCAT(P.Nombre, ' ', P.Apellido) AS Profesor,
    D.Nombre AS Departamento,
    COUNT(C.ClaseID) AS ClasesImpartidas
FROM Profesor P
JOIN Clase C ON P.ProfesorID = C.ProfesorID
JOIN Departamento D ON P.DepartamentoID = D.DepartamentoID
GROUP BY P.ProfesorID, P.Nombre, P.Apellido, D.Nombre
ORDER BY ClasesImpartidas DESC
LIMIT 10;

SELECT 
    E.EstudianteID,
    CONCAT(E.Nombre, ' ', E.Apellido) AS Estudiante,
    D.Nombre AS Departamento,
    COUNT(DISTINCT I.ClaseID) AS CursosMatriculados
FROM Estudiante E
JOIN Inscripcion I ON E.EstudianteID = I.EstudianteID
JOIN Departamento D ON E.DepartamentoID = D.DepartamentoID
GROUP BY E.EstudianteID, E.Nombre, E.Apellido, D.Nombre
ORDER BY CursosMatriculados DESC
LIMIT 10;

SELECT 
    YEAR(FechaNacimiento) AS AñoNacimiento,
    COUNT(*) AS CantidadEstudiantes
FROM Estudiante
WHERE FechaNacimiento IS NOT NULL
GROUP BY YEAR(FechaNacimiento)
ORDER BY AñoNacimiento DESC;

SELECT 
    (SELECT COUNT(*) FROM Estudiante) AS TotalEstudiantes,
    (SELECT COUNT(*) FROM Profesor) AS TotalProfesores,
    (SELECT COUNT(*) FROM Curso) AS TotalCursos,
    (SELECT COUNT(*) FROM Clase) AS TotalClases,
    (SELECT COUNT(*) FROM Inscripcion) AS TotalInscripciones,
    (SELECT COUNT(*) FROM Calificacion) AS TotalCalificaciones,
    (SELECT ROUND(AVG(Nota), 2) FROM Calificacion) AS PromedioGeneral;

SELECT 
    E.EstudianteID,
    CONCAT(E.Nombre, ' ', E.Apellido) AS Estudiante,
    D.Nombre AS Departamento
FROM Estudiante E
LEFT JOIN Inscripcion I ON E.EstudianteID = I.EstudianteID
LEFT JOIN Calificacion C ON I.InscripcionID = C.InscripcionID
JOIN Departamento D ON E.DepartamentoID = D.DepartamentoID
WHERE C.CalificacionID IS NULL
GROUP BY E.EstudianteID, E.Nombre, E.Apellido, D.Nombre
LIMIT 15;

SELECT 
    D.Nombre AS Departamento,
    ROUND(AVG(C.Nota), 2) AS PromedioCalificaciones,
    COUNT(C.CalificacionID) AS TotalCalificaciones
FROM Departamento D
JOIN Estudiante E ON D.DepartamentoID = E.DepartamentoID
JOIN Inscripcion I ON E.EstudianteID = I.EstudianteID
JOIN Calificacion C ON I.InscripcionID = C.InscripcionID
GROUP BY D.DepartamentoID, D.Nombre
ORDER BY PromedioCalificaciones DESC;

SELECT 
    C.CalificacionID,
    CONCAT(E.Nombre, ' ', E.Apellido) AS Estudiante,
    CUR.Nombre AS Curso,
    C.Nota,
    C.FechaRegistro
FROM Calificacion C
JOIN Inscripcion I ON C.InscripcionID = I.InscripcionID
JOIN Estudiante E ON I.EstudianteID = E.EstudianteID
JOIN Clase CL ON I.ClaseID = CL.ClaseID
JOIN Curso CUR ON CL.CursoID = CUR.CursoID
ORDER BY C.Nota DESC
LIMIT 10;

SELECT 
    E.EstudianteID,
    CONCAT(E.Nombre, ' ', E.Apellido) AS Estudiante,
    CUR.Nombre AS Curso,
    CONCAT(P.Nombre, ' ', P.Apellido) AS Profesor,
    CL.Año,
    CL.Semestre,
    C.Nota,
    I.FechaInscripcion
FROM Estudiante E
JOIN Inscripcion I ON E.EstudianteID = I.EstudianteID
JOIN Clase CL ON I.ClaseID = CL.ClaseID
JOIN Curso CUR ON CL.CursoID = CUR.CursoID
JOIN Profesor P ON CL.ProfesorID = P.ProfesorID
LEFT JOIN Calificacion C ON I.InscripcionID = C.InscripcionID
ORDER BY E.EstudianteID, CL.Año, CL.Semestre
LIMIT 20;

SELECT 
    'Estudiante' AS Tabla,
    COUNT(*) AS Registros,
    (SELECT COUNT(*) FROM Estudiante WHERE DepartamentoID NOT IN (SELECT DepartamentoID FROM Departamento)) AS FK_Violaciones
UNION ALL
SELECT 
    'Profesor' AS Tabla,
    COUNT(*) AS Registros,
    (SELECT COUNT(*) FROM Profesor WHERE DepartamentoID NOT IN (SELECT DepartamentoID FROM Departamento)) AS FK_Violaciones
UNION ALL
SELECT 
    'Curso' AS Tabla,
    COUNT(*) AS Registros,
    (SELECT COUNT(*) FROM Curso WHERE DepartamentoID NOT IN (SELECT DepartamentoID FROM Departamento)) AS FK_Violaciones
UNION ALL
SELECT 
    'Clase' AS Tabla,
    COUNT(*) AS Registros,
    (SELECT COUNT(*) FROM Clase WHERE CursoID NOT IN (SELECT CursoID FROM Curso) OR ProfesorID NOT IN (SELECT ProfesorID FROM Profesor)) AS FK_Violaciones
UNION ALL
SELECT 
    'Inscripcion' AS Tabla,
    COUNT(*) AS Registros,
    (SELECT COUNT(*) FROM Inscripcion WHERE EstudianteID NOT IN (SELECT EstudianteID FROM Estudiante) OR ClaseID NOT IN (SELECT ClaseID FROM Clase)) AS FK_Violaciones
UNION ALL
SELECT 
    'Calificacion' AS Tabla,
    COUNT(*) AS Registros,
    (SELECT COUNT(*) FROM Calificacion WHERE InscripcionID NOT IN (SELECT InscripcionID FROM Inscripcion)) AS FK_Violaciones;

SELECT 
    'RESUMEN DEL SISTEMA UNIVERSITARIO' AS Titulo,
    '' AS Detalle
UNION ALL
SELECT 'Total Estudiantes:', CAST((SELECT COUNT(*) FROM Estudiante) AS CHAR)
UNION ALL
SELECT 'Total Profesores:', CAST((SELECT COUNT(*) FROM Profesor) AS CHAR)
UNION ALL
SELECT 'Total Departamentos:', CAST((SELECT COUNT(*) FROM Departamento) AS CHAR)
UNION ALL
SELECT 'Total Cursos:', CAST((SELECT COUNT(*) FROM Curso) AS CHAR)
UNION ALL
SELECT 'Total Clases (secciones):', CAST((SELECT COUNT(*) FROM Clase) AS CHAR)
UNION ALL
SELECT 'Total Inscripciones:', CAST((SELECT COUNT(*) FROM Inscripcion) AS CHAR)
UNION ALL
SELECT 'Total Calificaciones:', CAST((SELECT COUNT(*) FROM Calificacion) AS CHAR)
UNION ALL
SELECT 'Promedio General de Calificaciones:', CAST((SELECT ROUND(AVG(Nota), 2) FROM Calificacion) AS CHAR)
UNION ALL
SELECT 'Estudiante con Mejor Promedio:', 
    (SELECT CONCAT(Nombre, ' ', Apellido) FROM Estudiante WHERE EstudianteID = (
        SELECT E.EstudianteID
        FROM Estudiante E
        JOIN Inscripcion I ON E.EstudianteID = I.EstudianteID
        JOIN Calificacion C ON I.InscripcionID = C.InscripcionID
        GROUP BY E.EstudianteID
        ORDER BY AVG(C.Nota) DESC
        LIMIT 1
    ))
UNION ALL
SELECT 'Departamento con más Estudiantes:', 
    (SELECT D.Nombre FROM Departamento D WHERE D.DepartamentoID = (
        SELECT E.DepartamentoID
        FROM Estudiante E
        GROUP BY E.DepartamentoID
        ORDER BY COUNT(*) DESC
        LIMIT 1
    ));

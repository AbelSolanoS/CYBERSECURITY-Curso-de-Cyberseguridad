USE sistema_academico;

SELECT 
    'Estadísticas Generales del Sistema' AS Reporte,
    '' AS Valor
UNION ALL
SELECT 'Total Estudiantes:', CAST(COUNT(*) AS CHAR) FROM Estudiante
UNION ALL
SELECT 'Total Profesores:', CAST(COUNT(*) AS CHAR) FROM Profesor
UNION ALL
SELECT 'Total Departamentos:', CAST(COUNT(*) AS CHAR) FROM Departamento
UNION ALL
SELECT 'Total Cursos:', CAST(COUNT(*) AS CHAR) FROM Curso
UNION ALL
SELECT 'Total Clases Activas:', CAST(COUNT(*) AS CHAR) FROM Clase WHERE Estado = 'En curso'
UNION ALL
SELECT 'Total Inscripciones Activas:', CAST(COUNT(*) AS CHAR) FROM Inscripcion WHERE Estado = 'Inscrito'
UNION ALL
SELECT 'Promedio General de Calificaciones:', CAST(ROUND(AVG(NotaDefinitiva), 2) AS CHAR) FROM Calificacion;

SELECT 
    D.Nombre AS Departamento,
    COUNT(E.EstudianteID) AS Estudiantes,
    COUNT(P.ProfesorID) AS Profesores,
    ROUND(COUNT(E.EstudianteID) * 1.0 / COUNT(P.ProfesorID), 2) AS Ratio_Est_Prof
FROM Departamento D
LEFT JOIN Estudiante E ON D.DepartamentoID = E.DepartamentoID
LEFT JOIN Profesor P ON D.DepartamentoID = P.DepartamentoID
GROUP BY D.DepartamentoID, D.Nombre
ORDER BY Estudiantes DESC;

SELECT 
    CASE 
        WHEN NotaDefinitiva >= 90 THEN 'Excelente (90-100)'
        WHEN NotaDefinitiva >= 80 THEN 'Muy Bueno (80-89)'
        WHEN NotaDefinitiva >= 70 THEN 'Bueno (70-79)'
        WHEN NotaDefinitiva >= 60 THEN 'Regular (60-69)'
        ELSE 'Deficiente (0-59)'
    END AS RangoCalificacion,
    COUNT(*) AS CantidadEstudiantes,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Calificacion), 2) AS Porcentaje
FROM Calificacion
GROUP BY 
    CASE 
        WHEN NotaDefinitiva >= 90 THEN 'Excelente (90-100)'
        WHEN NotaDefinitiva >= 80 THEN 'Muy Bueno (80-89)'
        WHEN NotaDefinitiva >= 70 THEN 'Bueno (70-79)'
        WHEN NotaDefinitiva >= 60 THEN 'Regular (60-69)'
        ELSE 'Deficiente (0-59)'
    END
ORDER BY MIN(NotaDefinitiva) DESC;

SELECT 
    C.Nombre AS Curso,
    CR.Codigo,
    COUNT(DISTINCT I.EstudianteID) AS TotalInscritos,
    AVG(CA.NotaDefinitiva) AS PromedioCurso,
    MIN(CA.NotaDefinitiva) AS NotaMinima,
    MAX(CA.NotaDefinitiva) AS NotaMaxima,
    ROUND(AVG(CA.NotaDefinitiva), 2) AS PromedioRedondeado
FROM Curso CR
LEFT JOIN Clase CL ON CR.CursoID = CL.CursoID
LEFT JOIN Inscripcion I ON CL.ClaseID = I.ClaseID
LEFT JOIN Calificacion CA ON I.InscripcionID = CA.InscripcionID
GROUP BY CR.CursoID, C.Nombre, CR.Codigo
ORDER BY AVG(CA.NotaDefinitiva) DESC;

SELECT 
    CONCAT(P.Nombre, ' ', P.Apellido) AS Profesor,
    D.Nombre AS Departamento,
    COUNT(CL.ClaseID) AS ClasesAsignadas,
    COUNT(DISTINCT I.EstudianteID) AS EstudiantesTotales,
    ROUND(AVG(CA.NotaDefinitiva), 2) AS PromedioCalificaciones
FROM Profesor P
INNER JOIN Departamento D ON P.DepartamentoID = D.DepartamentoID
LEFT JOIN Clase CL ON P.ProfesorID = CL.ProfesorID
LEFT JOIN Inscripcion I ON CL.ClaseID = I.ClaseID
LEFT JOIN Calificacion CA ON I.InscripcionID = CA.InscripcionID
GROUP BY P.ProfesorID, P.Nombre, P.Apellido, D.Nombre
ORDER BY EstudiantesTotales DESC;

SELECT 
    E.EstudianteID,
    CONCAT(E.Nombre, ' ', E.Apellido) AS Estudiante,
    D.Nombre AS Departamento,
    COUNT(I.InscripcionID) AS CursosInscritos,
    SUM(CR.Creditos) AS CreditosInscritos,
    ROUND(AVG(CA.NotaDefinitiva), 2) AS PromedioGeneral,
    CASE 
        WHEN AVG(CA.NotaDefinitiva) >= 90 THEN 'Excelencia Académica'
        WHEN AVG(CA.NotaDefinitiva) >= 80 THEN 'Muy Buen Desempeño'
        WHEN AVG(CA.NotaDefinitiva) >= 70 THEN 'Buen Desempeño'
        WHEN AVG(CA.NotaDefinitiva) >= 60 THEN 'Desempeño Regular'
        ELSE 'Necesita Mejorar'
    END AS
USE sistema_academico;

SELECT 
    E.Nombre, 
    E.Apellido, 
    D.Nombre AS Departamento
FROM Estudiante E
INNER JOIN Departamento D ON E.DepartamentoID = D.DepartamentoID;

SELECT 
    P.Nombre, 
    P.Apellido, 
    P.Especialidad,
    D.Nombre AS Departamento,
    P.Salario
FROM Profesor P
INNER JOIN Departamento D ON P.DepartamentoID = D.DepartamentoID;

SELECT 
    C.Nombre AS Curso,
    CR.Codigo,
    D.Nombre AS Departamento,
    CR.Creditos
FROM Curso CR
INNER JOIN Departamento D ON CR.DepartamentoID = D.DepartamentoID;

SELECT 
    E.Nombre AS Estudiante,
    C.Nombre AS Curso,
    CL.Seccion,
    CL.Aula,
    CL.Horario
FROM Inscripcion I
INNER JOIN Estudiante E ON I.EstudianteID = E.EstudianteID
INNER JOIN Clase CL ON I.ClaseID = CL.ClaseID
INNER JOIN Curso C ON CL.CursoID = C.CursoID;

SELECT 
    E.Nombre AS Estudiante,
    C.Nombre AS Curso,
    CA.NotaDefinitiva,
    CA.Observaciones
FROM Calificacion CA
INNER JOIN Inscripcion I ON CA.InscripcionID = I.InscripcionID
INNER JOIN Estudiante E ON I.EstudianteID = E.EstudianteID
INNER JOIN Clase CL ON I.ClaseID = CL.ClaseID
INNER JOIN Curso C ON CL.CursoID = C.CursoID;

SELECT 
    E.Nombre AS Estudiante,
    E.Apellido,
    D.Nombre AS Departamento,
    I.Estado AS EstadoInscripcion
FROM Estudiante E
LEFT JOIN Inscripcion I ON E.EstudianteID = I.EstudianteID
INNER JOIN Departamento D ON E.DepartamentoID = D.DepartamentoID;

SELECT 
    P.Nombre AS Profesor,
    P.Apellido,
    D.Nombre AS Departamento,
    C.Nombre AS Curso
FROM Profesor P
LEFT JOIN Clase CL ON P.ProfesorID = CL.ProfesorID
LEFT JOIN Curso C ON CL.CursoID = C.CursoID
INNER JOIN Departamento D ON P.DepartamentoID = D.DepartamentoID;

SELECT 
    E.Nombre AS Estudiante,
    E.Apellido,
    COUNT(I.InscripcionID) AS CursosInscritos,
    AVG(CA.NotaDefinitiva) AS PromedioGeneral
FROM Estudiante E
LEFT JOIN Inscripcion I ON E.EstudianteID = I.EstudianteID
LEFT JOIN Calificacion CA ON I.InscripcionID = CA.InscripcionID
GROUP BY E.EstudianteID, E.Nombre, E.Apellido;

SELECT 
    D.Nombre AS Departamento,
    COUNT(E.EstudianteID) AS TotalEstudiantes,
    COUNT(P.ProfesorID) AS TotalProfesores,
    COUNT(CR.CursoID) AS TotalCursos
FROM Departamento D
LEFT JOIN Estudiante E ON D.DepartamentoID = E.DepartamentoID
LEFT JOIN Profesor P ON D.DepartamentoID = P.DepartamentoID
LEFT JOIN Curso CR ON D.DepartamentoID = CR.DepartamentoID
GROUP BY D.DepartamentoID, D.Nombre;

SELECT 
    CR.Nombre AS Curso,
    CR.Codigo,
    COUNT(DISTINCT I.EstudianteID) AS EstudiantesInscritos,
    AVG(CA.NotaDefinitiva) AS PromedioCurso
FROM Curso CR
LEFT JOIN Clase CL ON CR.CursoID = CL.CursoID
LEFT JOIN Inscripcion I ON CL.ClaseID = I.ClaseID
LEFT JOIN Calificacion CA ON I.InscripcionID = CA.InscripcionID
GROUP BY CR.CursoID, CR.Nombre, CR.Codigo;

SELECT 
    CL.Aula,
    CL.Horario,
    C.Nombre AS Curso,
    CONCAT(P.Nombre, ' ', P.Apellido) AS Profesor,
    COUNT(I.EstudianteID) AS EstudiantesInscritos
FROM Clase CL
INNER JOIN Curso C ON CL.CursoID = C.CursoID
INNER JOIN Profesor P ON CL.ProfesorID = P.ProfesorID
LEFT JOIN Inscripcion I ON CL.ClaseID = I.ClaseID
GROUP BY CL.ClaseID, CL.Aula, CL.Horario, C.Nombre, P.Nombre, P.Apellido;

SELECT 
    D.Nombre AS Departamento,
    AVG(CA.NotaDefinitiva) AS PromedioCalificaciones,
    MIN(CA.NotaDefinitiva) AS NotaMinima,
    MAX(CA.NotaDefinitiva) AS NotaMaxima
FROM Departamento D
INNER JOIN Estudiante E ON D.DepartamentoID = E.DepartamentoID
INNER JOIN Inscripcion I ON E.EstudianteID = I.EstudianteID
INNER JOIN Calificacion CA ON I.InscripcionID = CA.InscripcionID
GROUP BY D.DepartamentoID, D.Nombre;
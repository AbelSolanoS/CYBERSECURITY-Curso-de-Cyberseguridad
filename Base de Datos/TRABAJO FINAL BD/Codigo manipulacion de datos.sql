USE sistema_academico;

INSERT INTO Departamento (Nombre, Ubicacion, Telefono, Email) VALUES
('Derecho', 'Edificio G, Piso 2', '809-555-0107', 'derecho@universidad.edu'),
('Arquitectura', 'Edificio H, Piso 3', '809-555-0108', 'arquitectura@universidad.edu');

INSERT INTO Estudiante (Cedula, Nombre, Apellido, FechaNacimiento, Genero, Direccion, Telefono, Email, DepartamentoID) VALUES
('001-5555555-9', 'Sofía', 'Reyes', '2002-04-22', 'F', 'Calle Sol #34', '809-555-1009', 'sofia.reyes@est.edu', 7),
('001-6666666-0', 'Daniel', 'Mendoza', '2001-06-15', 'M', 'Av. Libertad #56', '809-555-1010', 'daniel.mendoza@est.edu', 8);

INSERT INTO Profesor (Cedula, Nombre, Apellido, Especialidad, Titulo, Telefono, Email, DepartamentoID, FechaContratacion, Salario) VALUES
('002-7777777-7', 'Isabel', 'Morales', 'Derecho Civil', 'Ph.D. en Derecho', '809-555-2007', 'isabel.morales@prof.edu', 7, '2020-02-15', 72000.00),
('002-8888888-8', 'Rafael', 'Ortega', 'Diseño Arquitectónico', 'M.Arch.', '809-555-2008', 'rafael.ortega@prof.edu', 8, '2021-07-01', 70000.00);

INSERT INTO Curso (Codigo, Nombre, Descripcion, Creditos, HorasSemanales, Prerequisito, DepartamentoID) VALUES
('DER-101', 'Introducción al Derecho', 'Fundamentos del sistema jurídico', 3, 4, NULL, 7),
('ARQ-101', 'Dibujo Arquitectónico', 'Técnicas básicas de dibujo arquitectónico', 3, 5, NULL, 8);

UPDATE Estudiante 
SET Direccion = 'Av. Juan Pablo Duarte #123', 
    Telefono = '809-555-1111'
WHERE EstudianteID = 1;

UPDATE Profesor 
SET Salario = Salario * 1.10
WHERE DepartamentoID = 1;

UPDATE Calificacion 
SET NotaDefinitiva = NotaDefinitiva + 2
WHERE NotaDefinitiva BETWEEN 60 AND 69;

UPDATE Inscripcion 
SET Estado = 'Aprobado'
WHERE EstudianteID = 1 AND Estado = 'Inscrito';

DELETE FROM Inscripcion 
WHERE EstudianteID = 8 AND Estado = 'Inscrito';

DELETE FROM Calificacion 
WHERE NotaDefinitiva < 60;

UPDATE Estudiante 
SET Estado = 'Retirado'
WHERE EstudianteID NOT IN (SELECT DISTINCT EstudianteID FROM Inscripcion);

SELECT 
    E.Nombre,
    E.Apellido,
    I.Estado,
    C.NotaDefinitiva
FROM Estudiante E
LEFT JOIN Inscripcion I ON E.EstudianteID = I.EstudianteID
LEFT JOIN Calificacion C ON I.InscripcionID = C.InscripcionID
WHERE E.EstudianteID = 1;

SELECT 
    P.Nombre,
    P.Apellido,
    P.Salario,
    P.Salario * 12 AS SalarioAnual
FROM Profesor P
WHERE P.ProfesorID = 1;

SELECT 
    CR.Nombre AS Curso,
    CL.Seccion,
    COUNT(I.EstudianteID) AS TotalInscritos
FROM Curso CR
LEFT JOIN Clase CL ON CR.CursoID = CL.CursoID
LEFT JOIN Inscripcion I ON CL.ClaseID = I.ClaseID
GROUP BY CR.CursoID, CR.Nombre, CL.Seccion;

START TRANSACTION;

INSERT INTO Inscripcion (EstudianteID, ClaseID, FechaInscripcion, Estado) 
VALUES (9, 1, CURDATE(), 'Inscrito');

INSERT INTO Calificacion (InscripcionID, NotaParcial1, NotaParcial2, NotaFinal, NotaDefinitiva)
VALUES (LAST_INSERT_ID(), 80.0, 85.0, 82.0, 82.3);

COMMIT;

CREATE VIEW VistaEstudiantesActivos AS
SELECT 
    E.EstudianteID,
    CONCAT(E.Nombre, ' ', E.Apellido) AS Estudiante,
    E.Cedula,
    D.Nombre AS Departamento,
    E.Estado
FROM Estudiante E
INNER JOIN Departamento D ON E.DepartamentoID = D.DepartamentoID
WHERE E.Estado = 'Activo';

CREATE VIEW VistaProfesoresDepartamento AS
SELECT 
    P.ProfesorID,
    CONCAT(P.Nombre, ' ', P.Apellido) AS Profesor,
    P.Especialidad,
    D.Nombre AS Departamento,
    P.Salario
FROM Profesor P
INNER JOIN Departamento D ON P.DepartamentoID = D.DepartamentoID;

CREATE VIEW VistaPromediosEstudiantes AS
SELECT 
    E.EstudianteID,
    CONCAT(E.Nombre, ' ', E.Apellido) AS Estudiante,
    D.Nombre AS Departamento,
    COUNT(C.CalificacionID) AS TotalCalificaciones,
    AVG(C.NotaDefinitiva) AS PromedioGeneral
FROM Estudiante E
LEFT JOIN Inscripcion I ON E.EstudianteID = I.EstudianteID
LEFT JOIN Calificacion C ON I.InscripcionID = C.InscripcionID
INNER JOIN Departamento D ON E.DepartamentoID = D.DepartamentoID
GROUP BY E.EstudianteID, E.Nombre, E.Apellido, D.Nombre;
USE sistema_academico;

SELECT * FROM Departamento;
SELECT * FROM Estudiante LIMIT 10;
SELECT * FROM Profesor;
SELECT * FROM Curso;
SELECT * FROM Clase;
SELECT * FROM Inscripcion;
SELECT * FROM Calificacion;

SELECT Nombre, Apellido, FechaNacimiento FROM Estudiante;
SELECT Nombre, Especialidad, Salario FROM Profesor;

SELECT * FROM Estudiante WHERE DepartamentoID = 1;
SELECT * FROM Profesor WHERE Salario > 70000;
SELECT * FROM Curso WHERE Creditos >= 4;
SELECT * FROM Inscripcion WHERE Estado = 'Inscrito';

SELECT * FROM Estudiante WHERE Apellido LIKE 'G%';
SELECT * FROM Curso WHERE Nombre LIKE '%Programación%';
SELECT * FROM Profesor WHERE Email LIKE '%@prof.edu';

SELECT * FROM Estudiante ORDER BY FechaNacimiento ASC;
SELECT * FROM Profesor ORDER BY Salario DESC;
SELECT * FROM Curso ORDER BY Creditos DESC, Nombre ASC;

SELECT COUNT(*) AS TotalEstudiantes FROM Estudiante;
SELECT COUNT(*) AS TotalProfesores FROM Profesor;
SELECT COUNT(*) AS TotalCursos FROM Curso;
SELECT COUNT(*) AS TotalClases FROM Clase;

SELECT DepartamentoID, COUNT(*) AS CantidadEstudiantes 
FROM Estudiante 
GROUP BY DepartamentoID;

SELECT DepartamentoID, AVG(Salario) AS SalarioPromedio 
FROM Profesor 
GROUP BY DepartamentoID;

SELECT CursoID, COUNT(*) AS Inscripciones 
FROM Inscripcion 
GROUP BY CursoID;
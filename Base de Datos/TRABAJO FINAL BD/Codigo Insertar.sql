USE sistema_academico;

INSERT INTO Departamento (Nombre, Ubicacion, Telefono, Email) VALUES
('Ingeniería de Sistemas', 'Edificio A, Piso 3', '809-555-0101', 'sistemas@universidad.edu'),
('Matemáticas', 'Edificio B, Piso 2', '809-555-0102', 'matematicas@universidad.edu'),
('Humanidades', 'Edificio C, Piso 1', '809-555-0103', 'humanidades@universidad.edu'),
('Ciencias Naturales', 'Edificio D, Piso 2', '809-555-0104', 'ciencias@universidad.edu'),
('Economía', 'Edificio E, Piso 3', '809-555-0105', 'economia@universidad.edu'),
('Medicina', 'Edificio F, Piso 4', '809-555-0106', 'medicina@universidad.edu');

INSERT INTO Estudiante (Cedula, Nombre, Apellido, FechaNacimiento, Genero, Direccion, Telefono, Email, DepartamentoID) VALUES
('001-1234567-8', 'María', 'Rodríguez', '2000-05-15', 'F', 'Calle Principal #123', '809-555-1001', 'maria.rodriguez@est.edu', 1),
('001-9876543-2', 'Carlos', 'Martínez', '2001-03-20', 'M', 'Av. Independencia #45', '809-555-1002', 'carlos.martinez@est.edu', 1),
('001-4567891-3', 'Ana', 'García', '2002-08-10', 'F', 'Calle 5 #67', '809-555-1003', 'ana.garcia@est.edu', 2),
('001-6543219-4', 'José', 'Pérez', '2000-11-25', 'M', 'Sector Los Prados', '809-555-1004', 'jose.perez@est.edu', 3),
('001-7891234-5', 'Laura', 'Sánchez', '2001-01-30', 'F', 'Res. Paraíso', '809-555-1005', 'laura.sanchez@est.edu', 4),
('001-3219876-6', 'Miguel', 'Fernández', '2002-07-12', 'M', 'Av. Bolívar #89', '809-555-1006', 'miguel.fernandez@est.edu', 1),
('001-1472583-7', 'Patricia', 'López', '2000-09-18', 'F', 'Calle Luna #12', '809-555-1007', 'patricia.lopez@est.edu', 5),
('001-9638527-8', 'Roberto', 'González', '2001-12-05', 'M', 'Sector Bella Vista', '809-555-1008', 'roberto.gonzalez@est.edu', 6);

INSERT INTO Profesor (Cedula, Nombre, Apellido, Especialidad, Titulo, Telefono, Email, DepartamentoID, FechaContratacion, Salario) VALUES
('002-1111111-1', 'Juan', 'Ramírez', 'Base de Datos', 'Ph.D. en Ciencias de la Computación', '809-555-2001', 'juan.ramirez@prof.edu', 1, '2015-08-01', 75000.00),
('002-2222222-2', 'María', 'Hernández', 'Análisis Matemático', 'M.Sc. en Matemáticas', '809-555-2002', 'maria.hernandez@prof.edu', 2, '2018-01-15', 65000.00),
('002-3333333-3', 'Pedro', 'Alvarez', 'Literatura Española', 'Ph.D. en Literatura', '809-555-2003', 'pedro.alvarez@prof.edu', 3, '2016-03-10', 62000.00),
('002-4444444-4', 'Carmen', 'Torres', 'Biología Molecular', 'Ph.D. en Biología', '809-555-2004', 'carmen.torres@prof.edu', 4, '2019-08-20', 68000.00),
('002-5555555-5', 'Luis', 'Díaz', 'Microeconomía', 'M.Sc. en Economía', '809-555-2005', 'luis.diaz@prof.edu', 5, '2017-05-05', 63000.00),
('002-6666666-6', 'Elena', 'Castro', 'Anatomía Humana', 'Ph.D. en Medicina', '809-555-2006', 'elena.castro@prof.edu', 6, '2014-10-30', 80000.00);

INSERT INTO Curso (Codigo, Nombre, Descripcion, Creditos, HorasSemanales, Prerequisito, DepartamentoID) VALUES
('SIS-101', 'Introducción a la Programación', 'Fundamentos de programación usando Python', 3, 4, NULL, 1),
('SIS-102', 'Base de Datos I', 'Diseño e implementación de bases de datos relacionales', 4, 5, 'SIS-101', 1),
('MAT-101', 'Cálculo I', 'Cálculo diferencial e integral', 4, 5, NULL, 2),
('MAT-102', 'Álgebra Lineal', 'Vectores, matrices y sistemas de ecuaciones', 3, 4, NULL, 2),
('HUM-101', 'Literatura Universal', 'Estudio de obras literarias fundamentales', 2, 3, NULL, 3),
('BIO-101', 'Biología General', 'Principios básicos de la biología', 3, 4, NULL, 4),
('ECO-101', 'Introducción a la Economía', 'Conceptos básicos de micro y macroeconomía', 3, 4, NULL, 5),
('MED-101', 'Anatomía I', 'Estudio del cuerpo humano', 4, 6, NULL, 6),
('SIS-201', 'Desarrollo Web', 'HTML, CSS y JavaScript', 4, 5, 'SIS-101', 1),
('SIS-202', 'Redes de Computadoras', 'Fundamentos de redes y comunicaciones', 4, 5, 'SIS-101', 1);

INSERT INTO Clase (CursoID, ProfesorID, Aula, Horario, CupoMaximo, Seccion, Año, Semestre) VALUES
(1, 1, 'A-301', 'Lunes y Miércoles 8:00-10:00', 25, '01', 2024, 'I'),
(1, 1, 'A-302', 'Martes y Jueves 14:00-16:00', 25, '02', 2024, 'I'),
(2, 1, 'A-303', 'Lunes y Miércoles 10:00-12:00', 30, '01', 2024, 'I'),
(3, 2, 'B-201', 'Lunes, Miércoles y Viernes 8:00-9:30', 35, '01', 2024, 'I'),
(4, 2, 'B-202', 'Martes y Jueves 10:00-12:00', 30, '01', 2024, 'I'),
(5, 3, 'C-101', 'Lunes 14:00-17:00', 20, '01', 2024, 'I'),
(6, 4, 'D-201', 'Martes y Jueves 8:00-10:00', 25, '01', 2024, 'I'),
(7, 5, 'E-301', 'Miércoles 16:00-19:00', 30, '01', 2024, 'I'),
(8, 6, 'F-401', 'Lunes y Miércoles 13:00-15:00', 20, '01', 2024, 'I'),
(9, 1, 'A-304', 'Martes y Jueves 16:00-18:00', 25, '01', 2024, 'I');

INSERT INTO Inscripcion (EstudianteID, ClaseID, FechaInscripcion, Estado) VALUES
(1, 1, '2024-01-15', 'Inscrito'),
(1, 3, '2024-01-16', 'Inscrito'),
(1, 4, '2024-01-15', 'Inscrito'),
(2, 1, '2024-01-15', 'Inscrito'),
(2, 2, '2024-01-16', 'Inscrito'),
(3, 3, '2024-01-17', 'Inscrito'),
(3, 5, '2024-01-15', 'Inscrito'),
(4, 6, '2024-01-16', 'Inscrito'),
(4, 7, '2024-01-17', 'Inscrito'),
(5, 8, '2024-01-15', 'Inscrito'),
(5, 9, '2024-01-16', 'Inscrito'),
(6, 1, '2024-01-17', 'Inscrito'),
(6, 10, '2024-01-15', 'Inscrito'),
(7, 2, '2024-01-16', 'Inscrito'),
(7, 4, '2024-01-17', 'Inscrito'),
(8, 5, '2024-01-15', 'Inscrito'),
(8, 6, '2024-01-16', 'Inscrito');

INSERT INTO Calificacion (InscripcionID, NotaParcial1, NotaParcial2, NotaFinal, NotaDefinitiva, Observaciones) VALUES
(1, 85.5, 90.0, 88.0, 87.8, 'Buen desempeño'),
(2, 92.0, 88.5, 95.0, 91.8, 'Excelente estudiante'),
(3, 78.0, 82.5, 80.0, 80.2, 'Necesita mejorar en prácticas'),
(4, 65.0, 70.0, 68.0, 67.7, 'Riesgo de reprobar'),
(5, 95.0, 92.0, 97.0, 94.7, 'Sobresaliente'),
(6, 88.0, 85.0, 90.0, 87.7, 'Buen trabajo'),
(7, 72.0, 75.0, 70.0, 72.3, 'Aprobado por poco'),
(8, 60.0, 65.0, 62.0, 62.3, 'Necesita refuerzo'),
(9, 82.0, 85.0, 83.0, 83.3, 'Desempeño regular'),
(10, 91.0, 89.0, 93.0, 91.0, 'Muy buen trabajo');

CREATE DATABASE colegio;
USE colegio;

CREATE TABLE estudiantes (
    id_estudiante INT PRIMARY KEY AUTO_INCREMENT,
    cedula VARCHAR(20) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE,
    genero CHAR(1),
    direccion TEXT,
    telefono VARCHAR(15),
    email VARCHAR(100)
);

CREATE TABLE cursos (
    id_curso INT PRIMARY KEY AUTO_INCREMENT,
    codigo VARCHAR(10) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    creditos INT DEFAULT 1,
    grado VARCHAR(10),
    profesor VARCHAR(100)
);

CREATE TABLE matriculas (
    id_matricula INT PRIMARY KEY AUTO_INCREMENT,
    id_estudiante INT,
    id_curso INT,
    fecha_matricula DATE DEFAULT (CURDATE()),
    periodo_academico VARCHAR(20),
    calificacion DECIMAL(3,2),
    estado ENUM('Activo', 'Retirado', 'Aprobado', 'Reprobado') DEFAULT 'Activo',
    FOREIGN KEY (id_estudiante) REFERENCES estudiantes(id_estudiante) ON DELETE CASCADE,
    FOREIGN KEY (id_curso) REFERENCES cursos(id_curso) ON DELETE CASCADE,
    UNIQUE KEY unique_matricula (id_estudiante, id_curso, periodo_academico)
);

INSERT INTO estudiantes (cedula, nombre, apellido, fecha_nacimiento, genero, direccion, telefono, email) VALUES
('001-1234567-8', 'María', 'González', '2008-05-15', 'F', 'Calle Principal #123', '809-555-0101', 'maria.gonzalez@email.com'),
('002-9876543-2', 'Carlos', 'Rodríguez', '2007-11-20', 'M', 'Av. Independencia #45', '809-555-0202', 'carlos.rodriguez@email.com'),
('003-4567891-5', 'Ana', 'Martínez', '2009-03-10', 'F', 'Calle 5 #67', '809-555-0303', 'ana.martinez@email.com'),
('004-6543219-8', 'José', 'Pérez', '2008-08-25', 'M', 'Sector Los Prados', '809-555-0404', 'jose.perez@email.com'),
('005-7891234-6', 'Laura', 'Sánchez', '2009-01-30', 'F', 'Res. Paraíso', '809-555-0505', 'laura.sanchez@email.com');

INSERT INTO cursos (codigo, nombre, descripcion, creditos, grado, profesor) VALUES
('MAT-101', 'Matemáticas Básicas', 'Fundamentos de álgebra y aritmética', 3, '7mo', 'Prof. Ramón Díaz'),
('ESP-101', 'Español', 'Gramática y literatura española', 3, '7mo', 'Prof. Ana García'),
('CIE-101', 'Ciencias Naturales', 'Biología y física básica', 2, '7mo', 'Prof. Carlos Méndez'),
('ING-101', 'Inglés Básico', 'Vocabulario y gramática inglesa', 2, '7mo', 'Prof. Sarah Smith'),
('HIS-101', 'Historia Dominicana', 'Historia de la República Dominicana', 2, '8vo', 'Prof. Miguel Fernández'),
('ART-101', 'Educación Artística', 'Arte y música', 1, '7mo', 'Prof. Elena Romero');

INSERT INTO matriculas (id_estudiante, id_curso, fecha_matricula, periodo_academico, calificacion, estado) VALUES
(1, 1, '2024-08-01', '2024-2025', 92.5, 'Aprobado'),
(1, 2, '2024-08-01', '2024-2025', 88.0, 'Aprobado'),
(1, 3, '2024-08-01', '2024-2025', 95.0, 'Aprobado'),
(2, 1, '2024-08-02', '2024-2025', 85.5, 'Aprobado'),
(2, 4, '2024-08-02', '2024-2025', 90.0, 'Aprobado'),
(3, 2, '2024-08-01', '2024-2025', NULL, 'Activo'),
(3, 3, '2024-08-01', '2024-2025', NULL, 'Activo'),
(3, 6, '2024-08-01', '2024-2025', NULL, 'Activo'),
(4, 1, '2024-08-03', '2024-2025', 78.0, 'Reprobado'),
(4, 4, '2024-08-03', '2024-2025', 82.5, 'Aprobado'),
(5, 5, '2024-08-02', '2024-2025', NULL, 'Activo'),
(5, 6, '2024-08-02', '2024-2025', NULL, 'Activo');

SELECT 
    e.cedula,
    CONCAT(e.nombre, ' ', e.apellido) AS estudiante,
    COUNT(m.id_curso) AS cursos_matriculados,
    AVG(m.calificacion) AS promedio_general
FROM estudiantes e
LEFT JOIN matriculas m ON e.id_estudiante = m.id_estudiante
GROUP BY e.id_estudiante
ORDER BY promedio_general DESC;

SELECT 
    c.codigo,
    c.nombre AS curso,
    c.profesor,
    c.grado,
    COUNT(m.id_estudiante) AS estudiantes_inscritos
FROM cursos c
LEFT JOIN matriculas m ON c.id_curso = m.id_curso AND m.estado = 'Activo'
GROUP BY c.id_curso
ORDER BY estudiantes_inscritos DESC;

SELECT 
    CONCAT(e.nombre, ' ', e.apellido) AS estudiante,
    c.nombre AS curso,
    m.calificacion,
    CASE 
        WHEN m.calificacion >= 90 THEN 'Excelente'
        WHEN m.calificacion >= 80 THEN 'Bueno'
        WHEN m.calificacion >= 70 THEN 'Aprobado'
        WHEN m.calificacion < 70 THEN 'Reprobado'
        ELSE 'Sin calificar'
    END AS nivel_desempeño
FROM estudiantes e
JOIN matriculas m ON e.id_estudiante = m.id_estudiante
JOIN cursos c ON m.id_curso = c.id_curso
WHERE m.calificacion IS NOT NULL
ORDER BY m.calificacion DESC;

SELECT 
    c.grado,
    c.nombre AS curso,
    COUNT(DISTINCT m.id_estudiante) AS total_estudiantes,
    AVG(m.calificacion) AS promedio_grado
FROM cursos c
JOIN matriculas m ON c.id_curso = m.id_curso
WHERE m.calificacion IS NOT NULL
GROUP BY c.grado, c.id_curso
ORDER BY c.grado, promedio_grado DESC;

SELECT 
    CONCAT(e.nombre, ' ', e.apellido) AS estudiante,
    e.fecha_nacimiento,
    TIMESTAMPDIFF(YEAR, e.fecha_nacimiento, CURDATE()) AS edad,
    c.nombre AS curso_matriculado
FROM estudiantes e
JOIN matriculas m ON e.id_estudiante = m.id_estudiante
JOIN cursos c ON m.id_curso = c.id_curso
WHERE m.estado = 'Activo'
ORDER BY edad;

UPDATE matriculas 
SET calificacion = 85.0, estado = 'Aprobado'
WHERE id_estudiante = 3 AND id_curso = 2 AND periodo_academico = '2024-2025';

SELECT 
    c.nombre AS curso,
    COUNT(CASE WHEN m.estado = 'Aprobado' THEN 1 END) AS aprobados,
    COUNT(CASE WHEN m.estado = 'Reprobado' THEN 1 END) AS reprobados,
    COUNT(CASE WHEN m.estado = 'Activo' THEN 1 END) AS en_progreso
FROM cursos c
LEFT JOIN matriculas m ON c.id_curso = m.id_curso
GROUP BY c.id_curso;

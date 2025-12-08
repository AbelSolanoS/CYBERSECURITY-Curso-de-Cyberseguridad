CREATE DATABASE IF NOT EXISTS sistema_academico;
USE sistema_academico;

CREATE TABLE Departamento (
    DepartamentoID INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(100) NOT NULL,
    Ubicacion VARCHAR(100),
    Telefono VARCHAR(15),
    Email VARCHAR(100),
    FechaCreacion DATE DEFAULT (CURDATE())
) ENGINE=InnoDB;

CREATE TABLE Estudiante (
    EstudianteID INT PRIMARY KEY AUTO_INCREMENT,
    Cedula VARCHAR(20) UNIQUE NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
    Apellido VARCHAR(100) NOT NULL,
    FechaNacimiento DATE NOT NULL,
    Genero ENUM('M', 'F', 'O') DEFAULT 'O',
    Direccion TEXT,
    Telefono VARCHAR(15),
    Email VARCHAR(100) UNIQUE NOT NULL,
    DepartamentoID INT NOT NULL,
    FechaRegistro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Estado ENUM('Activo', 'Inactivo', 'Graduado', 'Retirado') DEFAULT 'Activo',
    FOREIGN KEY (DepartamentoID) REFERENCES Departamento(DepartamentoID)
) ENGINE=InnoDB;

CREATE TABLE Profesor (
    ProfesorID INT PRIMARY KEY AUTO_INCREMENT,
    Cedula VARCHAR(20) UNIQUE NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
    Apellido VARCHAR(100) NOT NULL,
    Especialidad VARCHAR(100),
    Titulo VARCHAR(100),
    Telefono VARCHAR(15),
    Email VARCHAR(100) UNIQUE NOT NULL,
    DepartamentoID INT NOT NULL,
    FechaContratacion DATE,
    Salario DECIMAL(10,2),
    Estado ENUM('Activo', 'Inactivo', 'Jubilado') DEFAULT 'Activo',
    FOREIGN KEY (DepartamentoID) REFERENCES Departamento(DepartamentoID)
) ENGINE=InnoDB;

CREATE TABLE Curso (
    CursoID INT PRIMARY KEY AUTO_INCREMENT,
    Codigo VARCHAR(20) UNIQUE NOT NULL,
    Nombre VARCHAR(150) NOT NULL,
    Descripcion TEXT,
    Creditos INT NOT NULL CHECK (Creditos BETWEEN 1 AND 6),
    HorasSemanales INT DEFAULT 3,
    Prerequisito VARCHAR(100),
    DepartamentoID INT NOT NULL,
    FOREIGN KEY (DepartamentoID) REFERENCES Departamento(DepartamentoID)
) ENGINE=InnoDB;

CREATE TABLE Clase (
    ClaseID INT PRIMARY KEY AUTO_INCREMENT,
    CursoID INT NOT NULL,
    ProfesorID INT NOT NULL,
    Aula VARCHAR(20),
    Horario VARCHAR(50),
    CupoMaximo INT DEFAULT 30,
    Seccion VARCHAR(10),
    Año INT NOT NULL,
    Semestre ENUM('I', 'II', 'Verano') NOT NULL,
    Estado ENUM('Abierta', 'Cerrada', 'En curso', 'Finalizada') DEFAULT 'Abierta',
    FOREIGN KEY (CursoID) REFERENCES Curso(CursoID),
    FOREIGN KEY (ProfesorID) REFERENCES Profesor(ProfesorID),
    UNIQUE KEY unique_clase (CursoID, Seccion, Año, Semestre)
) ENGINE=InnoDB;

CREATE TABLE Inscripcion (
    InscripcionID INT PRIMARY KEY AUTO_INCREMENT,
    EstudianteID INT NOT NULL,
    ClaseID INT NOT NULL,
    FechaInscripcion DATE NOT NULL DEFAULT (CURDATE()),
    Estado ENUM('Inscrito', 'Retirado', 'Aprobado', 'Reprobado') DEFAULT 'Inscrito',
    FOREIGN KEY (EstudianteID) REFERENCES Estudiante(EstudianteID),
    FOREIGN KEY (ClaseID) REFERENCES Clase(ClaseID),
    UNIQUE KEY unique_inscripcion (EstudianteID, ClaseID)
) ENGINE=InnoDB;

CREATE TABLE Calificacion (
    CalificacionID INT PRIMARY KEY AUTO_INCREMENT,
    InscripcionID INT NOT NULL,
    NotaParcial1 DECIMAL(4,2) CHECK (NotaParcial1 BETWEEN 0 AND 100),
    NotaParcial2 DECIMAL(4,2) CHECK (NotaParcial2 BETWEEN 0 AND 100),
    NotaFinal DECIMAL(4,2) CHECK (NotaFinal BETWEEN 0 AND 100),
    NotaDefinitiva DECIMAL(4,2) CHECK (NotaDefinitiva BETWEEN 0 AND 100),
    Observaciones TEXT,
    FechaRegistro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (InscripcionID) REFERENCES Inscripcion(InscripcionID)
) ENGINE=InnoDB;

CREATE TABLE Auditoria (
    AuditoriaID INT PRIMARY KEY AUTO_INCREMENT,
    TablaAfectada VARCHAR(50),
    Accion VARCHAR(20),
    RegistroID INT,
    Usuario VARCHAR(50),
    FechaCambio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    DatosAnteriores TEXT,
    DatosNuevos TEXT
) ENGINE=InnoDB;
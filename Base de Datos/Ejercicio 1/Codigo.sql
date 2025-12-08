
CREATE DATABASE biblioteca;
USE biblioteca;

CREATE TABLE autores (
    id_autor INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    nacionalidad VARCHAR(50),
    fecha_nacimiento DATE
);

CREATE TABLE libros (
    id_libro INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(200) NOT NULL,
    id_autor INT,
    año_publicacion INT,
    genero VARCHAR(50),
    FOREIGN KEY (id_autor) REFERENCES autores(id_autor) ON DELETE CASCADE
);

INSERT INTO autores (nombre, nacionalidad, fecha_nacimiento) VALUES
('Amilcar Abel Solano Santos', 'Dominicano', '1927-03-06'),
('Michael Jackson', 'USA', '1775-12-16'),
('Mario Vargas Llosa', 'Peruano', '1936-03-28');

INSERT INTO libros (titulo, id_autor, año_publicacion, genero) VALUES
('Avengers Endgame', 1, 1967, 'Realismo mágico'),
('La FE EN CRISTO', 1, 1985, 'Novela'),
('MARVEL', 2, 1813, 'Romance'),
('ARGONAUTAS', 3, 1963, 'Novela'),
('CALL OF DUTY', 3, 2000, 'Novela histórica');

SELECT libros.titulo, libros.año_publicacion, autores.nombre 
FROM libros 
INNER JOIN autores ON libros.id_autor = autores.id_autor;

SELECT autores.nombre, COUNT(libros.id_libro) AS total_libros
FROM autores 
LEFT JOIN libros ON autores.id_autor = libros.id_autor 
GROUP BY autores.id_autor;

SELECT * FROM libros WHERE año_publicacion > 1900 ORDER BY año_publicacion DESC;
```

CREATE DATABASE ventas;
USE ventas;

CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    cedula VARCHAR(13) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    ciudad VARCHAR(50),
    telefono VARCHAR(15)
);

CREATE TABLE productos (
    id_producto INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    categoria VARCHAR(50),
    precio DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0
);

CREATE TABLE facturas (
    id_factura INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT,
    fecha DATE NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

CREATE TABLE detalle_factura (
    id_detalle INT PRIMARY KEY AUTO_INCREMENT,
    id_factura INT,
    id_producto INT,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_factura) REFERENCES facturas(id_factura) ON DELETE CASCADE,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

INSERT INTO clientes (cedula, nombre, ciudad, telefono) VALUES
('001-1234567-8', 'María Rodríguez', 'Santo Domingo', '809-555-0101'),
('002-9876543-2', 'Carlos Martínez', 'Santiago', '809-555-0202'),
('003-4567891-5', 'Ana García', 'La Romana', '809-555-0303'),
('004-6543219-8', 'José Pérez', 'San Cristóbal', '809-555-0404');

INSERT INTO productos (nombre, categoria, precio, stock) VALUES
('Café Santo Domingo', 'Bebidas', 250.00, 100),
('Chocolate Cortés', 'Dulces', 180.50, 75),
('Ron Barceló Añejo', 'Licores', 850.00, 50),
('Mabí La Familia', 'Bebidas', 120.00, 120),
('Casabe Emanuel', 'Alimentos', 95.00, 200),
('Salami Induveca', 'Embutidos', 320.00, 80),
('Aceite Rica', 'Aceites', 210.00, 90),
('Mangú Jumbo', 'Conservas', 150.00, 60);

INSERT INTO facturas (id_cliente, fecha, total) VALUES
(1, '2024-10-15', 940.00),
(2, '2024-10-16', 510.00),
(3, '2024-10-16', 1200.50),
(1, '2024-10-17', 425.00);

INSERT INTO detalle_factura (id_factura, id_producto, cantidad, precio_unitario, subtotal) VALUES
(1, 1, 2, 250.00, 500.00),
(1, 3, 1, 850.00, 850.00),
(2, 4, 3, 120.00, 360.00),
(2, 8, 1, 150.00, 150.00),
(3, 2, 2, 180.50, 361.00),
(3, 6, 1, 320.00, 320.00),
(3, 7, 2, 210.00, 420.00),
(3, 5, 1, 95.00, 95.00),
(4, 1, 1, 250.00, 250.00),
(4, 5, 1, 95.00, 95.00),
(4, 8, 1, 150.00, 150.00);

SELECT 
    c.nombre AS cliente,
    f.fecha,
    f.total,
    COUNT(d.id_producto) AS productos_comprados
FROM facturas f
JOIN clientes c ON f.id_cliente = c.id_cliente
JOIN detalle_factura d ON f.id_factura = d.id_factura
GROUP BY f.id_factura
ORDER BY f.fecha DESC;

SELECT 
    p.nombre AS producto_dominicano,
    p.categoria,
    SUM(d.cantidad) AS total_vendido,
    SUM(d.subtotal) AS ingresos_totales
FROM productos p
JOIN detalle_factura d ON p.id_producto = d.id_producto
GROUP BY p.id_producto
ORDER BY ingresos_totales DESC;

SELECT 
    c.ciudad,
    COUNT(f.id_factura) AS facturas_emitidas,
    SUM(f.total) AS ventas_totales
FROM clientes c
LEFT JOIN facturas f ON c.id_cliente = f.id_cliente
GROUP BY c.ciudad;

SELECT 
    p.nombre AS producto,
    p.precio,
    p.stock,
    (SELECT COUNT(*) FROM detalle_factura df WHERE df.id_producto = p.id_producto) AS veces_comprado
FROM productos p
WHERE p.stock < 70
ORDER BY p.stock ASC;

UPDATE productos 
SET precio = precio * 1.10 
WHERE categoria = 'Bebidas' 
AND nombre LIKE '%Santo Domingo%';

SELECT 
    c.nombre AS cliente,
    p.nombre AS producto,
    d.cantidad,
    d.precio_unitario,
    f.fecha
FROM clientes c
JOIN facturas f ON c.id_cliente = f.id_cliente
JOIN detalle_factura d ON f.id_factura = d.id_factura
JOIN productos p ON d.id_producto = p.id_producto
WHERE c.ciudad = 'Santo Domingo'
AND f.fecha >= '2024-10-15'
ORDER BY f.fecha, c.nombre;

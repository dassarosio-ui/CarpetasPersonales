/* 
===============
PRE ENTREGA III
===============

Se cambiaron algunos nombres de tablas o sentencias con el fin de alienear 
con el diseño personal del estudiante. 
*/


--==CREAMOS LA BASE DE DATOS Y LA PONEMOS EN USO==--

CREATE DATABASE Ventas_Tech_DB; 

USE VENTAS_TECH_DB;

/*
==ESCRIBIMOS LAS DROP TABLE==
De esta manera, el script es repetible.
*/

DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS categorias;

/*
==CREAMOS LAS TABLAS==
El orden de estas tablas es de esta manera debido al diseño 3NF, donde la mayoria 
de tablas toman datos a otras tablas a traves de FK para mejor el flujo de informacion.
En busca de lograr un buen diseño y una agilidad para alterar los datos. 
*/

CREATE TABLE Categorias(
	IDCategoria INT PRIMARY KEY,
	NombreCategoria NVARCHAR(50) NOT NULL,
	Descripcion NVARCHAR(200));

CREATE TABLE Clientes(
	IDCliente INT PRIMARY KEY,
	NombreCliente NVARCHAR(50) NOT NULL,
	Email NVARCHAR(200),
	Ciudad NVARCHAR(50),
	FechaRegistro DATE NOT NULL);

CREATE TABLE Productos(
	IDProducto INT PRIMARY KEY,
	NombreProducto NVARCHAR(50) NOT NULL,
	IDCategoria INT FOREIGN KEY REFERENCES DBO.Categorias(IDCategoria),
	Precio DECIMAL(10,2) NOT NULL,
	Stock INT DEFAULT 0,
	Activo BIT DEFAULT 1);

CREATE TABLE Ventas(
	IDVenta INT PRIMARY KEY,
	IDCliente INT FOREIGN KEY REFERENCES DBO.Clientes(IDCliente),
	IDProducto INT FOREIGN KEY REFERENCES DBO.Productos(IDProducto),
	Cantidad INT NOT NULL,
	PrecioUnitario DECIMAL(10,2),
	FechaVenta DATE NOT NULL);


--==¡TABLAS CREADAS CON EXITO!==--


/*
==INGRESAMOS DATOS==
Copiamos los datos datos por el curso:
*/

--Categorias
INSERT INTO DBO.Categorias (IDCategoria, NombreCategoria, descripcion) VALUES
  (1, 'Computación',    'Laptops, PCs y monitores'),
  (2, 'Accesorios',     'Periféricos y complementos'),
  (3, 'Audio',          'Auriculares y parlantes'),
  (4, 'Almacenamiento', 'Discos y memorias');

--Clientes
INSERT INTO DBO.Clientes(IDCliente, NombreCliente, email, ciudad, FechaRegistro) VALUES
  (1, 'María López',  'maria@mail.com',  'Buenos Aires', '2024-01-05'),
  (2, 'Carlos Ruiz',  'carlos@mail.com', 'Córdoba',      '2024-01-10'),
  (3, 'Ana Gómez',    'ana@mail.com',    'Rosario',      '2024-02-01'),
  (4, 'Pedro Sanz',   'pedro@mail.com',  'Mendoza',      '2024-02-15'),
  (5, 'Laura Torres', 'laura@mail.com',  'Tucumán',      '2024-03-01');

--Productos
INSERT INTO DBO.Productos(IDProducto, NombreProducto, IDCategoria, Precio, Stock, Activo) VALUES
  (1, 'Laptop Pro 15',      1, 1200.00, 15, 1),
  (2, 'Mouse Inalámbrico',  2,   28.00, 80, 1),
  (3, 'Monitor 4K 27',      1,  450.00, 12, 1),
  (4, 'Auriculares BT Pro', 3,  120.00, 35, 1),
  (5, 'SSD Externo 1TB',    4,  130.00, 18, 1),
  (6, 'Teclado Mecánico',   2,   95.00, 40, 1);

 --Ventas
INSERT INTO ventas (IDVenta, IDCliente, IDProducto, Cantidad, PrecioUnitario, FechaVenta) VALUES
  ( 1, 1, 1, 2, 1200.00, '2024-03-05'),
  ( 2, 2, 2, 5,   28.00, '2024-03-06'),
  ( 3, 3, 3, 1,  450.00, '2024-03-07'),
  ( 4, 1, 4, 2,  120.00, '2024-03-08'),
  ( 5, 4, 5, 3,  130.00, '2024-03-10'),
  ( 6, 2, 6, 4,   95.00, '2024-03-11'),
  ( 7, 5, 1, 1, 1200.00, '2024-03-12'),
  ( 8, 3, 2, 8,   28.00, '2024-03-13'),
  ( 9, 4, 4, 1,  120.00, '2024-03-14'),
  (10, 5, 3, 2,  450.00, '2024-03-15');

--REVISAMOS PARA CONFIRMAR

SELECT * FROM categorias;   -- esperado: 4 filas
SELECT * FROM clientes;     -- esperado: 5 filas
SELECT * FROM productos;    -- esperado: 6 filas
SELECT * FROM ventas;       -- esperado: 10 filas

--FUNCIONO! 
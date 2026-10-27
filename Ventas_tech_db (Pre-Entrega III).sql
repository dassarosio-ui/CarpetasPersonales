/* 
===============
PRE ENTREGA III
===============
*/

/*
==CREAMOS LA BASE DE DATOS Y LA PONEMOS EN USO==
*/
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
*/

CREATE TABLE Categorias(
	IDCategoria INT PRIMARY KEY,
	Nombre_Categoria NVARCHAR(50) NOT NULL,
	Descripcion NVARCHAR(200));

CREATE TABLE Categorias(
	IDCategoria INT PRIMARY KEY,
	Nombre_Categoria NVARCHAR(50) NOT NULL,
	Descripcion NVARCHAR(200));
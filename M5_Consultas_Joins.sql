/*
===PRE-ENTREGA 5===

Ponemos en uso nuestra base de datos dado por el curso:
*/

USE VENTAS_TECH_DB;

/*
==Consulta 1 — Vista general del proyecto==

==Respuesta 1==
Nos solicita juntar con un INNER JOIN la siguiente informacion:
FECHA, IDCLIENTE, CIUDAD, CATEGORIA, CANTIDAD, PRECIO UNITARIO, TOTAL VENTA (Nombres de las columnas)*/

SELECT
	V.FechaVenta Fecha_venta,
	V.IDCliente ID_Cliente,
	C.Ciudad De_dónde_Es,
	P.NombreProducto Nombre_del_producto,
	CAT.NombreCategoria Categoria,
	v.Cantidad Cantidad,
	v.PrecioUnitario Precio_unidad,
	(v.Cantidad*v.PrecioUnitario) Total_de_venta
FROM DBO.Ventas V
 INNER JOIN DBO.Clientes C
	ON C.IDCliente = V.IDCliente
 INNER JOIN DBO.Productos P
	ON P.IDProducto = V.IDProducto
 INNER JOIN DBO.Categorias CAT
	ON CAT.IDCategoria = P.IDCategoria

/*HALLAZGO: 1) El %70 de los clientes compra dos o más productos.
			2) Solo el %30 de los clientes supero el gasto de $450. 
			3) El %20 de las compras son de Buenos Aires.*/
/*
==Consulta 2 — Clientes sin ventas==
Identificá clientes registrados que aún no han realizado ninguna compra. 
Mostrá su nombre, email y fecha de registro.

==Respuesta 2 ==
IDCLIENTE, NOMBRE, CIUDAD, EMAIL, FECHA REGISTRO*/

SELECT
	c.IDCliente 'ID del cliente',
	c.NombreCliente 'Nombre del cliente',
	c.Ciudad '¿Dónde vive?',
	c.Email 'Email',
	c.FechaRegistro '¿Cuándo se registro?'
FROM DBO.Clientes C
 LEFT JOIN DBO.Ventas V
	ON v.IDCliente = c.IDCliente
WHERE V.IDVenta IS NULL;

--HALLAZGO: El %100 de los clientes registrados realizaron compras. 

/*
==Consulta 3 — Productos sin ventas== 
Identificá productos del catálogo que no tienen ninguna venta registrada. 
Mostrá nombre del producto, categoría y precio.

==Respuesta 3==
NOMBREPRODUCTO, CATEGORIA, PRECIO*/

SELECT
	P.NombreProducto 'Nombre del producto',
	cat.NombreCategoria 'Categoría',
	P.Precio 'Precio'
FROM DBO.Productos P
	LEFT JOIN DBO.Ventas V
		ON P.IDProducto = V.IDProducto
	INNER JOIN DBO.Categorias CAT
		ON CAT.IDCategoria = P.IDCategoria
WHERE V.IDVenta IS NULL;

--HALLAZGO: No presentamos productos sin ventas.

/*
==Consulta 4 — Consolidado==
Crear una columna canal. Generamos el dato que el 10 de Marzo del 2024 (2024-03-10) se creo la pagina WEB.
Por ende, todas las ventas anterior a ese día fueron precensiales.

==Respuesta 4==*/
SELECT Canal, SUM(Total) AS Total_X_Canal
FROM (
    SELECT V.FechaVenta, (V.Cantidad * V.PrecioUnitario) AS Total, 'Online' AS Canal
    FROM DBO.Ventas v
	WHERE v.FechaVenta >'2024-03-10'

	UNION ALL
    
	SELECT V.FechaVenta, (V.Cantidad * V.PrecioUnitario) AS Total, 'Presencial' AS Canal
    FROM DBO.Ventas V 
	WHERE v.FechaVenta <= '2024-03-10'
	) 
AS Consolidado
GROUP BY Canal;

/*HALLAZGO: Desde que se lanzo la página (fecha supuesta). 
El canal Online generó 2.824, cerca del 44% de la facturación del período.
Mientras que el canal Presencial, que operó solo hasta el 10/03, facturó 3.620.*/

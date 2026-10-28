/*
===PRE-ENTREGA IV==

INTRUCCIONES:

Sobre la base de datos Ventas_Tech_DB creada en M3, escribí las 
siguientes consultas en un archivo llamado "m4_consultas_negocio.sql". 
Trabajamos solo sobre la tabla ventas (recordá que tiene id_cliente,
id_producto, cantidad, precio_unitario y fecha_venta). Los nombres 
de productos y clientes los vas a poder traer cruzando tablas con 
JOIN en el Módulo 5; por ahora trabajamos con los IDs.

==Consulta 1==
Resumen ejecutivo mensual: 
Total facturado, cantidad de pedidos y ticket promedio, agrupados por mes. 
Calculá el total como cantidad * precio_unitario. 
Usá alias descriptivos en español y agrupá por mes con MONTH(fecha_venta).

==Respuesta==
Total facturado, cantidad pedidos y ticker promedio. */

SELECT  
	MONTH(FechaVenta) AS Mes,
	CAST(SUM(PrecioUnitario*Cantidad) AS INT) AS Total_Facturado,
	COUNT(*) AS Cantidad_de_pedidos,
	SUM (Cantidad) AS Total_productos_vendidos, --Lo voy a utilizar para analizar al final.
	CAST (AVG(PrecioUnitario) AS INT) AS Ticket_promedio
FROM 
	DBO.Ventas
GROUP BY
	MONTH(FechaVenta)

--Utilizamos el CAST ya que devolvia un número con muchos ceros decimales

/*
==Consulta 2==
Ranking de productos: Top 5 de id_producto por total facturado, 
mostrando las unidades vendidas (SUM(cantidad)) y el total generado. 
Usá GROUP BY id_producto, ORDER BY y TOP 5.

==Respuesta==*/
SELECT
	TOP (5) IDProducto, SUM(cantidad) as Unidades_Vendidas, 
	CAST(SUM(PrecioUnitario*Cantidad) AS INT) AS Total_Facturado
FROM 
	DBO.Ventas
GROUP BY IDProducto
ORDER BY Total_Facturado DESC;

/*
==Consulta 3==
Clientes recurrentes: id_cliente que hayan realizado más de un pedido, 
mostrando la cantidad de pedidos y el total gastado. 
Usá GROUP BY id_cliente y HAVING COUNT(*) > 1.

==Respuesta==*/

SELECT 
	IDCliente AS ID_del_Cliente,
	SUM(Cantidad) AS Cuanto_compro,
	CAST(SUM(PrecioUnitario*Cantidad) AS INT) AS Total_Gastado
FROM 
	DBO.Ventas
GROUP BY IDCliente
HAVING COUNT (*) > 1
ORDER BY Total_Gastado DESC;

/*
==Consulta 4==
Meses por encima/por debajo del promedio: Total facturado por mes, 
con una columna adicional que etiquete con CASE WHEN si ese mes 
quedó 'Por encima' o 'Por debajo' del promedio mensual general.

==Respuesta==*/

SELECT
	MONTH(FechaVenta) AS Mes,
		CASE
		WHEN SUM(PrecioUnitario*Cantidad) < (AVG(PrecioUnitario*Cantidad)) THEN 'Por debajo'
		WHEN SUM(PrecioUnitario*Cantidad) > (AVG(PrecioUnitario*Cantidad)) THEN 'Por encima'
	END AS Promedio_de_ventas,
	CAST(SUM(PrecioUnitario*Cantidad) AS INT) AS Total_Facturado
FROM 
	DBO.Ventas
GROUP BY
	MONTH(FechaVenta)
ORDER BY 
	Total_Facturado DESC;

/*
===BLOQUE CIERRE===
Observaciones:
	1) Si bien el producto 2 es el que menos facturo, hay que tener en cuenta que esl el producto
	con mayor rotacion dentro del TOP 5.
	2) El cliente 1° y 2° del TOP 5 concentran más del %70 de la facturación.
	3) Los productos de ID 1 y 3 generan el %76 de las ganancias. 

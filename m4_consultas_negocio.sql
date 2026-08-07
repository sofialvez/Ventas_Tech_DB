/*==========================================================
  M4 - PREENTREGA
  Archivo: m4_consultas_negocio.sql
  Proyecto: RetailPro
  Base de datos: Ventas_Tech_DB
==========================================================*/


/*==========================================================
CONSULTA 1
Resumen ejecutivo mensual
- Total facturado
- Cantidad de pedidos
- Ticket promedio
==========================================================*/

SELECT
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(*) AS cantidad_pedidos,
    AVG(cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;



/*==========================================================
CONSULTA 2
Ranking Top 5 de productos
==========================================================*/

SELECT TOP 5
    id_producto,
    SUM(cantidad) AS unidades_vendidas,
    SUM(cantidad * precio_unitario) AS total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY unidades_vendidas DESC



/*==========================================================
CONSULTA 3
Clientes recurrentes
==========================================================*/

SELECT
    id_cliente,
    COUNT(*) AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1
ORDER BY total_gastado DESC;



/*==========================================================
CONSULTA 4
Meses por encima / por debajo del promedio
==========================================================*/

SELECT
    mes,
    total_facturado,
    CASE
        WHEN total_facturado > (
            SELECT AVG(total_facturado)
            FROM (
                SELECT SUM(cantidad * precio_unitario) AS total_facturado
                FROM ventas
                GROUP BY MONTH(fecha_venta)
            ) AS promedio
        ) THEN 'Por encima'
        
        WHEN total_facturado = (
            SELECT AVG(total_facturado)
            FROM (
                SELECT SUM(cantidad * precio_unitario) AS total_facturado
                FROM ventas
                GROUP BY MONTH(fecha_venta)
            ) AS promedio
        ) THEN 'Igual al promedio'
        
        ELSE 'Por debajo'
    END AS comparacion
FROM (
    SELECT
        MONTH(fecha_venta) AS mes,
        SUM(cantidad * precio_unitario) AS total_facturado
    FROM ventas
    GROUP BY MONTH(fecha_venta)
) AS resumen
ORDER BY mes;



/*==========================================================
HALLAZGOS
==========================================================*/

-- Hallazgo 1:
-- El producto con id_producto = 2 concentra la mayor facturación del período en unidades. Mientras que,
-- el producto con id_producto=1 tiene la mayor facturacion en pesos

-- Hallazgo 2:
-- El análisis muestra que únicamente existen ventas registradas en marzo. 
-- Por este motivo, la facturación de ese mes coincide con el promedio mensual, por lo que se clasifica como "Igual al promedio"

-- Hallazgo 3:
--Los clientes con mayor actividad fueron los clientes 1 y 5

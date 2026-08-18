-- ============================================
-- CONSULTA 1 - Vista base del proyecto (INNER JOIN)
-- ============================================

SELECT v.id_venta, 
	c.nombre,c.email,
	c.ciudad,
	c.fecha_registro,
	v.id_producto,
	p.nombre_producto,
	ct.nombre_categoria,
	p.precio,p.stock,
	p.activo,
	v.fecha_venta,
	v.cantidad,
	v.precio_unitario,
	(v.cantidad * v.precio_unitario) AS total_venta
FROM ventas AS v 
INNER JOIN clientes AS c 
	ON v.id_cliente=c.id_cliente
INNER JOIN productos AS p 
	ON v.id_producto=p.id_producto
INNER JOIN categorias AS ct 
	ON ct.id_categoria=p.id_categoria
ORDER BY v.fecha_venta;


-- ============================================
-- CONSULTA 2 - Clientes sin ventas (LEFT JOIN)
-- ============================================

SELECT
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes c
LEFT JOIN ventas v
    ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL
ORDER BY c.nombre;


-- ============================================
-- CONSULTA 3 - Productos sin ventas
-- ============================================

SELECT
    p.nombre_producto,
    p.id_categoria,
    p.precio,
    p.stock
FROM productos p
LEFT JOIN ventas v
    ON p.id_producto = v.id_producto
WHERE v.id_venta IS NULL
ORDER BY p.nombre_producto;

-- ============================================
-- CONSULTA 4 - 
-- ============================================

-- Agregar la columna canal
ALTER TABLE ventas
ADD canal VARCHAR(20);

-- Asignar los canales
UPDATE ventas
SET canal = 'Online'
WHERE id_venta IN (1, 3, 5, 7, 9);

UPDATE ventas
SET canal = 'Presencial'
WHERE id_venta IN (2, 4, 6, 8, 10);


-- ============================================
--  Consolidado por canal

SELECT
    canal,
    cantidad,
    precio_unitario,
    cantidad * precio_unitario AS total_venta
FROM ventas
WHERE canal = 'Online'

UNION ALL

SELECT
    canal,
    cantidad,
    precio_unitario,
    cantidad * precio_unitario AS total_venta
FROM ventas
WHERE canal = 'Presencial';


-- Total facturado por canal
SELECT
    canal,
    SUM(total_venta) AS total_facturado
FROM
(SELECT
       canal,
       cantidad * precio_unitario AS total_venta
    FROM ventas
    WHERE canal = 'Online'

    UNION ALL

    SELECT
        canal,
        cantidad * precio_unitario AS total_venta
    FROM ventas
    WHERE canal = 'Presencial'
) AS ventas_consolidadas
GROUP BY canal
ORDER BY canal;

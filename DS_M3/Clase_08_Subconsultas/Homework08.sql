-- Instrucción SQL N° 1

-- INSERT INTO fact_inicial (IdFecha, Fecha, IdSucursal, IdProducto, IdProductoFecha, IdSucursalFecha, IdProductoSucursalFecha)
SELECT	c.IdFecha, 
		g.Fecha,
		g.IdSucursal, 
        NULL AS IdProducto, 
        NULL AS IdProductoFecha, 
        g.IdSucursal * 100000000 + c.IdFecha IdSucursalFecha,
        NULL AS IdProductoSucursalFecha
FROM 	gasto g JOIN calendario c
	ON (g.Fecha = c.fecha)
WHERE g.IdSucursal * 100000000 + c.IdFecha IN (	SELECT	v.IdSucursal * 100000000 + c.IdFecha 
													FROM venta v JOIN calendario c ON (v.Fecha = c.fecha)
                                                    WHERE v.Outlier = 1);
-- Instrucción SQL N° 2

-- INSERT INTO fact_inicial (IdFecha, Fecha, IdSucursal, IdProducto, IdProductoFecha, IdSucursalFecha, IdProductoSucursalFecha)
SELECT	c.IdFecha, 
		co.Fecha,
		NULL AS IdSucursal, 
        co.IdProducto, 
        co.IdProducto * 100000000 + c.IdFecha AS  IdProductoFecha, 
        NULL IdSucursalFecha,
        NULL AS IdProductoSucursalFecha
FROM 	compra co JOIN calendario c
	ON (co.Fecha = c.fecha)
WHERE co.IdProducto * 100000000 + c.IdFecha NOT IN (SELECT	v.IdProducto * 100000000 + c.IdFecha
													FROM venta v JOIN calendario c ON (v.Fecha = c.fecha)
													WHERE v.Outlier = 1);

-- Instrucción SQL N° 3

SELECT 	co.TipoProducto,
		co.PromedioVentaConOutliers,
        so.PromedioVentaSinOutliers
FROM
	(	SELECT 	tp.TipoProducto, AVG(v.Precio * v.Cantidad) as PromedioVentaConOutliers
		FROM 	venta v 
		JOIN producto p
		ON (v.IdProducto = p.IdProducto)
		JOIN tipo_producto tp
		ON (p.IdTipoProducto = tp.IdTipoProducto)
		GROUP BY tp.TipoProducto
	) co
JOIN
	(	SELECT 	tp.TipoProducto, AVG(v.Precio * v.Cantidad) as PromedioVentaSinOutliers
		FROM 	venta v 
		JOIN producto p
		ON (v.IdProducto = p.IdProducto and v.Outlier = 1)
		JOIN tipo_producto tp
		ON (p.IdTipoProducto = tp.IdTipoProducto)
		GROUP BY tp.TipoProducto
	) so
ON co.TipoProducto = so.TipoProducto;

-- Pto 3
CREATE VIEW v_kpi AS
SELECT 	co.TipoProducto,
		co.PromedioVentaConOutliers,
        so.PromedioVentaSinOutliers
FROM
	(	SELECT 	tp.TipoProducto, AVG(v.Precio * v.Cantidad) as PromedioVentaConOutliers
		FROM 	venta v 
		JOIN producto p
		ON (v.IdProducto = p.IdProducto)
		JOIN tipo_producto tp
		ON (p.IdTipoProducto = tp.IdTipoProducto)
		GROUP BY tp.TipoProducto
	) co
JOIN
	(	SELECT 	tp.TipoProducto, AVG(v.Precio * v.Cantidad) as PromedioVentaSinOutliers
		FROM 	venta v 
		JOIN producto p
		ON (v.IdProducto = p.IdProducto and v.Outlier = 1)
		JOIN tipo_producto tp
		ON (p.IdTipoProducto = tp.IdTipoProducto)
		GROUP BY tp.TipoProducto
	) so
ON co.TipoProducto = so.TipoProducto;

ALTER VIEW v_VentasTipoProducto AS
SELECT 	tp.TipoProducto, AVG(v.Precio * v.Cantidad) as PromedioVenta
FROM 	venta v 
JOIN producto p
ON (v.IdProducto = p.IdProducto and v.Outlier = 1)
JOIN tipo_producto tp
ON (p.IdTipoProducto = tp.IdTipoProducto)
GROUP BY tp.TipoProducto;

ALTER VIEW v_VentasTipoProductoOutliers AS
SELECT 	tp.TipoProducto, AVG(v.Precio * v.Cantidad) as PromedioVenta
FROM 	venta v 
JOIN producto p
ON (v.IdProducto = p.IdProducto)
JOIN tipo_producto tp
ON (p.IdTipoProducto = tp.IdTipoProducto)
GROUP BY tp.TipoProducto;

select * from v_VentasTipoProducto;
select * from v_VentasTipoProductoOutliers;

SELECT	v.TipoProducto,
		v.PromedioVenta,
		vo.PromedioVenta As PromedioVentaOutliers
FROM 	v_VentasTipoProducto v JOIN v_VentasTipoProductoOutliers vo
		ON (v.TipoProducto = vo.TipoProducto);

select * from v_kpi;

-- Pto 4
-- Fechas de Ventas Mínima y Máxima
SELECT 	v1.Fecha_Minventas, 
		v1.Total_Ventas	as Total_VentasMin,
        v2.Fecha_MaxVentas,
        v2.Total_Ventas	as Total_VentasMax
FROM
	(SELECT v.Fecha AS Fecha_MinVentas, SUM(v.Precio * v.Cantidad) AS Total_Ventas
	FROM fact_venta v
	WHERE v.Fecha = (SELECT MIN(Fecha)
					FROM fact_venta)
	GROUP BY v.Fecha) v1
JOIN
	(SELECT v.Fecha AS Fecha_MaxVentas, SUM(v.Precio * v.Cantidad) AS Total_Ventas
	FROM fact_venta v
	WHERE v.Fecha = (SELECT MAX(Fecha)
					FROM fact_venta)
	GROUP BY v.Fecha) v2;

Select sum(precio * cantidad) as Venta, Fecha
from venta
where Fecha =   (select max(Fecha)from venta) or 
	  Fecha =   (select min(Fecha)from venta)
GROUP BY Fecha;

-- Pto 5
SELECT v.Fecha, v.IdProducto, p.Producto, SUM(v.Precio * v.Cantidad) AS Total_Ventas
FROM fact_venta v
	LEFT JOIN dim_producto p
		ON v.IdProducto = p.IdProducto
WHERE v.Fecha IN (SELECT Min(Fecha) as Fecha FROM fact_venta
				UNION
                SELECT MAX(Fecha) as Fecha FROM fact_venta)
GROUP BY v.Fecha, v.IdProducto, p.Producto
ORDER BY v.Fecha, p.Producto;

-- Pto 6
SELECT 	Fecha,
		SUM(Precio * Cantidad) AS Total_Ventas,
        row_number() OVER(ORDER BY SUM(Precio * Cantidad) DESC) as row_num
FROM fact_venta
GROUP BY Fecha
ORDER BY Fecha Desc;

SELECT * FROM
	(SELECT Fecha, 
			SUM(Precio * Cantidad) AS Total_Ventas,
			ROW_NUMBER() OVER(ORDER BY SUM(Precio * Cantidad) DESC) AS row_num
	FROM fact_venta
	GROUP BY Fecha) a
WHERE row_num = 1;

CREATE VIEW v_ventas_por_fecha AS
select Fecha,sum(precio*cantidad) as VentaTotal from venta GROUP BY Fecha;

SELECT Fecha, VentaTotal as VentaMaxima
FROM v_ventas_por_fecha
WHERE VentaTotal = (SELECT MAX(VentaTotal) FROM v_ventas_por_fecha);

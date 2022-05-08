/*
Responder Verdadero ó Falso

1) Un índice SQL es una tabla de búsqueda rápida para poder encontrar los registros que los usuarios necesitan buscar con mayor frecuencia.

VERDADERO

2) La regla de las 3 sigmas para detección de Outliers está basada en la Mediana.

FALSO

3) Las tablas Maestros registran las operaciones ocurridas, todo tipo de transacciones donde intervienen las diferentes entidades del modelo.
Elegir la opción correcta en base a la observación del siguiente DER:

FALSO

4) ¿Cuál de las siguientes no es una tabla que representa una dimensión?

1- cliente
2- calendario
3- venta
4- provincia

Respuesta: op 3

5) El DER presentado...

1- es un Modelo Estrella, porque tiene una sóla tabla de hechos.
2- no es un Modelo Estrella, ya que contiene referencias circulares.
3- es un Modelo Copo de Nieve.

Respuesta: op 2

Resuelve los siguientes ejercicios:

*/



/*
En tu motor de base de datos MySQL, ejecutá las instrucciones del script 'Checkpoint_Create_Insert.sql' (Si no trabajas con MySQL es posible 
que tengas que realizar algunos ajustes en el script. También están provistas las tablas en formato csv dentro de la carpeta 'tablas_cp').

/*
item 6: (Ganancia = Venta - Gasto) venta = precio * cantidad, por sucursal

Respuesta: Flores op 02
*/

SELECT * FROM `venta`;

SELECT * FROM information_schema.TABLE_CONSTRAINTS 
WHERE information_schema.TABLE_CONSTRAINTS.CONSTRAINT_TYPE = 'FOREIGN KEY' 
AND information_schema.TABLE_CONSTRAINTS.TABLE_SCHEMA = 'henry_checkpoint_m3'
AND information_schema.TABLE_CONSTRAINTS.TABLE_NAME = 'venta';

SELECT * FROM `sucursal`;

SELECT * FROM information_schema.TABLE_CONSTRAINTS 
WHERE information_schema.TABLE_CONSTRAINTS.CONSTRAINT_TYPE = 'FOREIGN KEY' 
AND information_schema.TABLE_CONSTRAINTS.TABLE_SCHEMA = 'henry_checkpoint_m3'
AND information_schema.TABLE_CONSTRAINTS.TABLE_NAME = 'sucursal';

SELECT * FROM `gasto`;

SELECT * FROM information_schema.TABLE_CONSTRAINTS 
WHERE information_schema.TABLE_CONSTRAINTS.CONSTRAINT_TYPE = 'FOREIGN KEY' 
AND information_schema.TABLE_CONSTRAINTS.TABLE_SCHEMA = 'henry_checkpoint_m3'
AND information_schema.TABLE_CONSTRAINTS.TABLE_NAME = 'gasto';

SELECT	s.IdSucursal,
		s.Sucursal,
		SUM((v.Precio * v.Cantidad)) AS venta_total,
        SUM(g.`Monto`) AS `gasto_total`,
        ((SUM((v.Precio * v.Cantidad))) - (SUM(g.`Monto`))) AS `ganancia`
	FROM `venta` v JOIN `sucursal` s
    ON v.IdSucursal = s.IdSucursal
		JOIN `gasto` g
        ON s.`IdSucursal` = g.`IdSucursal`
	WHERE YEAR(v.`Fecha`) = 2020 AND YEAR(g.`Fecha`) = 2020
    GROUP BY s.IdSucursal
    ORDER BY `ganancia` DESC;


/*
item 7: (Ganancia = Venta - Gasto) venta = precio * cantidad, por tipo de producto
Respuesta : Informatica op 01
*/

SELECT * FROM producto;

SELECT * FROM tipo_producto;

SELECT	v.IdVenta,
		p.IdProducto,
		p.Producto,
        p.IdTipoProducto,	
        #tp.TipoProducto,
		SUM((v.Precio * v.Cantidad)) AS venta_total
	FROM venta v JOIN producto p
		ON v.IdProducto = p.IdProducto
	WHERE YEAR(v.Fecha) = 2020
	GROUP BY p.IdTipoProducto;

SELECT	c.IdCompra,
		p.IdProducto,
        p.Producto,
        p.IdTipoProducto,
		SUM((c.Precio * c.Cantidad)) AS compra_total
	FROM compra c JOIN producto p
        ON c.IdProducto = p.IdProducto
	WHERE YEAR(c.Fecha) = 2020
	GROUP BY p.IdTipoProducto;

SELECT	tp.TipoProducto,
		(venta_tP.venta_total - compra_tp.compra_total) AS `ganancia`
		FROM (SELECT	#v.IdVenta,
						#p.IdProducto,
						#p.Producto,
						p.IdTipoProducto,	
						#tp.TipoProducto,
						SUM((v.Precio * v.Cantidad)) AS venta_total
					FROM venta v JOIN producto p
						ON v.IdProducto = p.IdProducto
					WHERE YEAR(v.Fecha) = 2020
					GROUP BY p.IdTipoProducto) AS venta_tP 
	JOIN (SELECT	#c.IdCompra,
					#p.IdProducto,
					#p.Producto,
					p.IdTipoProducto,
					SUM((c.Precio * c.Cantidad)) AS compra_total
				FROM compra c JOIN producto p
					ON c.IdProducto = p.IdProducto
				WHERE YEAR(c.Fecha) = 2020
				GROUP BY p.IdTipoProducto) AS compra_tp 
    ON venta_tP.IdTipoProducto = compra_tp.IdTipoProducto
		JOIN tipo_producto tp
        ON venta_tP.IdTipoProducto = tp.IdTipoProducto;

/*
item 8:  porcentaje de clientes que compraron unicamente en una sucursal durante 2020
Respuesta: 33.71
*/

SELECT  a.IdCliente, COUNT(a.IdCliente) visitas_unicas
FROM (SELECT DISTINCT	IdCliente,
						IdSucursal
		FROM venta 
		WHERE YEAR(Fecha) = 2020
		ORDER BY IdCliente) a
GROUP BY a.IdCliente
HAVING COUNT(a.IdCliente) = 1;

SELECT DISTINCT	IdCliente,
				IdSucursal
		FROM venta 
		WHERE YEAR(Fecha) = 2020
		ORDER BY IdCliente;
        
SELECT	SUM(c.visitas_unicas) 
	FROM (SELECT 	a.IdCliente,
					COUNT(a.IdCliente) visitas_unicas
			FROM (SELECT DISTINCT	IdCliente,
									IdSucursal
					FROM venta 
					WHERE YEAR(Fecha) = 2020
					ORDER BY IdCliente) a
			GROUP BY a.IdCliente
			HAVING COUNT(a.IdCliente) = 1) AS c;

SELECT COUNT(DISTINCT(IdCliente)) FROM `venta` WHERE YEAR(Fecha) = 2020;


SELECT @clienteUnicaVisita := SUM(c.visitas_unicas) 
	FROM (SELECT 	a.IdCliente,
					COUNT(a.IdCliente) visitas_unicas
			FROM (SELECT DISTINCT	IdCliente,
									IdSucursal
					FROM venta 
					WHERE YEAR(Fecha) = 2020
					ORDER BY IdCliente) a
			GROUP BY a.IdCliente
			HAVING COUNT(a.IdCliente) = 1) AS c;

SELECT @clientesTotales := COUNT(DISTINCT(IdCliente)) FROM `venta` WHERE YEAR(Fecha) = 2020;

SELECT ROUND((((@clienteUnicaVisita)/(@clientesTotales))*100),2);

/*
item 9:  porcentaje de clientes que compraron en 2020 pero no en 2019
Respuesta: 40.79
*/

    
SELECT COUNT(DISTINCT a.IdCliente) FROM (SELECT * FROM venta WHERE YEAR(Fecha) = 2020) AS a JOIN venta v ON a.IdCliente = v.IdCliente WHERE YEAR(v.Fecha) = 2019;

SELECT COUNT(DISTINCT IdCliente) FROM venta WHERE YEAR(Fecha) = 2020; 

SELECT @c1_2 := COUNT(DISTINCT a.IdCliente) FROM (SELECT * FROM venta WHERE YEAR(Fecha) = 2020) AS a JOIN venta v ON a.IdCliente = v.IdCliente WHERE YEAR(v.Fecha) = 2019;

SELECT @c2 := COUNT(DISTINCT IdCliente) FROM venta WHERE YEAR(Fecha) = 2020;

SELECT ROUND((((@c2 - @c1_2)/@c2)*100),2);

/*
item 10:  porcentaje de clientes que compraron en 2019 y en 2020
Respuesta: 85.42
*/


SELECT COUNT(DISTINCT a.IdCliente) FROM (SELECT * FROM venta WHERE YEAR(Fecha) = 2019) AS a JOIN venta v ON a.IdCliente = v.IdCliente WHERE YEAR(v.Fecha) = 2020;

SELECT COUNT(DISTINCT IdCliente) FROM venta WHERE YEAR(Fecha) = 2019; 

SELECT @c1_2 := COUNT(DISTINCT a.IdCliente) FROM (SELECT * FROM venta WHERE YEAR(Fecha) = 2019) AS a JOIN venta v ON a.IdCliente = v.IdCliente WHERE YEAR(v.Fecha) = 2020;

SELECT @c2 := COUNT(DISTINCT IdCliente) FROM venta WHERE YEAR(Fecha) = 2019;

SELECT ROUND(100 - (((@c2 - @c1_2)/@c2)*100),2);

/*
item 11:  cantidad de clientes realizó compras sólo por el canal OnLine entre 2019 y 2020
Respuesta: 564
*/

SELECT COUNT(*) 
	FROM (SELECT	IdCliente
			FROM venta
			WHERE (YEAR(Fecha) BETWEEN 2019 AND 2020) AND (IdCanal = 2)
			GROUP BY IdCliente) AS a
	WHERE a.IdCliente NOT IN (SELECT IdCliente
								FROM venta
								WHERE (YEAR(Fecha) BETWEEN 2019 AND 2020) AND (IdCanal != 2)
								GROUP BY IdCliente);

                                
SELECT *
    FROM venta
    WHERE (YEAR(Fecha) BETWEEN 2019 AND 2020) AND (IdCanal = 2)
    GROUP BY IdCliente;

SELECT *
    FROM venta
    WHERE (YEAR(Fecha) BETWEEN 2019 AND 2020) AND (IdCanal != 2)
    GROUP BY IdCliente;

/*
item 12:  sucursal que más Venta (Precio * Cantidad) hizo en 2020 a clientes que viven fuera de su provincia
Respuesta: op 01
*/



/*
item 13:  ¿Cuál fué el mes del año 2020, de mayor crecimiento con respecto al mismo mes del año 2019 si se toman en cuenta a nivel 
general Ventas (Precio * Cantidad) - Compras (Precio * Cantidad) - Gastos?
Respuesta: mes 4, abril
*/


SELECT *, (Precio * Cantidad) AS venta_2020, EXTRACT(MONTH FROM Fecha) AS mes FROM venta WHERE YEAR(Fecha) = 2020 GROUP BY mes;

SELECT *, (Precio * Cantidad) AS compra_2020, EXTRACT(MONTH FROM Fecha) AS mes FROM compra WHERE YEAR(Fecha) = 2020 GROUP BY mes;

SELECT *, SUM(Monto) AS gasto_2020, EXTRACT(MONTH FROM Fecha) AS mes FROM gasto WHERE YEAR(Fecha) = 2020 GROUP BY mes;

SELECT	v.mes,
		v.venta_2020, 
		c.compra_2020, 
        g.gasto_2020,
        (v.venta_2020 - c.compra_2020 - g.gasto_2020) AS ganacia_general2020
	FROM (SELECT	*, 
					SUM(Precio * Cantidad) AS venta_2020, 
                    EXTRACT(MONTH FROM Fecha) AS mes 
				FROM venta WHERE YEAR(Fecha) = 2020 
                GROUP BY mes) AS v 
    JOIN (SELECT	*, 
					SUM(Precio * Cantidad) AS compra_2020, 
                    EXTRACT(MONTH FROM Fecha) AS mes 
				FROM compra WHERE YEAR(Fecha) = 2020 
                GROUP BY mes) AS c 
    ON v.mes = c.mes
    JOIN (SELECT	*, 
					SUM(Monto) AS gasto_2020, 
                    EXTRACT(MONTH FROM Fecha) AS mes 
                    FROM gasto WHERE YEAR(Fecha) = 2020 
                    GROUP BY mes) AS g
	ON v.mes = g.mes;
    
SELECT	v.mes,
		v.venta_2019, 
		c.compra_2019, 
        g.gasto_2019,
        (v.venta_2019 - c.compra_2019 - g.gasto_2019) AS ganacia_general2019
	FROM (SELECT	*, 
					SUM(Precio * Cantidad) AS venta_2019, 
                    EXTRACT(MONTH FROM Fecha) AS mes 
				FROM venta WHERE YEAR(Fecha) = 2019 
                GROUP BY mes) AS v 
    JOIN (SELECT	*, 
					SUM(Precio * Cantidad) AS compra_2019, 
                    EXTRACT(MONTH FROM Fecha) AS mes 
				FROM compra WHERE YEAR(Fecha) = 2019 
                GROUP BY mes) AS c 
    ON v.mes = c.mes
    JOIN (SELECT	*, 
					SUM(Monto) AS gasto_2019, 
                    EXTRACT(MONTH FROM Fecha) AS mes 
                    FROM gasto WHERE YEAR(Fecha) = 2019 
                    GROUP BY mes) AS g
	ON v.mes = g.mes;
    
SELECT gg2019.mes, gg2019.ganacia_general2019, gg2020.ganacia_general2020, ((gg2020.ganacia_general2020) - (gg2019.ganacia_general2019)) AS crecimiento  
	FROM (SELECT	v.mes,
					v.venta_2019, 
					c.compra_2019, 
					g.gasto_2019,
					(v.venta_2019 - c.compra_2019 - g.gasto_2019) AS ganacia_general2019
			FROM (SELECT	*, 
							SUM(Precio * Cantidad) AS venta_2019, 
							EXTRACT(MONTH FROM Fecha) AS mes 
					FROM venta WHERE YEAR(Fecha) = 2019 
					GROUP BY mes) AS v 
			JOIN (SELECT	*, 
							SUM(Precio * Cantidad) AS compra_2019, 
							EXTRACT(MONTH FROM Fecha) AS mes 
					FROM compra WHERE YEAR(Fecha) = 2019 
					GROUP BY mes) AS c 
				ON v.mes = c.mes
			JOIN (SELECT	*, 
							SUM(Monto) AS gasto_2019, 
							EXTRACT(MONTH FROM Fecha) AS mes 
                    FROM gasto WHERE YEAR(Fecha) = 2019 
                    GROUP BY mes) AS g
				ON v.mes = g.mes) AS gg2019 
	JOIN (SELECT	v.mes,
					v.venta_2020, 
					c.compra_2020, 
					g.gasto_2020,
					(v.venta_2020 - c.compra_2020 - g.gasto_2020) AS ganacia_general2020
			FROM (SELECT	*, 
							SUM(Precio * Cantidad) AS venta_2020, 
							EXTRACT(MONTH FROM Fecha) AS mes 
					FROM venta WHERE YEAR(Fecha) = 2020 
					GROUP BY mes) AS v 
			JOIN (SELECT	*, 
							SUM(Precio * Cantidad) AS compra_2020, 
							EXTRACT(MONTH FROM Fecha) AS mes 
					FROM compra WHERE YEAR(Fecha) = 2020 
					GROUP BY mes) AS c 
				ON v.mes = c.mes
			JOIN (SELECT	*, 
							SUM(Monto) AS gasto_2020, 
							EXTRACT(MONTH FROM Fecha) AS mes 
                    FROM gasto WHERE YEAR(Fecha) = 2020 
                    GROUP BY mes) AS g
				ON v.mes = g.mes) AS  gg2020 
    ON gg2019.mes = gg2020.mes;

/*
item 14: Considerando que se requiere consultar las ventas por Rangos Etarios de Productos que corresponden a los tipos 'Estucheria', 
'Informatica', 'Impresión' y 'Audio', hechas por Sucursales ubicadas en la Provincia de Buenos Aires durante la segunda mitad del año 
020 y a travéz del Canal de Venta OnLine.

Respuesta: 02
*/

-- Consulta 1

Select	cl.Rango_Etario,
		   tp.TipoProducto,
        sum(v.Precio * v.Cantidad) as Venta
from 	venta v Join cliente cl
		On (v.IdCliente = cl.IdCliente)
	Join producto p
		On (v.IdProducto = p.IdProducto)
	Join tipo_producto tp
		On (p.IdTipoProducto = tp.IdTipoProducto)
	Join canal_venta cp
		On (cp.IdCanal = v.IdCanal)
	Join sucursal s
		On (s.IdSucursal = v.IdSucursal)
	Join localidad lo
		On (s.IdLocalidad = lo.IdLocalidad)
	Join provincia pr
		On (lo.IdProvincia = pr.IdProvincia)
Where 	Year(v.Fecha) = 2020
		   And Month(v.Fecha) >= 6
		   And cp.Canal = 'OnLine'
         And pr.Provincia = 'Buenos Aires'
         And TipoProducto In ('Estucheria','Informatica','Impresión','Audio')
Group by cl.Rango_Etario,
		tp.TipoProducto
Order by cl.Rango_Etario,
		Venta Desc;
        
-- Consulta 2

Select	cl.Rango_Etario,
		tp.TipoProducto,
        sum(v.Precio * v.Cantidad) as Venta
from 	venta v Join cliente cl
		On (v.IdCliente = cl.IdCliente
			And Year(v.Fecha) = 2020
            And Month(v.Fecha) >= 6)
	Join producto p
		On (v.IdProducto = p.IdProducto)
	Join tipo_producto tp
		On (p.IdTipoProducto = tp.IdTipoProducto
			And TipoProducto In ('Estucheria','Informatica','Impresión','Audio'))
	Join canal_venta cp
		On (cp.IdCanal = v.IdCanal
			And cp.Canal = 'OnLine')
	Join sucursal s
		On (s.IdSucursal = v.IdSucursal)
	Join localidad lo
		On (s.IdLocalidad = lo.IdLocalidad)
	Join provincia pr
		On (lo.IdProvincia = pr.IdProvincia
			And pr.Provincia = 'Buenos Aires')
Group by cl.Rango_Etario,
		tp.TipoProducto
Order by cl.Rango_Etario,
		Venta Desc;
        
-- Consulta 3

Select	cl.Rango_Etario,
		   tp.TipoProducto,
        sum(v.Precio * v.Cantidad) as Venta
from 	venta v Join cliente cl
		On (v.IdCliente = cl.IdCliente
			And Year(v.Fecha) = 2020
         And Month(v.Fecha) >= 6)
	Join producto p
		On (v.IdProducto = p.IdProducto)
	Join tipo_producto tp
		On (p.IdTipoProducto = tp.IdTipoProducto
			And TipoProducto In ('Estucheria','Informatica','Impresión','Audio'))
	Join canal_venta cp
		On (cp.IdCanal = v.IdCanal
			And cp.Canal = 'OnLine')
	Join sucursal s
		On (s.IdSucursal = v.IdSucursal)
	Join localidad lo
		On (cl.IdLocalidad = lo.IdLocalidad)
	Join provincia pr
		On (lo.IdProvincia = pr.IdProvincia
			And pr.Provincia = 'Buenos Aires')
Group by cl.Rango_Etario,
		tp.TipoProducto
Order by cl.Rango_Etario,
		Venta Desc;
        
/*
item 15: El negocio suele requerir con gran frecuencia consultas a nivel trimestral tanto sobre las ventas, como las compras y 
los gastos...
Elige la opción correcta.

Respuesta: 02
*/

/*

Cada una de las sucursales de la provincia de Córdoba, disponibilizaron un excel donde registraron el porcentaje de comisión 
que se le otorgó a cada uno de los empleados sobre la venta que realizaron. Es necesario incluir esas tablas (Comisiones
Córdoba Centro.xlsx, Comisiones Córdoba Quiróz.xlsx y Comisiones Córdoba Cerro de las Rosas.xlsx) en el modelo y contestar 
las siguientes preguntas:
16) ¿Cuál es el código de empleado del empleado que mayor comisión obtuvo en diciembre del año 2020?
Respuesta 3929
*/


DROP TABLE IF EXISTS `comisionses_Cordoba`;

CREATE TABLE IF NOT EXISTS `comisionses_Cordoba` (
  	`CodigoEmpleado` 		INTEGER,
  	`IdSucursal` 			INTEGER,
  	`ApellidoNombre` 		VARCHAR(30),
    `Sucursal`				VARCHAR(30),
  	`Anio` 					INTEGER,
	`Mes`					INTEGER,
    `Porcentaje`     		INTEGER
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;	

LOAD DATA INFILE '\Comisiones_Cordoba_Centro(CSV).csv' 
INTO TABLE `comisionses_Cordoba` 
FIELDS TERMINATED BY ';' ENCLOSED BY '' ESCAPED BY ',' 
LINES TERMINATED BY '\n' IGNORE 1 LINES;

SELECT * FROM comisionses_Cordoba;

LOAD DATA INFILE '\Comisiones_Cordoba_Cerro_de_las_Rosas(CSV).csv' 
INTO TABLE `comisionses_Cordoba` 
FIELDS TERMINATED BY ';' ENCLOSED BY '' ESCAPED BY ',' 
LINES TERMINATED BY '\n' IGNORE 1 LINES;

SELECT * FROM comisionses_Cordoba;

LOAD DATA INFILE '\Comisiones_Cordoba_Quiroz(CSV).csv' 
INTO TABLE `comisionses_Cordoba` 
FIELDS TERMINATED BY ';' ENCLOSED BY '' ESCAPED BY ',' 
LINES TERMINATED BY '\n' IGNORE 1 LINES;

SELECT * FROM comicionses_Cordoba;

SELECT * FROM venta;

SELECT * FROM empleado;

SELECT *, (v.Precio * v.Cantidad) AS  venta FROM venta v INNER JOIN empleado e ON v.IdEmpleado = e.IDEmpleado;



SELECT	e.*,
		cc.Anio,
		cc.mes,
        cc.Porcentaje
	FROM empleado e INNER JOIN comisionses_Cordoba cc 
		ON (e.IdSucursal = cc.IdSucursal AND e.CodigoEmpleado = cc.CodigoEmpleado) 
    WHERE Anio = 2020;
    
SELECT	*, 
		SUM((Precio * Cantidad)) AS venta 
	FROM venta 
    WHERE YEAR(Fecha) = 2020 AND EXTRACT(MONTH FROM Fecha) = 12
    GROUP BY IdEmpleado;

SELECT	venta2020.IdEmpleado,
		venta2020.venta_total,
		e_cc.Porcentaje,
        (venta2020.venta_total * e_cc.Porcentaje) AS comision
        FROM (SELECT	*, 
						SUM((Precio * Cantidad)) AS venta_total 
						FROM venta 
						WHERE YEAR(Fecha) = 2020 AND EXTRACT(MONTH FROM Fecha) = 12
						GROUP BY IdEmpleado) AS venta2020 
    JOIN (SELECT	e.*,
					cc.Anio,
					cc.mes,
					cc.Porcentaje
					FROM empleado e INNER JOIN comisionses_Cordoba cc 
					ON (e.IdSucursal = cc.IdSucursal AND e.CodigoEmpleado = cc.CodigoEmpleado) 
    WHERE Anio = 2020 AND Mes = 12) e_cc 
	ON venta2020.IdEmpleado = e_cc.IDEmpleado;

/*

17) ¿Cuál es la sucursal que menos comisión pagó en el año 2020?

Elige la opción correcta:

1- Córdoba Centro.<br>
2- Córdoba Quiroz.<br>
3- Cerro De Las Rosas.<br>

Respuesta: Cerro de las Rosas op 03
*/

SELECT	venta2020.IdSucursal,
		venta2020.IdEmpleado,
		venta2020.venta_total,
		e_cc.Porcentaje,
        SUM((venta2020.venta_total * e_cc.Porcentaje)) AS comision
        FROM (SELECT	*, 
						SUM((Precio * Cantidad)) AS venta_total 
						FROM venta 
						WHERE YEAR(Fecha) = 2020
						GROUP BY IdEmpleado) AS venta2020 
    JOIN (SELECT	e.*,
					cc.Anio,
					cc.mes,
					cc.Porcentaje
					FROM empleado e INNER JOIN comisionses_Cordoba cc 
					ON (e.IdSucursal = cc.IdSucursal AND e.CodigoEmpleado = cc.CodigoEmpleado) 
    WHERE Anio = 2020) e_cc 
	ON venta2020.IdEmpleado = e_cc.IDEmpleado
    GROUP BY venta2020.IdSucursal;
    
SELECT * FROM sucursal WHERE IdSucursal = 25;

/*

18) La ganancia neta por sucursal es las ventas menos los gastos (Ganancia = Venta - Gasto) ¿Cuál es la sucursal con mayor ganancia 
neta en 2020 en la provincia de Córdoba si además quitamos los pagos por comisiones?

Elige la opción correcta:

1- Córdoba Quiroz
2- Cerro De Las Rosas
3- Córdoba Centro

Respuesta: Cordoba Centro 03
*/


SELECT	s.IdSucursal,
		s.Sucursal,
		SUM((v.Precio * v.Cantidad)) AS venta_total,
        SUM(g.`Monto`) AS `gasto_total`,
        ((SUM((v.Precio * v.Cantidad))) - (SUM(g.`Monto`))) AS `ganancia`
	FROM `venta` v JOIN `sucursal` s
    ON v.IdSucursal = s.IdSucursal
		JOIN `gasto` g
        ON s.`IdSucursal` = g.`IdSucursal`
	WHERE YEAR(v.`Fecha`) = 2020 AND YEAR(g.`Fecha`) = 2020 AND s.IdSucursal IN(25,26,27)
    GROUP BY s.IdSucursal
    ORDER BY `ganancia` DESC;



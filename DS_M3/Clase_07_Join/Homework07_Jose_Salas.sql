/*

1.- Obtener un listado del nombre y apellido de cada cliente que haya adquirido algun producto junto 
al id del producto y su respectivo precio.

*/

-- campos a mostrar:    `cliente`       `nombre_apellido`
--                      `producto`      `id_producto`
--                      `producto`      `descripcion_producto`
--                      `producto`      `precio`

SELECT  DISTINCT(c.`nombre_apellido`), 
        p.`id_producto`, 
        p.`descripcion_producto`, 
        (p.`precio` * v.`cantidad`) AS `venta`
    FROM `venta` v LEFT JOIN `producto` p 
        ON v.`id_producto` = p.`id_producto`
        LEFT JOIN `cliente` c
            ON v.`id_cliente` = c.`id_cliente`; 

/*

2.- Obteber un listado de clientes con la cantidad de productos adquiridos, incluyendo aquellos 
que nunca compraron algún producto.

*/

SELECT  v.`id_venta`,
        c.`id_cliente`,
        c.`nombre_apellido`, 
        v.`id_producto`, 
        SUM(IFNULL(v.`cantidad`,0)) AS `q1`
    FROM `venta` v JOIN `cliente` c 
        ON v.`id_cliente` = c.`id_cliente`
    GROUP BY v.`id_cliente`;


/*

3.- Obtener un listado de cual fue el volumen de compra por año de cada cliente.

*/

SELECT  COUNT(v.`id_venta`),
        c.`id_cliente`,
        c.`nombre_apellido`
    FROM `venta` v JOIN `cliente` c 
        ON v.`id_cliente` = c.`id_cliente`
    GROUP BY v.`id_cliente`;

/*

4.- Obtener un listado del nombre y apellido de cada cliente que haya adquirido algun producto 
junto al id del producto, la cantidad de productos adquiridos y el precio promedio.

*/

-- campos a mostrar:    `cliente`       `nombre_apellido`
--                      `producto`      `id_producto`
--                      `producto`      `descripcion_producto`
--                      `venta`         `cantidad`
--                      `producto`      `precio`
--                      `venta`         (pecio * cantidad)

SELECT  c.`nombre_apellido`, 
        p.`id_producto`, 
        p.`descripcion_producto`,
        SUM(v.`cantidad`), 
        ROUND(AVG((p.`precio` * v.`cantidad`))) AS `venta`
    FROM `venta` v LEFT JOIN `producto` p 
        ON v.`id_producto` = p.`id_producto`
        LEFT JOIN `cliente` c
            ON v.`id_cliente` = c.`id_cliente`
    GROUP BY    c.`id_cliente`,
    		    c.`nombre_apellido`, 
		        p.`id_producto`,
                p.`descripcion_producto`
    ORDER BY    c.`nombre_apellido`,
                p.`id_producto`;

/*

5.- Cacular la cantidad de productos vendidos y la suma total de ventas para cada localidad, 
presentar el análisis en un listado con el nombre de cada localidad.

*/

SELECT  pcia.`provincia`, 
        l.`localidad`,
        SUM(v.`cantidad`) 			    AS `q_productos_vendidos`,
        SUM(p.`precio` * v.`cantidad`) 	AS `total_ventas`,
        COUNT(v.`id_venta`)			    AS `volumen_ventas`
    FROM `venta` v LEFT JOIN `producto` p 
        ON v.`id_producto` = p.`id_producto`
        LEFT JOIN `cliente` c
            ON v.`id_cliente` = c.`id_cliente`
            LEFT JOIN `localidad` l
                ON c.`id_localidad` = l.`id_localidad`
                LEFT JOIN `provincia` pcia
                    ON l.`id_provincia` = pcia.`id_provincia`
    GROUP BY    p.`id_producto`, 
                pcia.`provincia`, 
                l.`id_localidad`, 
                l.`localidad`
    ORDER BY    pcia.`provincia`, 
                l.`localidad`;



/*

6.- Cacular la cantidad de productos vendidos y la suma total de ventas para cada provincia, 
presentar el análisis en un listado con el nombre de cada provincia, pero solo en aquellas donde la suma total de las ventas fue superior a $100.000.

*/

SELECT  pcia.`provincia`, 
        l.`localidad`,
        SUM(v.`cantidad`) 			    AS `q_productos_vendidos`,
        SUM(p.`precio` * v.`cantidad`) 	AS `total_ventas`,
        COUNT(v.`id_venta`)			    AS `volumen_ventas`
    FROM `venta` v LEFT JOIN `producto` p 
        ON v.`id_producto` = p.`id_producto`
        LEFT JOIN `cliente` c
            ON v.`id_cliente` = c.`id_cliente`
            LEFT JOIN `localidad` l
                ON c.`id_localidad` = l.`id_localidad`
                LEFT JOIN `provincia` pcia
                    ON l.`id_provincia` = pcia.`id_provincia`
    WHERE v.`outlier` = 1
    GROUP BY    pcia.`id_provincia`,
                pcia.`provincia`
    HAVING sum(p.`precio` * v.`cantidad`) > 100000
    ORDER BY    pcia.`provincia`;

/*

7.- Obtener un listado de dos campos en donde por un lado se obtenga la cantidad de productos 
vendidos por rango etario y las ventas totales en base a esta misma dimensión. El resultado debe 
obtenerse en un solo listado.

*/

SELECT  c.`rango_edad`,
        SUM(v.`cantidad`) 			    AS `q_productos_vendidos`,
        SUM(p.`precio` * v.`cantidad`) 	AS `total_ventas`
    FROM `venta` v LEFT JOIN `producto` p 
        ON v.`id_producto` = p.`id_producto`
        LEFT JOIN `cliente` c
            ON v.`id_cliente` = c.`id_cliente`
            LEFT JOIN `localidad` l
                ON c.`id_localidad` = l.`id_localidad`
                LEFT JOIN `provincia` pcia
                    ON l.`id_provincia` = pcia.`id_provincia`
    WHERE v.`outlier` = 1
    GROUP BY    c.`rango_edad`
    ORDER BY    c.`rango_edad`;

/*

8.- Obtener la cantidad de clientes por provincia.

*/

SELECT  pcia.`id_provincia`,
        COUNT(c.`id_cliente`) AS `total_clientes`
    FROM `venta` v LEFT JOIN `producto` p 
        ON v.`id_producto` = p.`id_producto`
        LEFT JOIN `cliente` c
            ON v.`id_cliente` = c.`id_cliente`
            LEFT JOIN `localidad` l
                ON c.`id_localidad` = l.`id_localidad`
                LEFT JOIN `provincia` pcia
                    ON l.`id_provincia` = pcia.`id_provincia`
    GROUP BY    pcia.`id_provincia`
    ORDER BY    pcia.`id_provincia`;
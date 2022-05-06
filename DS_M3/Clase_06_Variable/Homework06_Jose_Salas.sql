/*

1.- Crear un procedimiento que recibe como parametro una fecha y devuelva el listado de productos que 
se vendieron en esa fecha.


-- Esta es la subconsulta de la cual la consulta extraerá los datos. 
SELECT p.`id_producto`, p.`descripcion_producto`, p.`id_tipo_producto`, tp.`descripcion` AS `tipo_producto`
    FROM `producto` p JOIN `tipo_producto` tp
    ON p.`id_tipo_producto` = tp.`id_tipo_producto`;

-- Este es el scrit que operará dentro del procedimiento
SELECT  DISTINCT(v.`id_producto`), 
        `lista_producto`.`descripcion_producto`,
        `lista_producto`.`tipo_producto`
    FROM `venta` v JOIN (SELECT p.`id_producto`, 
                                p.`descripcion_producto`, 
                                p.`id_tipo_producto`, 
                                tp.`descripcion` AS `tipo_producto`
                            FROM `producto` p JOIN `tipo_producto` tp
                            ON p.`id_tipo_producto` = tp.`id_tipo_producto`) AS `lista_producto`
    ON v.id_producto = lista_producto.id_producto
    WHERE `fecha` = DATE('2020-01-01'); --aquí va el argumento de la función
*/

DROP PROCEDURE IF EXISTS listaProducto;
DELIMITER $$
CREATE PROCEDURE listaProducto(IN fechaConsulta DATE)
BEGIN
    SELECT  DISTINCT(v.`id_producto`), 
        `lista_producto`.`descripcion_producto`,
        `lista_producto`.`tipo_producto`
    FROM `venta` v JOIN (SELECT p.`id_producto`, 
                                p.`descripcion_producto`, 
                                p.`id_tipo_producto`, 
                                tp.`descripcion` AS `tipo_producto`
                            FROM `producto` p JOIN `tipo_producto` tp
                            ON p.`id_tipo_producto` = tp.`id_tipo_producto`) AS `lista_producto`
    ON v.`id_producto` = `lista_producto`.`id_producto`
    WHERE `fecha` = fechaConsulta
    ORDER BY v.`id_producto`;
END;

DELIMITER;

CALL listaProducto('2020-05-01')


/*

2.- Crear una función que calcule el valor nominal de un margen bruto determinado por el usuario a 
partir del precio de lista de los productos.

margenBruto = venta - coste_vienes

*/ 

SET GLOBAL log_bin_trust_function_creators = 1;

DROP FUNCTION IF EXISTS margenBruto;

DELIMITER $$
CREATE FUNCTION margenBruto(precio DECIMAL(15,3), margen DECIMAL (9,2)) RETURNS DECIMAL (15,3)
BEGIN
	DECLARE margenBruto DECIMAL (15,3);
    
    SET margenBruto = precio * margen;
    
    RETURN margenBruto;
END$$

DELIMITER;
-- Error: 1418 This function has none of DETERMINISTIC, NO SQL, or READS SQL DATA in its declaration and binary 
-- logging is enabled (you *might* want to use the less safe 
-- log_bin_trust_function_creators variable)

SELECT  c.`fecha`, 
        pr.`nombre`,
        p.`descripcion_producto`, 
        c.`precio`, 
        margenBruto(c.`precio`, 1.3)
    FROM `compra` c JOIN `producto` p 
    ON c.`id_producto` = p.`id_producto`
        JOIN `proveedor` pr
        ON c.`id_proveedor` = pr.`id_proveedor`;

SELECT 	`descripcion_producto`, 
		margenBruto(`precio`, 1.3) AS margen
FROM `producto`;

SELECT 	`id_producto`, 
		`precio` as precio_venta, 
        ROUND(precio * ( (100 + 10) /100 ), 2) AS precio_final
FROM `compra`;

DROP PROCEDURE IF EXISTS margenBrutoJ;

DELIMITER $$
CREATE PROCEDURE margenBrutoJ(IN porcent int)
BEGIN
    /*SELECT IdProducto, precio as PrecioVenta, ROUND(precio /((100 - porcent)/100),2) AS PrecioFinal
    FROM compra;
    */
    SELECT `id_producto`, `precio` AS `precio_compra`, ROUND(precio * ( (100 + porcent) /100 ), 2) AS `precio_venta`, (ROUND(precio * ( (100 + porcent) /100 ), 2) - `precio`) AS `margen_bruto`
    FROM `compra`;
END $$
DELIMITER;

CALL margenBrutoJ(30);

/*

3.- Obtner un listado de productos de IMPRESION y utilizarlo para cálcular el valor nominal de un 
margen bruto del 20% de cada uno de los productos.

*/

SELECT 	p.`id_producto`, 
		p.`descripcion_producto`,
        p.`precio` AS `precio_adquisicon`,
        margenBruto(p.`precio`, 1.2) AS precio_venta
FROM `producto` p JOIN `tipo_producto` tp
	ON (p.`id_tipo_producto` = tp.`id_tipo_producto`
		AND `descripcion` = 'Impresión');


/*

4.- Crear un procedimiento que permita listar los productos vendidos desde fact_inicial a partir de 
un "Tipo" que determine el usuario.

*/

SELECT  fv.*, 
        p.`descripcion_producto`, 
        tp.`descripcion` 
        FROM `fact_venta` fv JOIN `producto` p 
    ON fv.`id_producto` = p.`id_producto` JOIN `tipo_producto` tp 
    ON p.`id_tipo_producto` = tp.`id_tipo_producto`
    WHERE tp.`descripcion` = 'Audio';


DROP PROCEDURE IF EXISTS listaCategoría;

DELIMITER $$
CREATE PROCEDURE listaCategoría(IN tipoProducto VARCHAR(30))
BEGIN
    SELECT  v.*, 
            p.`descripcion_producto`, 
            tp.`descripcion` 
            FROM `venta` v JOIN `producto` p 
        ON v.`id_producto` = p.`id_producto` JOIN `tipo_producto` tp 
        ON p.`id_tipo_producto` = tp.`id_tipo_producto`
        WHERE tp.`descripcion` COLLATE utf8mb4_spanish_ci = tipoProducto AND v.`outlier` != 0;

END$$
DELIMITER;

CALL listaCategoria('Audio');

/*

5.- Crear un procedimiento que permita realizar la insercción de datos en la tabla fact_inicial.

*/


SELECT * FROM `fact_venta`;

DROP PROCEDURE IF EXISTS cargaFactVenta;
DELIMITER $$
CREATE PROCEDURE cargaFactVenta()
BEGIN
    TRUNCATE TABLE `fact_venta`;

    INSERT INTO `fact_venta` (`id_venta`, `fecha`, `fecha_entrega`, `id_canal`, `id_cliente`, `id_sucursal`, `id_empleado`, `id_producto`, `cantidad`)
    SELECT
        `id_venta`,
        `fecha`,
        `fecha_entrega`,
        `id_canal`,
        `id_cliente`,
        `id_sucursal`,
        `id_empleado`,
        `id_producto`,
        `cantidad`
    FROM `venta` 
    WHERE `outlier` = 1;

END$$
DELIMITER ;

CALL cargaFactVenta();

/*

6.- Crear un procedimiento almacenado que reciba un grupo etario y devuelta el total de ventas para ese grupo.

*/

SELECT  c.`rango_edad`,
        SUM((v.`cantidad` * p.`precio`)) AS `venta`
    FROM `venta` v JOIN `producto` p 
        ON v.`id_producto` = p.`id_producto` 
            JOIN `cliente` c 
                ON v.`id_cliente` = c.`id_cliente`
	GROUP BY c.`rango_edad`
    ORDER BY `venta`  DESC;


DROP PROCEDURE IF EXISTS listaGrupoEtario;

DELIMITER $$

CREATE PROCEDURE listaGrupoEtario(IN grupo VARCHAR(30))
BEGIN
    SELECT  c.`rango_edad`,
            SUM((v.`cantidad` * p.`precio`)) AS `venta`
        FROM `venta` v JOIN `producto` p 
            ON (v.`id_producto` = p.`id_producto`) 
                JOIN `cliente` c 
                    ON (v.`id_cliente` = c.`id_cliente` 
                        AND c.`rango_edad` COLLATE utf8mb4_spanish_ci LIKE CONCAT('%', grupo, '%'))
        GROUP BY c.`rango_edad`;
END$$
DELIMITER ;

CALL listaGrupoEtario('40');


/*

7.- Crear una variable que se pase como valor para realizar una filtro sobre Rango_etario en una consulta génerica a dim_cliente.

*/

SET @grupo = 'De 30 a 40';

SELECT * FROM `cliente`
WHERE `rango_edad` collate utf8mb4_spanish_ci LIKE @grupo LIMIT 10;
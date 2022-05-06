/* 
Prática 03

1.- Aplicar alguna técnica de detección de Outliers en la tabla ventas, sobre los campos Precio y 
Cantidad. Realizar diversas consultas para verificar la importancia de haber detectado Outliers. 
Por ejemplo ventas por sucursal en un período teniendo en cuenta outliers y descartándolos.

*/
-- Outliers de venta (precio*cantidad)


# Esta consulta muestra el promedio y el maximo de la columan precio para la unión de la tabla venta 
# y la tabla producto
SELECT v.`id_producto`, AVG(p.`precio`) AS `promedio`, AVG(p.`precio`) + (3 * STDDEV(p.`precio`)) AS `maximo`
    FROM `venta` v LEFT JOIN `producto` p
    ON v.`id_producto` = p.`id_producto`
    GROUP BY v.`id_producto`
    ORDER BY v.`id_producto`;

# Esta consulta muestra los campos v.`id_producto`, p.`descripcion_producto`, p.`precio`, v.`cantidad`
# para la unión de la tabla venta y la tabla producto
SELECT v.`id_producto`, p.`descripcion_producto`, p.`precio`, v.`cantidad`
    FROM `venta` v LEFT JOIN `producto` p
    ON v.`id_producto` = p.`id_producto`
    WHERE v.`id_producto` = 42890;

# Esta consulta muestra la venta (precio*cantidad) para la unión de la tabla venta 
# y la tabla producto
SELECT v.*, p.`precio`, ((v.`cantidad`)*(p.`precio`)) AS `venta`
    FROM `venta` v JOIN `producto` p
    ON v.`id_producto` = p.`id_producto`
    WHERE v.`id_producto` = 42737
    HAVING `venta` IS NOT NULL
    ORDER BY v.`id_producto`;

# Esta consulta muestra la venta (precio*cantidad) para la unión de la tabla venta 
# y la tabla producto
SELECT v.`id_venta`, p.`precio`, ((v.`cantidad`)*(p.`precio`)) AS `venta`
    FROM `venta` v JOIN `producto` p
    ON v.`id_producto` = p.`id_producto`
    HAVING `venta` IS NOT NULL
    ORDER BY v.`id_producto`;

# Esta consulta muestra los datos, el promedio y el maximo de la columan venta (precio*cantidad) para la unión de la tabla 
# venta y la tabla producto
SELECT ls.*, AVG(`venta`) AS `promedio`, (AVG(`venta`) + (3 * STDDEV(`venta`))) AS `maximo`
    FROM (SELECT v.*, p.`precio`, ((v.`cantidad`)*(p.`precio`)) AS `venta`
        FROM `venta` v JOIN `producto` p
        ON v.`id_producto` = p.`id_producto`
        HAVING `venta` IS NOT NULL
        ORDER BY v.`id_producto`) ls
    #WHERE `id_producto` = 42737;
    GROUP BY `id_producto`;

# Esta consulta muestra el id_producto, el promedio y el maximo de la columan venta (precio*cantidad) para la unión de la tabla 
# venta y la tabla producto
SELECT `id_producto`, AVG(`venta`) AS `promedio`, (AVG(`venta`) + (3 * STDDEV(`venta`))) AS `maximo`
    FROM (SELECT v.*, p.`precio`, ((v.`cantidad`)*(p.`precio`)) AS `venta`
        FROM `venta` v JOIN `producto` p
        ON v.`id_producto` = p.`id_producto`
        HAVING `venta` IS NOT NULL
        ORDER BY v.`id_producto`) ls
    #WHERE `id_producto` = 42737;
    GROUP BY `id_producto`;

# Esta consulta muestra la columan venta (precio*cantidad) para cada id_venta en la unión de la tabla 
# venta y la tabla producto
SELECT v1.`id_venta`, v1.`id_producto`, v1.`cantidad`, vv.`precio`, vv.`venta` FROM `venta` v1
    JOIN (SELECT v2.`id_venta`, p.`precio`, ((v2.`cantidad`)*(p.`precio`)) AS `venta`
        FROM `venta` v2 JOIN `producto` p
        ON v2.`id_producto` = p.`id_producto`
        HAVING `venta` IS NOT NULL
        ORDER BY v2.`id_producto`) AS vv
    ON v1.`id_venta` = vv.`id_venta`;

# Esta consulta muestra la columan venta (precio*cantidad) para cada id_producto en la unión de la tabla 
# venta y la tabla producto
SELECT ls.`id_producto`, AVG(ls.`venta`) AS `promedio`, (AVG(ls.`venta`) + (3 * STDDEV(ls.`venta`))) AS `maximo`
    FROM (SELECT v2.`id_producto`, v2.`id_venta`, p.`precio`, ((v2.`cantidad`)*(p.`precio`)) AS `venta`
        FROM `venta` v2 JOIN `producto` p
        ON v2.`id_producto` = p.`id_producto`
        HAVING `venta` IS NOT NULL
        ORDER BY v2.`id_producto`) AS ls
    GROUP BY ls.`id_producto`;

# Esta consulta muestra los campos `id_venta`, `id_producto`, `cantidad`, `precio`, `venta`, `promedio`, `maximo`
# para la unión de la tabla venta y producto, con coincidencias para el campo id_producto
SELECT v1.`id_venta`, v1.`id_producto`, v1.`cantidad`, vv.`precio`, vv.`venta`, ls.`promedio`, ls.`maximo` FROM `venta` v1
    JOIN (SELECT v2.`id_venta`, p.`precio`, ((v2.`cantidad`)*(p.`precio`)) AS `venta`
        FROM `venta` v2 JOIN `producto` p
        ON v2.`id_producto` = p.`id_producto`
        HAVING `venta` IS NOT NULL
        ORDER BY v2.`id_producto`) AS vv
    ON v1.`id_venta` = vv.`id_venta`
    JOIN (SELECT med_ls.`id_producto`, AVG(med_ls.`venta`) AS `promedio`, (AVG(med_ls.`venta`) + (3 * STDDEV(med_ls.`venta`))) AS `maximo`
        FROM (SELECT v2.`id_producto`, v2.`id_venta`, p.`precio`, ((v2.`cantidad`)*(p.`precio`)) AS `venta`
            FROM `venta` v2 JOIN `producto` p
            ON v2.`id_producto` = p.`id_producto`
            HAVING `venta` IS NOT NULL
            ORDER BY v2.`id_producto`) AS med_ls
        GROUP BY med_ls.`id_producto`) AS ls
    ON v1.`id_producto` = ls.`id_producto`
    WHERE vv.`venta` >  ls.`maximo`;

# Esta consulta muestra todos los campos para la unión de la tabla venta y producto, con coincidencias 
# para el campo id_producto
SELECT  v1.`id_venta`,
        v1.`fecha`,
        v1.`fecha_entrega`,
        v1.`id_canal`,
        v1.`id_sucursal`,
        v1.`id_empleado`,
        v1.`id_producto`, 
        v1.`cantidad`, 
        vv.`precio`, 
        vv.`venta`, 
        ls.`promedio`, 
        ls.`maximo` 
    FROM `venta` v1
    JOIN (SELECT    v2.`id_venta`, 
                    p.`precio`, 
                    ((v2.`cantidad`)*(p.`precio`)) AS `venta`
        FROM `venta` v2 JOIN `producto` p
        ON v2.`id_producto` = p.`id_producto`
        HAVING `venta` IS NOT NULL
        ORDER BY v2.`id_producto`) AS vv
    ON v1.`id_venta` = vv.`id_venta`
    JOIN (SELECT    med_ls.`id_producto`, 
                    AVG(med_ls.`venta`) AS `promedio`, 
                    (AVG(med_ls.`venta`) + (3 * STDDEV(med_ls.`venta`))) AS `maximo`
        FROM (SELECT    v2.`id_producto`, 
                        v2.`id_venta`, p.`precio`, 
                        ((v2.`cantidad`)*(p.`precio`)) AS `venta`
            FROM `venta` v2 JOIN `producto` p
            ON v2.`id_producto` = p.`id_producto`
            HAVING `venta` IS NOT NULL
            ORDER BY v2.`id_producto`) AS med_ls
        GROUP BY med_ls.`id_producto`) AS ls
    ON v1.`id_producto` = ls.`id_producto`
    WHERE vv.`venta` >  ls.`maximo`;


SELECT * FROM aux_venta;

-- Guardar los outliers en la tabla aux_venta con motivo -> 2

# motivo -> 1: Error devido a problemas en el campo cantidad.
# motivo -> 2: Outlier.

INSERT INTO `aux_venta`(`id_venta`, 
                        `fecha`, 
                        `fecha_entrega`, 
                        `id_canal`, 
                        `id_sucursal`, 
                        `id_empleado`, 
                        `id_producto`, 
                        `cantidad`)
	SELECT  v1.`id_venta`,
        v1.`fecha`,
        v1.`fecha_entrega`,
        v1.`id_canal`,
        v1.`id_sucursal`,
        v1.`id_empleado`,
        v1.`id_producto`, 
        v1.`cantidad` 
        #vv.`precio`, 
        #vv.`venta`, 
        #ls.`promedio`, 
        #ls.`maximo` 
    FROM `venta` v1
    JOIN (SELECT    v2.`id_venta`, 
                    p.`precio`, 
                    ((v2.`cantidad`)*(p.`precio`)) AS `venta`
        FROM `venta` v2 JOIN `producto` p
        ON v2.`id_producto` = p.`id_producto`
        HAVING `venta` IS NOT NULL
        ORDER BY v2.`id_producto`) AS vv
    ON v1.`id_venta` = vv.`id_venta`
    JOIN (SELECT    med_ls.`id_producto`, 
                    AVG(med_ls.`venta`) AS `promedio`, 
                    (AVG(med_ls.`venta`) + (3 * STDDEV(med_ls.`venta`))) AS `maximo`
        FROM (SELECT    v2.`id_producto`, 
                        v2.`id_venta`, p.`precio`, 
                        ((v2.`cantidad`)*(p.`precio`)) AS `venta`
            FROM `venta` v2 JOIN `producto` p
            ON v2.`id_producto` = p.`id_producto`
            HAVING `venta` IS NOT NULL
            ORDER BY v2.`id_producto`) AS med_ls
        GROUP BY med_ls.`id_producto`) AS ls
    ON v1.`id_producto` = ls.`id_producto`
    WHERE vv.`venta` >  ls.`maximo`;

UPDATE `aux_venta` SET `motivo` = 2 WHERE `cantidad` != CHAR(10) + CHAR(13);

-- Crear el campo outlier para la tabla venta con:

ALTER TABLE `venta` ADD `outlier` TINYINT NOT NULL DEFAULT '1' AFTER `Cantidad`;

SELECT * FROM `venta`;

UPDATE `venta` v JOIN `aux_venta` a
	ON (v.`id_venta` = a.`id_venta` AND a.`motivo` = 2)
SET v.`outlier` = 0;

# 1- No es un outlier
# 0- Es un outlier

/* 

2.- Es necesario armar un proceso, mediante el cual podamos integrar todas las fuentes, aplicar las 
transformaciones o reglas de negocio necesarias a los datos y generar el modelo final que va a ser 
consumido desde los reportes. Este proceso debe ser claro y autodocumentado. 
¿Se puede armar un esquema, donde sea posible detectar con mayor facilidad futuros errores en los datos?

*/







/* 
EJEMPLO SCRIP PARA VOLVER A CRAER LA TABLA VENTA
-- crear tabla venta.

DROP TABLE IF EXISTS `venta`;
CREATE TABLE IF NOT EXISTS `venta` (
  `id_venta`				INTEGER,
  `fecha` 				DATE NOT NULL,
  `fecha_entrega` 		DATE NOT NULL,
  `id_canal`				INTEGER, 
  `id_cliente`			INTEGER, 
  `id_sucursal`			INTEGER,
  `id_empleado`			INTEGER,
  `id_producto`			INTEGER,
  `precio`				VARCHAR(30),
  `cantidad`			VARCHAR(30)
  -- `precio`			DECIMAL(10,2),
  -- `cantidad`			INTEGER
  -- eliminar: `precio`
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- cargar datos del csv.

LOAD DATA INFILE '\Venta.csv' 
INTO TABLE `venta` 
FIELDS TERMINATED BY ',' ENCLOSED BY '' ESCAPED BY '' 
LINES TERMINATED BY '\n' IGNORE 1 LINES;

-- crear tabla aux_venta.

DROP TABLE IF EXISTS `aux_venta`;
CREATE TABLE IF NOT EXISTS `aux_venta` (
  `id_venta`				INTEGER,
  `fecha` 				DATE NOT NULL,
  `fecha_entrega` 		DATE NOT NULL,
  `id_canal`				INTEGER, 
  `id_cliente`			INTEGER, 
  `id_sucursal`			INTEGER,
  `id_empleado`			INTEGER,
  `id_producto`			INTEGER,
  `precio`				VARCHAR(30),
  `cantidad`			VARCHAR(30)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- Identificar los campos vacios en la culumna cantidad y almacenarlos en la tabla aux_venta.

SELECT * FROM `venta` WHERE `cantidad` = CHAR(10) + CHAR(13);

INSERT INTO `aux_venta` 
	SELECT * FROM `venta` WHERE `cantidad` = CHAR(10) + CHAR(13);

SELECT * FROM `aux_venta`;

-- crear columna: motivo en la tabla aux_venta.

ALTER TABLE `aux_venta` ADD `motivo` INTEGER DEFAULT 0;

SELECT * FROM `aux_venta`;

SET SQL_SAFE_UPDATES = 0;

UPDATE `aux_venta` SET `motivo` = 1 WHERE `cantidad` = CHAR(10) + CHAR(13);

SELECT * FROM `aux_venta`;

-- Identificar los campos vacios en la culumna cantidad y reemplazar con valores nulos.

UPDATE `venta` SET `cantidad` = NULl WHERE `cantidad` = CHAR(10) + CHAR(13);

-- Cambiar el tipo de dato de la columna cantidad en la tabla venta

ALTER TABLE `venta` MODIFY `cantidad` INTEGER;

-- Eliminar columan precio de la tabla `venta`.

ALTER TABLE `venta` DROP `precio`;

-- Eliminar columan precio de la tabla `aux_venta`.

ALTER TABLE `aux_venta` DROP `precio`;

-- descripcion_error -> 1: Error devido a problemas en el campo cantidad.
-- descripcion_error -> 2: Outlier.

SELECT * FROM `venta`;

SELECT * FROM `venta` WHERE `cantidad` = CHAR(10) + CHAR(13);

SELECT * FROM `aux_venta`;


SELECT  v1.`id_venta`,
        v1.`fecha`,
        v1.`fecha_entrega`,
        v1.`id_canal`,
        v1.`id_sucursal`,
        v1.`id_empleado`,
        v1.`id_producto`, 
        v1.`cantidad`, 
        vv.`precio`, 
        vv.`venta`, 
        ls.`promedio`, 
        ls.`maximo` 
    FROM `venta` v1
    JOIN (SELECT    v2.`id_venta`, 
                    p.`precio`, 
                    ((v2.`cantidad`)*(p.`precio`)) AS `venta`
        FROM `venta` v2 JOIN `producto` p
        ON v2.`id_producto` = p.`id_producto`
        HAVING `venta` IS NOT NULL
        ORDER BY v2.`id_producto`) AS vv
    ON v1.`id_venta` = vv.`id_venta`
    JOIN (SELECT    med_ls.`id_producto`, 
                    AVG(med_ls.`venta`) AS `promedio`, 
                    (AVG(med_ls.`venta`) + (3 * STDDEV(med_ls.`venta`))) AS `maximo`
        FROM (SELECT    v2.`id_producto`, 
                        v2.`id_venta`, p.`precio`, 
                        ((v2.`cantidad`)*(p.`precio`)) AS `venta`
            FROM `venta` v2 JOIN `producto` p
            ON v2.`id_producto` = p.`id_producto`
            HAVING `venta` IS NOT NULL
            ORDER BY v2.`id_producto`) AS med_ls
        GROUP BY med_ls.`id_producto`) AS ls
    ON v1.`id_producto` = ls.`id_producto`
    WHERE vv.`venta` >  ls.`maximo`;


INSERT INTO `aux_venta`(`id_venta`, `fecha`, fecha_entrega, id_canal, id_sucursal, id_empleado, id_producto, cantidad)
	SELECT  v1.`id_venta`,
        v1.`fecha`,
        v1.`fecha_entrega`,
        v1.`id_canal`,
        v1.`id_sucursal`,
        v1.`id_empleado`,
        v1.`id_producto`, 
        v1.`cantidad` 
        #vv.`precio`, 
        #vv.`venta`, 
        #ls.`promedio`, 
        #ls.`maximo` 
    FROM `venta` v1
    JOIN (SELECT    v2.`id_venta`, 
                    p.`precio`, 
                    ((v2.`cantidad`)*(p.`precio`)) AS `venta`
        FROM `venta` v2 JOIN `producto` p
        ON v2.`id_producto` = p.`id_producto`
        HAVING `venta` IS NOT NULL
        ORDER BY v2.`id_producto`) AS vv
    ON v1.`id_venta` = vv.`id_venta`
    JOIN (SELECT    med_ls.`id_producto`, 
                    AVG(med_ls.`venta`) AS `promedio`, 
                    (AVG(med_ls.`venta`) + (3 * STDDEV(med_ls.`venta`))) AS `maximo`
        FROM (SELECT    v2.`id_producto`, 
                        v2.`id_venta`, p.`precio`, 
                        ((v2.`cantidad`)*(p.`precio`)) AS `venta`
            FROM `venta` v2 JOIN `producto` p
            ON v2.`id_producto` = p.`id_producto`
            HAVING `venta` IS NOT NULL
            ORDER BY v2.`id_producto`) AS med_ls
        GROUP BY med_ls.`id_producto`) AS ls
    ON v1.`id_producto` = ls.`id_producto`
    WHERE vv.`venta` >  ls.`maximo`;
    
SELECT * FROM `aux_venta`;

UPDATE `aux_venta` SET `motivo` = 2 WHERE `cantidad` != CHAR(10) + CHAR(13);
*/
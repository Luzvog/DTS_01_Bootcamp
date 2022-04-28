USE henry_m3;

/* 
6. Normalizar los nombres de los campos y colocar el tipo de 
dato adecuado para cada uno en cada una de las tablas. 
Descartar columnas que consideres que no tienen relevancia. 
*/


/* modificar tipo de datos */

-- tabla: `venta`
-- campo: `cantidad`	    INTEGER

-- creo un nuevo campo llamado aux_venta
-- paso los datos de canitdad a aux_cantidad
-- borro la columna cantidad
-- cambio el nombre a la columna aux_cantidad por cantidad


ALTER TABLE `venta` ADD `aux_cantidad` INTEGER;

SHOW FULL COLUMNS FROM `venta`;

SET SQL_SAFE_UPDATES = 0;

SELECT * FROM `venta` 
WHERE `id_venta` = 72;

UPDATE `venta` SET `cantidad` = NULL WHERE `id_venta` = 72;

SELECT * FROM `venta` 
WHERE `id_venta` = 105;

UPDATE `venta` SET `cantidad` = NULL WHERE `id_venta` = 105;

SELECT * FROM `venta` 
WHERE `id_venta` = 154;

UPDATE `venta` SET `cantidad` = NULL WHERE `id_venta` = 154;

SELECT * FROM `venta` 
WHERE `id_venta` = 183;

UPDATE `venta` SET `cantidad` = NULL WHERE `id_venta` = 183;

SELECT * FROM `venta` 
WHERE `id_venta` = 190;


UPDATE `venta` SET `cantidad` = NULL WHERE `id_venta` = 190;

SELECT * FROM `venta`;

SELECT * FROM `venta` 
WHERE `cantidad` = CHAR(10) + CHAR(13);

UPDATE `venta`  SET `cantidad` = NULL WHERE `cantidad` = CHAR(10) + CHAR(13);

UPDATE `venta`	SET `aux_cantidad` = `cantidad`;

SELECT * FROM `venta`;

ALTER TABLE `venta` DROP COLUMN `cantidad`;

ALTER TABLE `venta` RENAME COLUMN `aux_cantidad` TO `cantidad`;

SELECT * FROM `venta`;

SHOW FULL COLUMNS FROM `venta`;

-- tabla: `tipo_gasto`
-- campo: `id_tipo_gasto`   INTEGER

ALTER TABLE `tipo_gasto` MODIFY `id_tipo_gasto` INTEGER;

-- tabla: `producto`
-- campo: `precio`       DECIMAL(10,2)
-- campo: `concepto` => `descripcion_producto` 

SELECT MAX(CHAR_LENGTH(`concepto`)) FROM `producto`;

-- CHAR_LENGTH = 12

ALTER TABLE `producto` MODIFY `precio` DECIMAL(15,2);

ALTER TABLE `producto` RENAME COLUMN `concepto` TO `descripcion_producto`;

-- tabla: `empleado`
-- campo: `salario`       DECIMAL(10,2)

ALTER TABLE `empleado` MODIFY `salario` DECIMAL(10,2);

SHOW FULL COLUMNS FROM `empleado`;

/* eliminar campo */

-- tabla: `compra`
-- campo: `precio`

ALTER TABLE `compra` DROP COLUMN `precio`;

-- tabla: `venta`
-- campo: `precio`

ALTER TABLE `venta` DROP COLUMN `precio`;

-- tabla: `cliente`
-- campo: `x`
-- campo: `y`
-- campo: `col10`

ALTER TABLE `cliente` DROP COLUMN `x`;
ALTER TABLE `cliente` DROP COLUMN `y`;
ALTER TABLE `cliente` DROP COLUMN `col10`;

-- tabla: `sucursal`
-- campo: `latitud`
-- campo: `longitud`


ALTER TABLE `sucursal` DROP COLUMN `latitud`;
ALTER TABLE `sucursal` DROP COLUMN `longitud`;

/* 
7. Buscar valores faltantes y campos inconsistentes en las 
tablas sucursal, proveedor, empleado y cliente. De encontrarlos, 
deberás corregirlos o desestimarlos.
*/

-- tabla sucursal

SELECT * FROM `sucursal`;
	#WHERE id_sucursal IS NULL OR id_sucursal = ' ';
    #OR sucursal IS NULL OR sucursal = ' ';
	#OR domicilio IS NULL OR domicilio = ' ';
    #OR localidad IS NULL OR localidad = ' ';
    #OR provincia IS NULL OR localidad = ' ';
    #OR latitud IS NULL OR localidad = ' ';
    #OR longitud IS NULL OR localidad = ' ';

-- No hay registros faltantes o inconsistentes en la tabla sucursal

-- tabla proveedor

SELECT * FROM `proveedor`;
    #WHERE `id_proveedor` IS NULL OR `id_proveedor` = ' ';
    #OR `nombre` IS NULL OR `nombre` = ' ';
	#OR `domicilio` IS NULL OR `domicilio` = ' ';
    #OR `ciudad` IS NULL OR `ciudad` = ' ';
    #OR `provincia` IS NULL OR `provincia` = ' ';
    #OR `pais` IS NULL OR `pais` = ' ';
    #OR `departamento` IS NULL OR `departamento` = ' ';
    
-- Hay 2 registros faltantes en la columna nombre

-- tabla empleado

SELECT * FROM `empleado`;
	#WHERE `id_empleado` IS NULL OR TRIM(`id_empleado`) = '';
    #OR `apellido` IS NULL OR TRIM(`apellido`) = '';
    #OR `nombre` IS NULL OR TRIM(`nombre`) = '';
    #OR `sucursal` IS NULL OR TRIM(`sucursal`) = '';
    #OR `sector` IS NULL OR TRIM(`sector`) = '';
    #OR `cargo` IS NULL OR TRIM(`cargo`) = '';
    #OR `salario` IS NULL OR TRIM(`sucursal`) = '';

-- No hay registros faltantes o inconsistentes en la tabla empleado

-- tabla cliente

SELECT * FROM `cliente`;
	#WHERE `id_cliente` IS NULL OR `id_cliente` = '';
    #OR `provincia` IS NULL OR `provincia` = '';
    #OR `nombre_apellido` IS NULL OR `nombre_apellido` = '';
    #OR `domicilio` IS NULL OR `domicilio` = '';
    #OR `telefono` IS NULL OR `telefono` = '';
    #OR `edad` IS NULL OR `edad` = '';
    #OR `localidad` IS NULL OR `localidad` = '';
    #OR `x` IS NULL OR `x` = '';
    #OR `y` IS NULL OR `y` = '';
    
-- Hay 31 registros faltantes en la columna `provincia`
-- Hay 46 registros faltantes en la columna `nombre_apellido`
-- Hay 48 registros faltantes en la columna `domicilio`
-- Hay 90 registros faltantes en la columna `telefono`
-- Hay 32 registros faltantes en la columna `localidad`
-- Hay 62 registros faltantes en la columna `x`
-- Hay 60 registros faltantes en la columna `y`

DROP TABLE IF EXISTS `aux_cliente`;
CREATE TABLE IF NOT EXISTS `aux_cliente` (
	`id_cliente`					INTEGER,
	`provincia`			VARCHAR(50),
	`nombre_apellido`	VARCHAR(80),
	`domicilio`			VARCHAR(150),
	`telefono`			VARCHAR(30),
	`edad`				VARCHAR(5),
	`localidad`			VARCHAR(80),
	`x`			VARCHAR(30),
	`y`			VARCHAR(30),
	`col10`				VARCHAR(1)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO `aux_cliente`
	SELECT * FROM `cliente` WHERE `id_cliente` IS NULL OR TRIM(`id_cliente`) = ''
    OR `provincia` IS NULL OR TRIM(`provincia`) = ''
    OR `nombre_apellido` IS NULL OR TRIM(`nombre_apellido`) = ''
    OR `domicilio` IS NULL OR TRIM(`domicilio`) = ''
    OR `telefono` IS NULL OR TRIM(`telefono`) = ''
    OR `edad` IS NULL OR TRIM(`edad`) = ''
    OR `localidad` IS NULL OR TRIM(`localidad`) = ''
    OR `x` IS NULL OR TRIM(`x`) = ''
    OR `y` IS NULL OR TRIM(`y`) = '';
    
ALTER TABLE `aux_cliente` DROP COLUMN `col10`;

SELECT * FROM aux_cliente;

SET SQL_SAFE_UPDATES = 0;

UPDATE `aux_cliente`
	SET
		`provincia` = CASE WHEN TRIM(`provincia`) = "" OR ISNULL(`provincia`) THEN 'Sin Dato' ELSE `provincia` END,
		`nombre_apellido` = CASE WHEN TRIM(`nombre_apellido`) = "" OR ISNULL(`nombre_apellido`) THEN 'Sin Dato' ELSE `nombre_apellido` END,
		`domicilio` = CASE WHEN TRIM(`domicilio`) = "" OR ISNULL(`domicilio`) THEN 'Sin Dato' ELSE `domicilio` END,
		`telefono` = CASE WHEN TRIM(`telefono`) = "" OR ISNULL(`provincia`) THEN 'Sin Dato' ELSE `provincia` END,
		`localidad` = CASE WHEN TRIM(`localidad`) = "" OR ISNULL(`localidad`) THEN 'Sin Dato' ELSE `localidad` END,
		`x` = CASE WHEN TRIM(`x`) = "" OR ISNULL(`x`) THEN '0' ELSE `x` END,
		`y` = CASE WHEN TRIM(`y`) = "" OR ISNULL(`y`) THEN '0' ELSE `y` END;
        
UPDATE `cliente`
	SET
		`provincia` = CASE WHEN TRIM(`provincia`) = "" OR ISNULL(`provincia`) THEN 'Sin Dato' ELSE `provincia` END,
		`nombre_apellido` = CASE WHEN TRIM(`nombre_apellido`) = "" OR ISNULL(`nombre_apellido`) THEN 'Sin Dato' ELSE `nombre_apellido` END,
		`domicilio` = CASE WHEN TRIM(`domicilio`) = "" OR ISNULL(`domicilio`) THEN 'Sin Dato' ELSE `domicilio` END,
		`telefono` = CASE WHEN TRIM(`telefono`) = "" OR ISNULL(`provincia`) THEN 'Sin Dato' ELSE `provincia` END,
		`localidad` = CASE WHEN TRIM(`localidad`) = "" OR ISNULL(`localidad`) THEN 'Sin Dato' ELSE `localidad` END,
		`x` = CASE WHEN TRIM(`x`) = "" OR ISNULL(`x`) THEN '0' ELSE `x` END,
		`y` = CASE WHEN TRIM(`y`) = "" OR ISNULL(`y`) THEN '0' ELSE `y` END;
        
SELECT * FROM `cliente`;

DROP TABLE IF EXISTS `aux_proveedor`;
CREATE TABLE IF NOT EXISTS `aux_proveedor` (
	`id_proveedor`		INTEGER,
	`nombre`			VARCHAR(80),
	`domicilio`		VARCHAR(150),
	`ciudad`			VARCHAR(80),
	`provincia`		VARCHAR(50),
	`pais`			VARCHAR(20),
	`departamento`	VARCHAR(80)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;


INSERT INTO `aux_proveedor`
	SELECT * FROM `proveedor`
    WHERE `nombre` IS NULL OR TRIM(`nombre`) = '';

SELECT * FROM `aux_proveedor`;

UPDATE `aux_proveedor`  SET `nombre` = 'Sin Dato' 
	WHERE `nombre` IS NULL OR TRIM(`nombre`) = '';
    
SELECT * FROM `aux_proveedor`;

UPDATE `proveedor`  SET `nombre` = 'Sin Dato' 
	WHERE `nombre` IS NULL OR TRIM(`nombre`) = '';

SELECT * FROM `proveedor`;

/* 
8. Chequear la consistencia de los campos precio y cantidad de la tabla de ventas.
*/




/* 
9. Utilizar la funcion provista 'UC_Words' para modificar a letra capital los campos que contengan descripciones para todas las tablas.
*/

SELECT * FROM `cliente`;

SELECT * FROM `compra`;

SELECT * FROM `gasto`;

SELECT * FROM `sucursal`;

SELECT * FROM `tipo_gasto`;

SELECT * FROM `venta`;

SELECT * FROM `canal_venta`;

SELECT * FROM `empleado`;

SELECT * FROM `producto`;

SELECT * FROM `proveedores`;


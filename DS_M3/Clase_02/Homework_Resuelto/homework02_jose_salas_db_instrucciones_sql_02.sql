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

/*
13. Es necesario contar con una tabla de localidades 
del país con el fin de evaluar la apertura de una nueva sucursal 
y mejorar nuestros datos. A partir de los datos en las tablas cliente, 
sucursal y proveedor hay que generar una tabla definitiva de Localidades 
y Provincias. Utilizando la nueva tabla de Localidades controlar y corregir (Normalizar) 
los campos Localidad y Provincia de las tablas cliente, sucursal y proveedor.


*/


-- Crar una tabla auxiliar en la cual se puedan modificar los datos de formar independitne:(provincia_original, localidad_origina, provincia_modificado, localidad_modificado,id_localidad)
/*
SELECT DISTINCT `localidad`, `provincia`, `localidad`, `provincia`, 0 FROM `cliente`
UNION
SELECT DISTINCT `localidad`, `provincia`, `localidad`, `provincia`, 0 FROM `sucursal`
UNION
SELECT DISTINCT `ciudad`, `provincia`, `ciudad`, `provincia`, 0 FROM `proveedor`
ORDER BY 2, 1;

CREATE TABLE IF NOT EXISTS `aux_localidad` (
	`localidad_original`	VARCHAR(80),
	`provincia_original`	VARCHAR(50),
	`localidad_normalizada`	VARCHAR(80),
	`provincia_normalizada`	VARCHAR(50),
	`id_localidad`			INTEGER
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

*/

-- Rellenar la tabla auxiliar

/*
INSERT INTO `aux_localidad` (`localidad_original`, `provincia_original`, `localidad_normalizada`, `provincia_normalizada`, `id_localidad`)
SELECT DISTINCT `localidad`, `provincia`, `localidad`, `provincia`, 0 FROM `cliente`
UNION
SELECT DISTINCT `localidad`, `provincia`, `localidad`, `provincia`, 0 FROM `sucursal`
UNION
SELECT DISTINCT `ciudad`, `provincia`, `ciudad`, `provincia`, 0 FROM `proveedor`
ORDER BY 2, 1;
*/

-- Normalizar las tablas: surcursal(localidad, provincia), cliente(localidad, provincia), proveerdor(cidudad, provincia).
-- Crear dos tablas: tabla provincia (id_provincia, provincia), tabla localidad (id_localidad, localidad, id_provincia).
-- Llenar las tablas.
-- Modificar las tablas surcursal(localidad, provincia), cliente(localidad, provincia), proveerdor(cidudad, provincia) para acceder a la entidad geografia de mayor jerarquia mediante de la localidad.



SELECT * FROM `cliente`;
SELECT DISTINCT(`localidad`) FROM `cliente`;
SELECT * FROM `sucursal`;
SELECT DISTINCT(`provincia`) FROM `sucursal`;
SELECT * FROM `proveedor`;
SELECT DISTINCT(`ciudad`) FROM `proveedor`;

SELECT DISTINCT `localidad`, `provincia`, `localidad`, `provincia`, 0 FROM `cliente`
UNION
SELECT DISTINCT `localidad`, `provincia`, `localidad`, `provincia`, 0 FROM `sucursal`
UNION
SELECT DISTINCT `ciudad`, `provincia`, `ciudad`, `provincia`, 0 FROM `proveedor`
ORDER BY 2, 1;

DROP TABLE IF EXISTS `aux_localidad`;
CREATE TABLE IF NOT EXISTS `aux_localidad` (
	`localidad_original`	VARCHAR(80),
	`provincia_original`	VARCHAR(50),
	`localidad_normalizada`	VARCHAR(80),
	`provincia_normalizada`	VARCHAR(50),
	`id_localidad`			INTEGER
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

SELECT * FROM `aux_localidad`;

INSERT INTO `aux_localidad` (`localidad_original`, `provincia_original`, `localidad_normalizada`, `provincia_normalizada`, `id_localidad`)
SELECT DISTINCT `localidad`, `provincia`, `localidad`, `provincia`, 0 FROM `cliente`
UNION
SELECT DISTINCT `localidad`, `provincia`, `localidad`, `provincia`, 0 FROM `sucursal`
UNION
SELECT DISTINCT `ciudad`, `provincia`, `ciudad`, `provincia`, 0 FROM `proveedor`
ORDER BY 2, 1;

SELECT * FROM `aux_localidad`;

UPDATE `aux_localidad` SET provincia_normalizada = 'Buenos Aires'
WHERE provincia_original IN ('Caba',
                             'C Debuenos Aires',
                             'Bs As',
                             'Bs.As.',
                             'Buenos Aires',
                             'B. Aires',
                             'B.Aires',
                             'Provincia De Buenos Aires',
                             'Prov De Bs As',
                             'Ciudad De Buenos Aires',
                             'Pcia Bs As',
                             'Pcia Bs As',
                             'Prov De Bs As.');

SELECT DISTINCT(`provincia_normalizada`) FROM `aux_localidad`;

UPDATE `aux_localidad` SET `localidad_normalizada` = 'Capítal Federal'
WHERE `localidad_original` IN ('Boca De Atencion Monte Castro',
                            'Caba',
                            'Cap.   Federal',
                            'Cap. Fed.',
                            'Capfed',
                            'Capital',
                            'Capital Federal',
                            'Cdad De Buenos Aires',
                            'Ciudad De Buenos Aires')
AND `provincia_normalizada` = 'Buenos Aires';

SELECT DISTINCT(`localidad_normalizada`) FROM `aux_localidad` ORDER BY `localidad_normalizada`;

UPDATE `aux_localidad` SET localidad_normalizada = 'Córdoba'
WHERE localidad_original IN ('Coroba',
                            'Cordoba',
							'Cã³rdoba')
AND provincia_normalizada = 'Córdoba';

DROP TABLE IF EXISTS `localidad`;
CREATE TABLE IF NOT EXISTS `localidad` (
  `id_localidad` int(11) NOT NULL AUTO_INCREMENT,
  `localidad` varchar(80) NOT NULL,
  `provincia` varchar(80) NOT NULL,
  `id_provincia` int(11) NOT NULL,
  PRIMARY KEY (`id_localidad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

DROP TABLE IF EXISTS `provincia`;
CREATE TABLE IF NOT EXISTS `provincia` (
  `id_provincia` int(11) NOT NULL AUTO_INCREMENT,
  `provincia` varchar(50) NOT NULL,
  PRIMARY KEY (`id_provincia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

SELECT	DISTINCT localidad_normalizada, provincia_normalizada, 0
FROM aux_localidad
ORDER BY provincia_normalizada, localidad_normalizada;

SELECT DISTINCT provincia_normalizada
FROM aux_localidad
ORDER BY provincia_normalizada;

INSERT INTO localidad (localidad, provincia, id_provincia)
SELECT	DISTINCT localidad_normalizada, provincia_normalizada, 0
FROM aux_localidad
ORDER BY provincia_normalizada, localidad_normalizada;

SELECT * FROM `localidad`;

INSERT INTO provincia (provincia)
SELECT DISTINCT Provincia_Normalizada
FROM aux_localidad
ORDER BY Provincia_Normalizada;

SELECT * FROM `provincia`;

UPDATE localidad l JOIN provincia p
	ON (l.provincia = p.provincia)
SET l.id_provincia = p.id_provincia;

SELECT * FROM `aux_localidad`;

UPDATE aux_localidad a JOIN localidad l 
			ON (l.localidad = a.localidad_normalizada
                AND a.provincia_normalizada = l.provincia)
SET a.id_localidad = l.id_localidad;

ALTER TABLE `cliente` ADD `id_localidad` INT NOT NULL DEFAULT '0' AFTER `localidad`;
ALTER TABLE `proveedor` ADD `id_localidad` INT NOT NULL DEFAULT '0' AFTER `departamento`;

UPDATE cliente c JOIN aux_localidad a
	ON (c.provincia = a.provincia_original AND c.localidad = a.localidad_original)
SET c.id_localidad = a.id_localidad;

UPDATE sucursal s JOIN aux_localidad a
	ON (s.provincia = a.provincia_original AND s.localidad = a.localidad_original)
SET s.id_localidad = a.id_localidad;

UPDATE proveedor p JOIN aux_localidad a
	ON (p.provincia = a.provincia_original AND p.ciudad = a.localidad_original)
SET p.id_localidad = a.id_localidad;

SELECT * FROM `cliente`;

SELECT * FROM `sucursal`;

SELECT * FROM `proveedor`;

ALTER TABLE `cliente`
  DROP `Provincia`,
  DROP `Localidad`;

ALTER TABLE `proveedor`
  DROP `Ciudad`,
  DROP `Provincia`,
  DROP `Pais`,
  DROP `Departamento`;

ALTER TABLE `sucursal`
  DROP `Localidad`,
  DROP `Provincia`;
  
ALTER TABLE `localidad`
  DROP `Provincia`;

SELECT * FROM `cliente`;
SELECT * FROM `proveedor`;
SELECT * FROM `sucursal`;
SELECT * FROM `localidad`;
SELECT * FROM `provincia`;



# Item 14 <--------
SELECT * FROM `cliente`;

ALTER TABLE cliente ADD rango_edad VARCHAR(50) NOT NULL DEFAULT 'Sin dato' AFTER edad;
UPDATE cliente SET rango_edad = 'De 10 a 20' WHERE edad >= 10 AND edad <= 20;
UPDATE cliente SET rango_edad = 'De 20 a 30' WHERE edad >= 20 AND edad <= 30;
UPDATE cliente SET rango_edad = 'De 30 a 40' WHERE edad >= 30 AND edad <= 40;
UPDATE cliente SET rango_edad = 'De 40 a 50' WHERE edad >= 40 AND edad <= 50;
UPDATE cliente SET rango_edad = 'De 50 A 60' WHERE edad >= 50 AND edad <= 60;
UPDATE cliente SET rango_edad = 'De 60 a 70' WHERE edad >= 60 AND edad <= 70;

ALTER TABLE cliente DROP edad;
SELECT * FROM `cliente`;



# Item 11

DROP TABLE IF EXISTS `sector`;
CREATE TABLE IF NOT EXISTS `sector` (
  	`id_sector` 		INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
  	`sector`        VARCHAR(30)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;	

DROP TABLE IF EXISTS `cargo`;
CREATE TABLE IF NOT EXISTS `cargo` (
  	`id_cargo` 		INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
  	`cargo`        VARCHAR(30)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO `sector` (`sector`) 
  SELECT DISTINCT `sector` 
  FROM `empleado` ORDER BY 1;

SELECT * FROM `sector`;

INSERT INTO `cargo` (`cargo`) 
  SELECT DISTINCT `cargo` 
  FROM `empleado` ORDER BY 1;

SELECT * FROM `cargo`;

SELECT * FROM `empleado`;

ALTER TABLE `empleado`  ADD `id_sector` INTEGER NOT NULL DEFAULT '0' AFTER `id_sucursal`, 
                        ADD `id_cargo` INTEGER NOT NULL DEFAULT '0' AFTER `id_sector`;

SELECT * FROM `empleado`;

UPDATE `empleado` e JOIN `cargo` c ON (c.`cargo` = e.`cargo`) 
  SET e.`id_cargo` = c.`id_cargo`;

SELECT * FROM `empleado`;

UPDATE `empleado` e JOIN `sector` s ON (s.`sector` = e.`sector`) 
SET e.`id_sector` = s.`id_sector`;

SELECT * FROM `empleado`;

ALTER TABLE `empleado` DROP `cargo`;
ALTER TABLE `empleado` DROP `sector`;

SELECT * FROM `empleado`;
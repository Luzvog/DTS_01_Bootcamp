USE henry_m3;

/* modificar tipo de datos */

-- tabla: `venta`
-- campo: `cantidad`	    INTEGER


/* 
SHOW FULL COLUMNS FROM `venta`;
muestra una descripcion de la tabla
*/

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

-- error 1366 incorrect integer value row 72, 105

-- tabla: `tipo_gasto`
-- campo: `id_tipo_gasto`   INTEGER

ALTER TABLE `tipo_gasto` MODIFY `id_tipo_gasto` INTEGER;

-- tabla: `producto`
-- campo: `precio`       DECIMAL(10,2)

ALTER TABLE `producto` MODIFY `precio` DECIMAL(15,2);

SELECT * FROM `producto`;

SHOW FULL COLUMNS FROM `producto`;


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

ALTER TABLE `venta` DROP COLUMN `x`;
ALTER TABLE `venta` DROP COLUMN `y`;
ALTER TABLE `venta` DROP COLUMN `col10`;

-- tabla: `sucursal`
-- campo: `latitud`
-- campo: `longitud`


ALTER TABLE `venta` DROP COLUMN `latitud`;
ALTER TABLE `venta` DROP COLUMN `longitud`;ALTER TABLE `venta` MODIFY `cantidad` INTEGER

/*

1.- Crea una acción que permita realizar cargas incrementales mediante la comparación con la fecha de la última venta en la tabla fact_inicial.

*/
-- Se crea la tabla auditoría
DROP TABLE IF EXISTS `fact_venta_auditoria`;
CREATE TABLE IF NOT EXISTS `fact_venta_auditoria` (
  `id_fact_venta_auditoria`     INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `id_venta`			        INTEGER,
  `fecha` 				DATE NOT NULL,
  `fecha_entrega` 		DATE NOT NULL,
  `id_canal`			INTEGER, 
  `id_cliente`			INTEGER, 
  `id_sucursal`			INTEGER,
  `id_empleado`			INTEGER,
  `id_producto`			INTEGER,
  `cantidad`			INTEGER,
  `usuario`             VARCHAR(20),
  `fecha_modificacion`  DATE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- Se crea el trigger que se ejecutara luego de cada cambio
CREATE TRIGGER `fact_venta_auditoria` AFTER INSERT ON `fact_venta`
FOR EACH ROW
INSERT INTO `fact_venta_auditoria` (    
                                    `id_venta`, 
                                    `fecha` , 
                                    `fecha_entrega`,
                                    `id_canal`, 
                                    `id_cliente`, 
                                    `id_sucursal`, 
                                    `id_empleado`, 
                                    `id_producto`, 
                                    `cantidad`, 
                                    `usuario`, 
                                    `fecha_modificacion`
) VALUES (
            NEW.`id_venta`, 
            NEW.`fecha` , 
            NEW.`fecha_entrega`, 
            NEW.`id_canal`, 
            NEW.`id_cliente`, 
            NEW.`id_sucursal`, 
            NEW.`id_empleado`, 
            NEW.`id_producto`, 
            NEW.`cantidad`, 
            CURRENT_USER, 
            NOW());

SHOW FULL COLUMNS FROM `fact_venta_auditoria`;

/*

2.- Crear una tabla que permita auditar la cantidad de datos cargados por fecha en la tabla fac_inicial.

*/

DROP TABLE IF EXISTS `fact_venta_registro`;
CREATE TABLE IF NOT EXISTS `fact_venta_registro` (
  	`id_fact_venta_registro` 	INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`cantidad_registros`        INT,
	`usuario`                   VARCHAR(20),
	`fecha`                     DATETIME
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

DROP TRIGGER IF EXISTS `fact_venta_registro`;
CREATE TRIGGER `fact_venta_registro` AFTER INSERT ON `fact_venta`
FOR EACH ROW
INSERT INTO `fact_venta_registro` (`cantidad_registros`, `usuario`, `fecha`)
VALUES ((SELECT COUNT(`id_venta`) FROM `fact_venta`), CURRENT_USER, NOW());

-- Creamos una tabla donde podremos almacenar la cantidad de registros por día
DROP TABLE IF EXISTS `registro`;
CREATE TABLE `registro` (
    `id_registro`         INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `fecha`               DATE,
    `cantidad_registros`  INTEGER
);

-- Esta instrucción nos permite cargar la tabla anterior y saber cual es la cantidad de registros por día.
INSERT INTO `registro` (
                        `fecha`, 
                        `cantidad_registros`
                        ) SELECT DATE(fecha), COUNT(*) 
                        FROM `venta`
                        GROUP BY DATE(`fecha`)
                        ORDER BY DATE(`fecha`);

SELECT DATE('2011-01-01 00:00:10');

/*

La intención de disponer de una tabla de auditoria que carga automaticamente, mediante un trigger y otra que debe
ser llenada manualmente por el usuario es para comprar y evaluar desviaciones del proceso de carga de datos

*/


/*

3.- Crear una tabla que permita auditar la actualización de campos en la tabla fac_inicial, incorpodando en último valor y el actual.

*/

-- Creamos una tabla para auditar cambios
# Los campos de interes para hacer la captura serán: `fecha`, `id_cliente`, `id_cliente1`, `id_producto`, `id_producto1`
DROP TABLE IF EXISTS `fact_venta_cambio`;
CREATE TABLE IF NOT EXISTS `fact_venta_cambio` (
    `id_venta_cambio`   INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
  	`fecha` 			DATE,
  	`id_cliente` 		INTEGER,
    `id_cliente1` 		INTEGER,
  	`id_producto` 		INTEGER,
    `id_producto1` 		INTEGER
);

-- Creamos el trigger que carga nuevos registros
CREATE TRIGGER `auditoria_cambio` AFTER INSERT ON `fact_venta`
FOR EACH ROW
INSERT INTO `fact_venta_cambio` (`fecha`, `id_cliente`, `id_producto`)
VALUES (NEW.`fecha`, NEW.`id_cliente`, NEW.`id_producto`);

-- Creamos el trigger que carga cambios en los registros
CREATE TRIGGER `auditoria_actualizacion` AFTER UPDATE ON `fact_venta`
FOR EACH ROW
UPDATE `fact_venta_cambio`
SET 
`id_cliente` = OLD.IdCliente, 
`id_producto` = OLD.IdProducto,
`id_cliente1` = NEW.IdCliente, 
`id_producto1` = NEW.IdProducto
WHERE `fecha` = OLD.`fecha`;


/*

4.- Crear una tabla que audite los errores de ejecución donde se pueda visualizar el error capturado y la fecha en la que se origino.

*/


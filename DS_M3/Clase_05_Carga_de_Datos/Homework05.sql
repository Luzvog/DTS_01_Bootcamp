use henry_m3;
-- Creamos la tabla que auditará a los usuarios que realizan cambios
DROP TABLE IF EXISTS `fact_venta_auditoria`;
CREATE TABLE IF NOT EXISTS `fact_venta_auditoria` (
  	`IdFecha` 			INTEGER,
	`Fecha`				DATE,
	`Fecha_Entrega`		DATE,
  	`IdCanal` 			INTEGER,
  	`IdCliete` 			INTEGER,
  	`IdEmpleado` 		INTEGER,
  	`IdProducto` 		INTEGER,
    `usuario` 	VARCHAR(20),
    `fechaModificacion` 	DATE
);

-- Creamos el trigger que se ejecutara luego de cada cambio
CREATE TRIGGER fact_venta_auditoria AFTER INSERT ON fact_venta
FOR EACH ROW
INSERT INTO fact_venta_auditoria (IdFecha, Fecha, FechaEntrega, IdCanal, IdCliente, IdEmpleado, IdProducto, usuario, fechaModificacion)
VALUES (NEW.IdFecha, NEW.Fecha, NEW.FechaEntrega, NEW.IdCanal, NEW.IdCliente, NEW.IdEmpleado, NEW.IdProducto, NEW.usuario, NEW.fechaModificacion,CURRENT_USER,NOW());

-- Creamos la tabla que llevara una cuenta de los registros.
DROP TABLE IF EXISTS `fact_venta_registros`;
CREATE TABLE IF NOT EXISTS `fact_venta_registros` (
  	id 	INT NOT NULL AUTO_INCREMENT,
	cantidadRegistros INT,
	usuario VARCHAR (20),
	fecha DATETIME,
	PRIMARY KEY (id)
);

-- Creamos el trigger que se ejecutara luego de cada cambio
DROP TRIGGER fact_venta_registros;
CREATE TRIGGER fact_venta_registros
AFTER INSERT ON fact_venta
FOR EACH ROW
INSERT INTO fact_inicial_registros (cantidadRegistros,usuario, fecha)
VALUES ((SELECT COUNT(*) FROM alumnos),CURRENT_USER,NOW());

-- Creamos una tabla donde podremos almacenar la cantidad de registros por día
DROP TABLE registros;
CREATE TABLE registros (
id INT NOT NULL AUTO_INCREMENT,
fecha DATE,
cantidadRegistros INT,
PRIMARY KEY (id)
);

-- Esta instrucción nos permite cargar la tabla anterior y saber cual es la cantidad de registros por día.
INSERT INTO registros (fecha, cantidadRegistros)
SELECT DATE(Fecha), COUNT(*) 
FROM venta
GROUP BY DATE(Fecha)
ORDER BY DATE(Fecha);

SELECT DATE('2011-01-01 00:00:10');

-- Creamos una tabla para auditar cambios
DROP TABLE IF EXISTS `fact_venta_cambios`;
CREATE TABLE IF NOT EXISTS `fact_venta_cambios` (
  	`Fecha` 			DATE,
  	`IdCliente` 		INTEGER,
    `IdCliente1` 		INTEGER,
  	`IdProducto` 		INTEGER,
    `IdProducto1` 		INTEGER
);

-- Creamos el trigger que carga nuevos registros
CREATE TRIGGER auditoria_cambios AFTER INSERT ON fact_venta
FOR EACH ROW
INSERT INTO fact_venta_cambios (IdFecha, IdCliente, IdProducto)
VALUES (NEW.Fecha,NEW.IdCliente, NEW.IdProducto);

-- Creamos el trigger que carga cambios en los registros
CREATE TRIGGER auditoria_actualizacion AFTER UPDATE ON fact_venta
FOR EACH ROW
UPDATE fact_venta_cambios
SET 
IdCliente = OLD.IdCliente, 
IdProducto = OLD.IdProducto,
IdCliente1 = NEW.IdCliente, 
IdProducto1 = NEW.IdProducto
WHERE Fecha = OLD.Fecha;

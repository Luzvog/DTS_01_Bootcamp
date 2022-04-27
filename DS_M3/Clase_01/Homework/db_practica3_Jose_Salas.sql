/*
crear base de datos
*/

CREATE DATABASE db_practica3;

USE  db_practica3;

/*
crear tabla canalVenta
*/

CREATE TABLE canalVenta (
	idCanal CHAR(15) NOT NULL,
	descripcion CHAR(50) NOT NULL
);

LOAD DATA INFILE '\CanalDeVenta_(por_comas).csv'
	INTO TABLE canalVenta
	CHARACTER SET latin1
	fields terminated BY ';'
	lines terminated BY ';;'
	IGNORE 1 lines;

SELECT * FROM canalVenta;

/*
crear tabla cliente
*/

CREATE TABLE cliente (
	idCliente INT NOT NULL,
	provincia CHAR(180) NOT NULL,
	nombreApellido CHAR(180) NOT NULL,
	domicilio CHAR(180) NOT NULL,
	telefono CHAR(180) NOT NULL,
	edad CHAR(180) NOT NULL,
	localidad CHAR(180) NOT NULL,
	coordenada_X CHAR(180) NOT NULL,
	coordenada_Y CHAR(180) NOT NULL,
    col10 CHAR(180) NULL
);

LOAD DATA infile '\Clientes.csv'
	INTO TABLE cliente
	CHARACTER SET latin1
	fields terminated BY ';'
	lines terminated BY '\n'
	IGNORE 1 lines;

SELECT * FROM cliente;

/*
crear tabla compra
*/

CREATE TABLE compra (
	idCompra INT NOT NULL,
	fecha CHAR(50) NOT NULL,
	idProducto CHAR(50) NOT NULL,
	cantidad CHAR(50) NOT NULL,
    precio CHAR(50) NOT NULL,
	idProveedor CHAR(50) NOT NULL
);

LOAD DATA infile '\Compra.csv'
	INTO TABLE compra
	CHARACTER SET latin1
	fields terminated BY ','
	lines terminated BY '\n'
	IGNORE 1 lines;

SELECT * FROM compra;

/*
crear tabla empleado
*/

CREATE TABLE empleado (
	idEmpleado CHAR(15) NOT NULL,
	apelldio CHAR(50) NOT NULL,
    nombre CHAR(50) NOT NULL,
	sucursal CHAR(50) NOT NULL,
	sector CHAR(50) NOT NULL,
	cargo CHAR(50) NOT NULL,
	salario CHAR(50) NOT NULL
);

LOAD DATA infile '\Empleados_(por_comas).csv'
	INTO TABLE empleado
	CHARACTER SET latin1
	fields terminated BY ';'
	lines terminated BY '\n'
	IGNORE 1 lines;

SELECT * FROM empleado;

/*
crear tabla gasto
*/

CREATE TABLE gasto (
	idGasto INT NOT NULL,
	idSucursal CHAR(50) NOT NULL,
	idTipoGasto CHAR(50) NOT NULL,
	fecha CHAR(50) NOT NULL,
	monto CHAR(50) NOT NULL
);

LOAD DATA infile '\Gasto.csv'
	INTO TABLE gasto
	CHARACTER SET latin1
	fields terminated BY ','
	lines terminated BY '\n'
	IGNORE 1 lines;

SELECT * FROM gasto;

/*
crear tabla producto
*/

CREATE TABLE producto (
	idProducto CHAR(50) NOT NULL,
	concepto CHAR(150) NOT NULL,
	tipo CHAR(50) NOT NULL,
	precio CHAR(50) NOT NULL
);

LOAD DATA infile '\PRODUCTOS_(por_comas).csv'
	INTO TABLE producto
	CHARACTER SET latin1
	fields terminated BY ';'
	lines terminated BY '\r\n'
	IGNORE 1 lines;
    
SELECT * FROM producto;

/*
crear tabla proveedores
*/

CREATE TABLE proveedores (
	idProveedor CHAR(50) NOT NULL,
	nombre CHAR(50) NOT NULL,
	direccion CHAR(50) NOT NULL,
	ciudad CHAR(50) NOT NULL,
	estado CHAR(50) NOT NULL,
	pais CHAR(50) NOT NULL,
	provincia CHAR(50) NOT NULL
);

LOAD DATA infile '\Proveedores_(por_comas).csv'
	INTO TABLE proveedores
	CHARACTER SET latin1
	fields terminated BY ';'
	lines terminated BY '\r\n'
	IGNORE 1 lines;
    
SELECT * FROM proveedores;

/*
crear tabla sucursales
*/

CREATE TABLE sucursal (
	idSucursal int NOT NULL,
    sucursal CHAR(50) NOT NULL,
	direccion CHAR(50) NOT NULL,
	localdiad CHAR(50) NOT NULL,
	provincia CHAR(50) NOT NULL,
	latitud CHAR(50) NOT NULL,
	longitud CHAR(50) NOT NULL
);

LOAD DATA infile '\Sucursales.csv'
	INTO TABLE sucursal
	CHARACTER SET latin1
	fields terminated BY ';'
	lines terminated BY '\r\n'
	IGNORE 1 lines;
    
SELECT * FROM sucursal;

/*
crear tabla tipoGasto
*/

CREATE TABLE tipoGasto (
	idTipoGasto CHAR(15) NOT NULL,
	descripcion CHAR(50) NOT NULL,
	montoAproximado CHAR(50) NOT NULL
);

LOAD DATA infile '\TiposDeGasto.csv'
	INTO TABLE tipoGasto
	CHARACTER SET latin1
	fields terminated BY ','
	lines terminated BY '\r\n'
	IGNORE 1 lines;

SELECT * FROM tipoGasto;

/*
crear tabla venta
*/

CREATE TABLE venta (
	idVenta CHAR(15) NOT NULL,
	fecha CHAR(50) NOT NULL,
	fechaEntrega  CHAR(50) NOT NULL,
	idCanal CHAR(50) NOT NULL,
	idCliente CHAR(50) NOT NULL,
	idSucursal CHAR(50) NOT NULL,
	idEmpleado CHAR(50) NOT NULL,
	idProducto CHAR(50) NOT NULL,
	precio CHAR(50) NOT NULL
);

LOAD DATA infile '\Venta.csv'
	INTO TABLE venta
	CHARACTER SET latin1
	fields terminated BY ','
	lines terminated BY '\r\n'
	IGNORE 1 lines
	(idVenta,fecha,fechaEntrega,idCanal,idCliente,idSucursal,idEmpleado,idProducto,precio,@cantidad);
    
SELECT * FROM venta;
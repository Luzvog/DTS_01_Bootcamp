create database db_practica3;

use  db_practica3;

/*
crear tabla canalVenta
*/

create table canalVenta (
	idCanal char(15) not null,
	descripcion char(50) not null
);

load data infile '\CanalDeVenta_(por_comas).csv'
	into table canalVenta
	character set latin1
	fields terminated by ';'
	lines terminated by ';;'
	ignore 1 lines;

SELECT * FROM canalVenta;

/*
crear tabla cliente
*/

create table cliente (
	idCliente INT not null,
	provincia char(180) not null,
	nombreApellido char(180) not null,
	domicilio char(180) not null,
	telefono char(180) not null,
	edad char(180) not null,
	localidad char(180) not null,
	coordenada_X char(180) not null,
	coordenada_Y char(180) not null,
    col10 char(180) null
);

load data infile '\Clientes.csv'
	into table cliente
	character set latin1
	fields terminated by ';'
	lines terminated by '\n'
	ignore 1 lines;

SELECT * FROM cliente;

/*
crear tabla compra
*/

create table compra (
	idCompra INT not null,
	fecha char(50) not null,
	idProducto char(50) not null,
	cantidad char(50) not null,
    precio char(50) not null,
	idProveedor char(50) not null
);

load data infile '\Compra.csv'
	into table compra
	character set latin1
	fields terminated by ','
	lines terminated by '\n'
	ignore 1 lines;

SELECT * FROM compra;

/*
crear tabla empleado
*/

create table empleado (
	idEmpleado char(15) not null,
	apelldio char(50) not null,
    nombre char(50) not null,
	sucursal char(50) not null,
	sector char(50) not null,
	cargo char(50) not null,
	salario char(50) not null
);

load data infile '\Empleados_(por_comas).csv'
	into table empleado
	character set latin1
	fields terminated by ';'
	lines terminated by '\n'
	ignore 1 lines;

SELECT * FROM empleado;

/*
crear tabla gasto
*/

create table gasto (
	idGasto INT not null,
	idSucursal char(50) not null,
	idTipoGasto char(50) not null,
	fecha char(50) not null,
	monto char(50) not null
);

load data infile '\Gasto.csv'
	into table gasto
	character set latin1
	fields terminated by ','
	lines terminated by '\n'
	ignore 1 lines;

SELECT * FROM gasto;

/*
crear tabla producto
*/

create table producto (
	idProducto char(50) not null,
	concepto char(150) not null,
	tipo char(50) not null,
	precio char(50) not null
);

load data infile '\PRODUCTOS_(por_comas).csv'
	into table producto
	character set latin1
	fields terminated by ';'
	lines terminated by '\n'
	ignore 1 lines;
    
SELECT * FROM producto;

/*
crear tabla proveedores
*/

create table proveedores (
	idProveedor char(50) not null,
	nombre char(50) not null,
	direccion char(50) not null,
	ciudad char(50) not null,
	estado char(50) not null,
	pais char(50) not null,
	provincia char(50) not null
);

load data infile '\Proveedores_(por_comas).csv'
	into table proveedores
	character set latin1
	fields terminated by ';'
	lines terminated by '\N'
	ignore 1 lines;
    
SELECT * FROM proveedores;

DROP TABLE proveedores;

/*
crear tabla sucursales
*/

create table sucursal (
	idSucursal char(15) not null,
	direccion char(50) not null
	localdiad char(50) not null
	provincia char(50) not null
	latitud char(50) not null
	longitud char(50) not null
);

/*
crear tabla tipoGasto
*/

create table tipoGasto (
	idTipoGasto char(15) not null,
	descripcion char(50) not null
	montoAproximado char(50) not null
);

/*
crear tabla venta
*/

create table venta (
	idVenta char(15) not null,
	fecha char(50) not null
	fechaEntrega  char(50) not null
	idCanal char(50) not null
	idCliente char(50) not null
	idSucursal char(50) not null
	idEmpleado char(50) not null
	idProducto char(50) not null
	precio char(50) not null
	cantidad char(50) not null
);
/*

1.- Genere 5 consultas simples con alguna función de agregación y filtrado sobre las tablas. 
Anote los resultados del la ficha de estadísticas.

*/

-- Consulta 1
SELECT AVG(cantidad) AS cantidad_media FROM `venta` GROUP BY ``;		     

-- Consulta 2
SELECT *, AVG(`monto`) AS `gato_promedio` FROM `gasto` GROUP BY `id_tipo_gasto`;

-- Consulta 3
SELECT *, AVG(`precio`) AS `promedio_precio` FROM `compra` GROUP BY ``; 

-- Consulta 4
SELECT *, AVG(`salario`) AS `promedio_salario` FROM `empleado` GROUP BY `id_empleado`;

-- Consulta 5
SELECT  v1.`id_venta`,
        v1.`fecha`,
        v1.`fecha_entrega`,
        v1.`id_canal`,
        v1.`id_sucursal`,
        v1.`id_empleado`,
        v1.``, 
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
        ON v2.`` = p.``
        HAVING `venta` IS NOT NULL
        ORDER BY v2.``) AS vv
    ON v1.`id_venta` = vv.`id_venta`
    JOIN (SELECT    med_ls.``, 
                    AVG(med_ls.`venta`) AS `promedio`, 
                    (AVG(med_ls.`venta`) + (3 * STDDEV(med_ls.`venta`))) AS `maximo`
        FROM (SELECT    v2.``, 
                        v2.`id_venta`, p.`precio`, 
                        ((v2.`cantidad`)*(p.`precio`)) AS `venta`
            FROM `venta` v2 JOIN `producto` p
            ON v2.`` = p.``
            HAVING `venta` IS NOT NULL
            ORDER BY v2.``) AS med_ls
        GROUP BY med_ls.``) AS ls
    ON v1.`` = ls.``
    WHERE vv.`venta` >  ls.`maximo`;


/*

2.- A partir del conjunto de datos elaborado en clases anteriores, genere las PK de cada una de 
las tablas a partir del campo que cumpla con los requisitos correspondientes.

*/

-- Tabla cliente

SHOW FULL COLUMNS FROM `cliente`;
ALTER TABLE `cliente` MODIFY `id_cliente` INTEGER NOT NULL; 
ALTER TABLE `cliente` ADD CONSTRAINT `pk_cliente` PRIMARY KEY (`id_cliente`);
SHOW FULL COLUMNS FROM `cliente`;

-- Tabla compra

SHOW FULL COLUMNS FROM `compra`;
ALTER TABLE `compra` MODIFY `id_compra` INTEGER NOT NULL;
ALTER TABLE `compra` ADD CONSTRAINT `pk_compra` PRIMARY KEY (`id_compra`);
SHOW FULL COLUMNS FROM `compra`;

-- Tabla gasto

SHOW FULL COLUMNS FROM `gasto`;
ALTER TABLE `gasto` MODIFY `id_gasto` INTEGER NOT NULL;
ALTER TABLE `gasto` ADD CONSTRAINT `pk_gasto` PRIMARY KEY (`id_gasto`);
SHOW FULL COLUMNS FROM `gasto`;

-- Tabla sucursal

SHOW FULL COLUMNS FROM `sucursal`;
ALTER TABLE `sucursal` MODIFY `id_sucursal` INTEGER NOT NULL;
ALTER TABLE `sucursal` ADD CONSTRAINT `pk_sucursal` PRIMARY KEY (`id_sucursal`);
SHOW FULL COLUMNS FROM `sucursal`;

-- Tabla tipo_gasto

SHOW FULL COLUMNS FROM `tipo_gasto`;
ALTER TABLE `tipo_gasto` MODIFY `id_tipo_gasto` INTEGER NOT NULL;
ALTER TABLE `tipo_gasto` ADD CONSTRAINT `pk_tipo_gasto` PRIMARY KEY (`id_tipo_gasto`);
SHOW FULL COLUMNS FROM `tipo_gasto`;

-- Tabla venta

SHOW FULL COLUMNS FROM `venta`;
ALTER TABLE `venta` MODIFY `id_venta` INTEGER NOT NULL;
ALTER TABLE `venta` ADD CONSTRAINT `pk_venta` PRIMARY KEY (`id_venta`);
SHOW FULL COLUMNS FROM `venta`;

-- Tabla canal_venta

SHOW FULL COLUMNS FROM `canal_venta`;
ALTER TABLE `canal_venta` MODIFY `id_canal` INTEGER NOT NULL;
ALTER TABLE `canal_venta` ADD CONSTRAINT `pk_cana_venta` PRIMARY KEY (`id_canal`);
SHOW FULL COLUMNS FROM `canal_venta`;

-- tabla empleado

SHOW FULL COLUMNS FROM `empleado`;
ALTER TABLE `empleado` MODIFY `id_empleado` INTEGER NOT NULL;
ALTER TABLE `empleado` ADD CONSTRAINT `pk_empleado` PRIMARY KEY (`id_empleado`);
SHOW FULL COLUMNS FROM `empleado`;

-- tabla producto

SHOW FULL COLUMNS FROM `producto`;
ALTER TABLE `producto` MODIFY `` INTEGER NOT NULL;
ALTER TABLE `producto` ADD CONSTRAINT `pk_producto` PRIMARY KEY (``);
SHOW FULL COLUMNS FROM `producto`;

-- tabla proveedor

SHOW FULL COLUMNS FROM `proveedor`;
ALTER TABLE `proveedor` MODIFY `id_proveedor` INTEGER NOT NULL;
ALTER TABLE `proveedor` ADD CONSTRAINT `pk_proveedor` PRIMARY KEY (`id_proveedor`);
SHOW FULL COLUMNS FROM `proveedor`;

/*

3.- Genere la indexación de los campos que representen fechas
o ID en las tablas:

*/

-- Tabla calendario.

SHOW FULL COLUMNS FROM `calendario`;

ALTER TABLE `calendario` ADD UNIQUE(`fecha`);

SHOW FULL COLUMNS FROM `calendario`;

-- Tabla venta.
SHOW FULL COLUMNS FROM `venta`;

CREATE INDEX `idx_producto` ON `venta` (`id_producto`);

CREATE INDEX `idx_empleado` ON `venta` (`id_empleado`);

CREATE INDEX `idx_fecha` ON `venta` (`fecha`);

CREATE INDEX `idx_fecha_entrega` ON `venta` (`fecha_entrega`);

CREATE INDEX `idx_cliente` ON `venta` (`id_cliente`);

CREATE INDEX `idx_sucursal` ON `venta` (`id_sucursal`);

CREATE INDEX `idx_canal` ON `venta` (`id_canal`);

SHOW FULL COLUMNS FROM `venta`;

-- Tabla producto.

SHOW FULL COLUMNS FROM `producto`;

CREATE INDEX `idx_tipo_producto` ON `producto` (`id_tipo_producto`);

SHOW FULL COLUMNS FROM `producto`;

-- Tabla sucursal.

SHOW FULL COLUMNS FROM `sucursal`;

CREATE INDEX `idx_localidad` ON `sucursal` (`id_localidad`);

SHOW FULL COLUMNS FROM `sucursal`;

-- Tabla empleado.

SHOW FULL COLUMNS FROM `empleado`;

CREATE INDEX `idx_codigo_empleado` ON `empleado` (`codigo_empleado`);

CREATE INDEX `idx_sucursal` ON `empleado` (`id_sucursal`);

CREATE INDEX `idx_sector` ON `empleado` (`id_sector`);

CREATE INDEX `idx_cargo` ON `empleado` (`id_cargo`);

SHOW FULL COLUMNS FROM `empleado`;

-- Tabla localidad.

SHOW FULL COLUMNS FROM `localidad`;

CREATE INDEX `idx_provincia` ON `localidad` (`id_provincia`);

-- Tabla proveedor.

SHOW FULL COLUMNS FROM `proveedor`;

CREATE INDEX `idx_localidad` ON `proveedor` (`id_localidad`);

-- Tabla gasto.

SHOW FULL COLUMNS FROM `gasto`;

CREATE INDEX `idx_sucursal` ON `gasto` (`id_sucursal`);

CREATE INDEX `idx_tipo_gasto` ON `gasto` (`id_tipo_gasto`);

CREATE INDEX `idx_fecha` ON `gasto` (`fecha`);

SHOW FULL COLUMNS FROM `gasto`;

-- Tabla cliente.

SHOW FULL COLUMNS FROM `cliente`;

CREATE INDEX `idx_localidad` ON `cliente` (`id_localidad`);

-- Tabla compra.

SHOW FULL COLUMNS FROM `compra`;

CREATE INDEX `idx_fecha` ON `compra` (`fecha`);

CREATE INDEX `idx_producto` ON `compra` (``);

CREATE INDEX `idx_proveedor` ON `compra` (`id_proveedor`);

SHOW FULL COLUMNS FROM `compra`;

-- Relacion entre tablas

-- Tabla venta

SHOW FULL COLUMNS FROM `venta`;


ALTER TABLE `venta` ADD CONSTRAINT `venta_fk_producto` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `venta` ADD CONSTRAINT `venta_fk_empleado` FOREIGN KEY (`id_empleado`) REFERENCES `empleado` (`id_empleado`) ON DELETE RESTRICT ON UPDATE RESTRICT;
/* Solucion error #1452 - Cannot add or update a child row: a foreign key constraint fails

-- El problema se dio porque los id_empleado en la tabla venta y los id_empleado en la tabla empleado no coinciden
-- Solución:
# Aplicar tansformación al campo id_empleado en la tabla venta `id_empleado` = ((id_sucursal * 1000000) + codigo_empleado)

UPDATE `venta` SET `id_empleado` = ((id_sucursal * 1000000) + `id_empleado`);

SELECT * FROM `venta`;

SELECT * FROM `empleado`;
*/

ALTER TABLE `venta` ADD CONSTRAINT `venta_fk_calendario` FOREIGN KEY (`fecha`) REFERENCES `calendario` (`fecha`) ON DELETE RESTRICT ON UPDATE RESTRICT; 

ALTER TABLE `venta` ADD CONSTRAINT `venta_fk_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `venta` ADD CONSTRAINT `venta_fk_sucursal` FOREIGN KEY (`id_sucursal`) REFERENCES `sucursal` (`id_sucursal`) ON DELETE RESTRICT ON UPDATE RESTRICT;

SHOW FULL COLUMNS FROM `canal_venta`;

ALTER TABLE `venta` ADD CONSTRAINT `venta_fk_canal` FOREIGN KEY (`id_canal`) REFERENCES `canal_venta` (`id_canal`) ON DELETE RESTRICT ON UPDATE RESTRICT; 

/*
# Esta consulta devuelve las fk de las tabla
SELECT * FROM information_schema.TABLE_CONSTRAINTS 
WHERE information_schema.TABLE_CONSTRAINTS.CONSTRAINT_TYPE = 'FOREIGN KEY' 
AND information_schema.TABLE_CONSTRAINTS.TABLE_SCHEMA = 'henry_m3'
AND information_schema.TABLE_CONSTRAINTS.TABLE_NAME = 'venta';
*/

-- Tabla producto

SHOW FULL COLUMNS FROM `producto`;

SHOW FULL COLUMNS FROM `tipo_producto`;

SELECT * FROM `producto`;

ALTER TABLE `producto` ADD CONSTRAINT `producto_fk_tipo_producto` FOREIGN KEY (`id_tipo_producto`) REFERENCES `tipo_producto` (`id_tipo_producto`) ON DELETE RESTRICT ON UPDATE RESTRICT; 
/* Solucion error #1452 - Cannot add or update a child row: a foreign key constraint fails

-- El problema se dio porque hay un id_tipo_producto en la taba producto que no se encuentra registrado en la tabla tipo_producto
-- Solución:
# Dropear los campos con id_tipo_producto iguales a 0 en la tabla producto.

*/

-- Tabla sucursal 

ALTER TABLE `sucursal` ADD CONSTRAINT `sucursal_fk_localidad` FOREIGN KEY (`id_localidad`) REFERENCES `localidad` (`id_localidad`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- Tabla empleado

ALTER TABLE `empleado` ADD CONSTRAINT `empleado_fk_sucursal` FOREIGN KEY (`id_sucursal`) REFERENCES `sucursal` (`id_sucursal`) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `empleado` ADD CONSTRAINT `empleado_fk_sector` FOREIGN KEY (`id_sector`) REFERENCES `sector` (`id_sector`) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `empleado` ADD CONSTRAINT `empleado_fk_cargo` FOREIGN KEY (`id_cargo`) REFERENCES `cargo` (`id_cargo`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- Tabla localidad

ALTER TABLE `localidad` ADD CONSTRAINT `localidad_fk_provincia` FOREIGN KEY (`id_provincia`) REFERENCES `provincia` (`id_provincia`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- Tabla proveedor

ALTER TABLE `proveedor` ADD CONSTRAINT `proveedor_fk_localidad` FOREIGN KEY (`id_localidad`) REFERENCES `localidad` (`id_localidad`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- Tabla gasto

ALTER TABLE `gasto` ADD CONSTRAINT `gasto_fk_sucursal` FOREIGN KEY (`id_sucursal`) REFERENCES `sucursal` (`id_sucursal`) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `gasto` ADD CONSTRAINT `gasto_fk_tipo_gasto` FOREIGN KEY (`id_tipo_gasto`) REFERENCES `tipo_gasto` (`id_tipo_gasto`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- Table cliente

ALTER TABLE `cliente` ADD CONSTRAINT `cliente_fk_localidad` FOREIGN KEY (`id_localidad`) REFERENCES `localidad` (`id_localidad`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- Tabla compra

ALTER TABLE `compra` ADD CONSTRAINT `compra_fk_producto` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `compra` ADD CONSTRAINT `compra_fk_proveedor` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedor` (`id_proveedor`) ON DELETE RESTRICT ON UPDATE RESTRICT;



/*

4.- Ahora que las tablas están indexadas, vuelva a ejecutar 
las consultas del punto 1 y evalue las estadístias. 
¿Nota alguna diferencia?.

*/





/*

5.- Genere una nueva tabla que lleve el nombre fact_venta que 
pueda agrupar los hechos relevantes de la tabla venta, 
los campos a considerar deben ser los siguientes:

# IdFecha ,
# Fecha,
# IdSucursal,
# IdProducto,
# IdCliente,
# Precio
# Cantidad

*/




/*

6.- A partir de la tabla creada en el punto anterior, deberá 
poblarla con los datos de la tabla ventas.

*/
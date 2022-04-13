USE henry;

insert into carreras (nombre)
values ('Data Science');

select * from carreras;

insert into instructores(cedulaIdentidad, nombre, apellido, fechaNacimiento, fechaIncorporacion)
values ('12345', 'Juan', 'Perez', '1990-01-01', '2022-01-01');

select * from instructores;

insert into cohortes (codigo, carrera, instructor, fechaInicio, fechaFinalizacion)
values ('01', 1, 1, '2022-04-01', '2022-08-01');
insert into cohortes (codigo, carrera, instructor, fechaInicio, fechaFinalizacion)
values ('02', 2, 2, '2022-04-01', '2022-08-01');

select * from cohortes;

insert into alumnos (cedulaIdentidad, nombre, apellido, fechaNacimiento, fechaIngreso, cohorte)
values ('10001', 'Maria', 'Becerra', '2000-04-01', '2022-04-01', 1);
insert into alumnos (cedulaIdentidad, nombre, apellido, fechaNacimiento, fechaIngreso, cohorte)
values ('10002', 'Octavio', 'Juarez', '2000-04-01', '2022-04-01', 1);
insert into alumnos (cedulaIdentidad, nombre, apellido, fechaNacimiento)
values ('10003', 'Eduardo', 'Gomez', '2000-04-01');
insert into alumnos (cedulaIdentidad, nombre, apellido, fechaNacimiento, fechaIngreso, cohorte)
values ('10003', 'Lorena', 'Gomez', '2000-04-01',null, 1);
insert into alumnos (cedulaIdentidad, nombre, apellido, fechaNacimiento, fechaIngreso, cohorte)
values ('10004', 'Jimena', 'Alves', '2000-04-01','2022-04-01', 1),
		('10005', 'Juan', 'Alves', '2000-04-01','2022-04-01', 1),
        ('10006', 'Gabriel', 'Alves', '2000-04-01','2022-04-01', 1),
        ('10007', 'Pablo', 'Alves', '2000-04-01','2022-04-01', 1);

insert into alumnos
values (9,'10010', 'Dorian', 'Alvarez', '2000-04-01',curdate(), 1),
		(10,'10011', 'Gonzalo', 'Gutierrez', '2000-04-01',curdate(), 1);
        
insert into alumnos
values (11,'10010', 'Dorian', 'Alvarez', '2000-04-01',curdate(), 1),
		(12,'10011', 'Gonzalo', 'Gutierrez', '2000-04-01',curdate(), 1);

update alumnos 
set cedulaIdentidad = '10000' 
where idAlumno = 1;

update alumnos 
set cedulaIdentidad = '10001' 
where idAlumno = 2;

update alumnos 
set cedulaIdentidad = '10002'
where idAlumno = 3;

delete from alumnos
where cohorte is null;
delete from alumnos
where idAlumno = 7;

select * from alumnos
where apellido = 'Alves';

select alumnos.cedulaIdentidad, alumnos.nombre, alumnos.apellido, cohortes.codigo as codigo_cohorte
from alumnos join cohortes
	on (alumnos.cohorte = cohortes.idCohorte)
where alumnos.apellido = 'Alves';

select 	a.cedulaIdentidad, 
		concat(a.nombre, ' ', a.apellido) as nom_y_ape,
		a.nombre,
        a.apellido, 
        a.fechaIngreso,
        c.codigo as codigo_cohorte
from alumnos a join cohortes c
	on (a.cohorte = c.idCohorte)
where a.fechaIngreso between '2022-01-01' and '2022-04-01'
and a.fechaIngreso >= '2022-01-01'
and a.fechaIngreso <= '2022-04-01'
and a.apellido like 'a%s'
and a.cedulaIdentidad in ('10004','10005','10006','10007');

select a.cedulaIdentidad, a.nombre, a.apellido, c.codigo as codigo_cohorte
from alumnos a, cohortes c
where a.cohorte = c.idCohorte;

select * from alumnos;

begin transaction

factura

factrua_detalle

commit transaction
rollback transaction

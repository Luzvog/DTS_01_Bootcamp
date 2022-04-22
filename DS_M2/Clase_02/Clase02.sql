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
values ('10001', 'Maria', 'Becerra', '2000-04-01', '2022-04-01');
insert into alumnos (cedulaIdentidad, nombre, apellido, fechaNacimiento, fechaIngreso, cohorte)
values ('10002', 'Octavio', 'Juarez', '2000-04-01', '2022-04-01');
insert into alumnos (cedulaIdentidad, nombre, apellido, fechaNacimiento)
values ('10003', 'Eduardo', 'Gomez', '2000-04-01', null);
insert into alumnos (cedulaIdentidad, nombre, apellido, fechaNacimiento, fechaIngreso, cohorte)
values ('10003', 'Lorena', 'Gomez', '2000-04-01',null);
insert into alumnos (cedulaIdentidad, nombre, apellido, fechaNacimiento, fechaIngreso, cohorte)
values ('10004', 'Jimena', 'Alves', '2000-04-01','2022-04-01'),
		('10005', 'Juan', 'Alves', '2000-04-01','2022-04-01'),
        ('10006', 'Gabriel', 'Alves', '2000-04-01','2022-04-01'),
        ('10007', 'Pablo', 'Alves', '2000-04-01','2022-04-01');

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

-- Cohortes con promedio de edad mayor a 25
select 	Cohorte, 
		avg(timestampdiff(year, fechaNacimiento, current_date())) as prom_edad
from alumnos
group by Cohorte
having prom_edad >= 25;

-- Ingresos por mes en el año 2022
select month(fechaIngreso) as Mes, count(*) as Q
from alumnos
where year(fechaIngreso) = 2022
group by month(fechaIngreso);

-- Promedio de estudiantes que ingresan por mes:
select Mes, avg(Q) as Prom_Ingresos, sum(Q) / count(Q) as Prom_Ingresos2
from	
	(select month(fechaIngreso) as Mes, year(fechaIngreso) as Anio, count(*) as Q
	from alumnos
	group by Anio, Mes) as ingresos
group by Mes
order by Mes;

-- Promedio de cantidad de estudiantes por Cohorte
SELECT c.idCohorte, COUNT(a.idAlumno) 
	FROM cohortes c
    LEFT JOIN alumnos a
    ON c.idCohorte = a.cohorte
    GROUP BY idCohorte;


-- Cohorte con menor promedio de edad
SELECT alumnos.cohorte, MIN(edadPromedio) as minimo
	FROM (
		SELECT cohorte, AVG(TIMESTAMPDIFF(YEAR,fechaNacimiento,CURDATE())) as edadPromedio
		FROM alumnos
		GROUP BY cohorte) as media, alumnos;
        
SELECT alumnos.cohorte, MAX(edadPromedio) as maximo
	FROM (
		SELECT cohorte, AVG(TIMESTAMPDIFF(YEAR,fechaNacimiento,CURDATE())) as edadPromedio
		FROM alumnos
		GROUP BY cohorte) as media 
        JOIN alumnos
        ON alumnos.cohorte = alumnos.cohorte;
    
-- Meses del último año (2022), con mayor ingreso de alumnos que el promedio histórico (2019-2021)
SELECT Month(fechaIngreso), count(idAlumno) as cantidad
FROM alumnos
WHERE year(FechaIngreso)=2022 
GROUP BY month(fechaIngreso)
having cantidad > (select avg(ingresos) FROM (
        select count(idAlumno) as ingresos
        from alumnos
        WHERE year(fechaIngreso)>=2019 and year(fechaIngreso)<=2021
        GROUP BY month(fechaIngreso)) AS T2);


 SELECT DATE_FORMAT(fechaIngreso, '%Y-%m') as fecha, COUNT(idAlumno) as cantidad
	FROM alumnos
    WHERE year(FechaIngreso)=2022 
    GROUP BY DATE_FORMAT(fechaIngreso, '%Y-%m')
    HAVING cantidad > (SELECT AVG(ingresos) 
		FROM (SELECT COUNT(idAlumno) as ingresos
			FROM alumnos
			WHERE YEAR(fechaIngreso)>=2019 AND YEAR(fechaIngreso)<=2021
			GROUP BY MONTH(fechaIngreso)) as T2);

  



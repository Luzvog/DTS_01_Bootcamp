use henry;

/*1-¿Cuantas carreas tiene Henry?*/
select count(*) from carrera;
/*2-¿Cuantos alumnos hay en total?*/
select count(*) from alumno_sinduplicado;

select c.idCarrera, count(a.idAlumno)
from alumno_sinduplicado a join cohorte c
	on (a.idCohorte = c.idCohorte)
group by c.idCarrera;

/*3-¿Cuantos alumnos tiene cada cohorte?*/
select c.idCarrera, c.codigo, a.idAlumno
from alumno a join cohorte c
	on (a.idCohorte = c.idCohorte)
order by c.idCarrera, c.codigo, a.idAlumno;

select c.codigo, count(distinct a.cedulaIdentidad) as cant_alumnos
from alumno a join cohorte c
	on (a.idCohorte = c.idCohorte)
group by c.codigo;

select 	c.codigo as codigo_cohorte, 
		count(distinct a.cedulaIdentidad) as cant_alumnos
from alumno as a join cohorte as c
	on (a.idCohorte = c.idCohorte)
group by c.codigo;

select idCohorte, count(*) as cant_alumnos
from alumno
group by idCohorte;

/*4-¿Cual es el nombre del primer alumno que ingreso a Henry?*/
select nombre, apellido, fechaIngreso
from alumno
order by fechaIngreso
limit 1;

SELECT CONCAT(nombre,' ',apellido) as 'Nombre del Alumno'
FROM alumno
WHERE fechaIngreso = (SELECT MIN(fechaIngreso) FROM alumno);

/*5-¿En que fecha ingreso?*/
SELECT MIN(fechaIngreso) as fechaIngreso FROM alumno;

/*6-¿Cual es el nombre del ultimo alumno que ingreso a Henry?*/
SELECT CONCAT(nombre,' ',apellido) as 'Nombre del Alumno'
FROM alumno
WHERE fechaIngreso = (SELECT MAX(fechaIngreso) FROM alumno);

/*7-La función YEAR le permite extraer el año de un campo date, 
utilice esta función y especifique cuantos alumnos ingresaron a Henry por año.*/
select year(fechaIngreso) as anio, count(distinct cedulaIdentidad) as cant_Alumnos
from alumno
group by anio
order by anio;

SELECT YEAR(fechaIngreso) AS Año, COUNT(fechaIngreso) AS 'Cant Alumnos'
FROM alumno
GROUP BY Año;

/*8-¿En que años ingresaron más de 20 alumnos?
Investigue las funciones TIMESTAMPDIFF() y CURDATE(). */
select year(fechaIngreso) as anio, count(distinct cedulaIdentidad) as cant_Alumnos
from alumno
where apellido like 'A%'
group by anio
#having cant_Alumnos > 20;
having cant_Alumnos > 1;

/*¿Podría utilizarlas para saber cual es la edad de los instructores?. 
¿Sería correcto decir que el cálculo es suficiente para saber la edad de los instructores*/
select TIMESTAMPDIFF(year, '2020-04-15', '2022-04-14') as dif;
select TIMESTAMPDIFF(year, '2021-01-01', curdate()) as dif;
select 	cedulaIdentidad, 
		concat(nombre, ' ', apellido) as nombre,
        fechaNacimiento,
        TIMESTAMPDIFF(year, fechaNacimiento, curdate()) as edad
from instructor;

/*Ejemplo insert desde otra tabla*/
drop table alumno_sindup;
CREATE TABLE alumno_sindup (
	idAlumno INT NOT NULL AUTO_INCREMENT ,
	cedulaIdentidad VARCHAR(25) NOT NULL,
	nombre VARCHAR (45) NOT NULL,
	apellido VARCHAR (45) NOT NULL,
	fechaNacimiento DATE NOT NULL,
	fechaIngreso DATE,
	idCohorte INT,
	PRIMARY KEY (idAlumno),
	FOREIGN KEY (idCohorte) REFERENCES cohorte(idCohorte) 
);

insert into alumno_sindup (cedulaIdentidad, nombre, apellido, fechaNacimiento, fechaIngreso, idCohorte)
select distinct cedulaIdentidad, nombre, apellido, fechaNacimiento, fechaIngreso, idCohorte
from alumno;

select * from alumno_sindup;
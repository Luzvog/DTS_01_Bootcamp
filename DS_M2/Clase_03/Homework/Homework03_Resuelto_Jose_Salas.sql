/* Ítem 1) ¿Cuantas carreas tiene Henry? 

*/

USE DB_HENRY;

SELECT COUNT(idCarrera) AS numeroCarreras
FROM carrera;

/* Ítem 2) ¿Cuantos alumnos hay en total?

*/

SELECT COUNT(idAlumno) AS numeroAlumnos
FROM alumno;

/* Ítem 3) ¿Cuantos alumnos tiene cada cohorte?

*/

SELECT cohorte.idCohorte, cohorte.codigo, COUNT(alumno.idAlumno)
FROM cohorte
INNER JOIN alumno ON cohorte.idCohorte = alumno.idCohorte
GROUP BY cohorte.codigo;

/* Ítem 4) ¿Cual es el nombre del primer alumno que ingreso a Henry?

*/

SELECT nombre, apellido
FROM alumno
ORDER BY fechaIngreso ASC
LIMIT 1;

SELECT nombre, apellido
FROM alumno
WHERE idAlumno = (SELECT MIN(idAlumno) FROM alumno);

/* Ítem 5) ¿En que fecha ingreso?

*/

SELECT nombre, apellido, fechaIngreso
FROM alumno
ORDER BY fechaIngreso ASC
LIMIT 1;

SELECT nombre, apellido, fechaIngreso
FROM alumno
WHERE fechaIngreso = (SELECT MIN(fechaIngreso) FROM alumno);

/* Ítem 6) ¿Cual es el nombre del ultimo alumno que ingreso a Henry?

*/

SELECT idAlumno, nombre, apellido, fechaIngreso
FROM alumno
ORDER BY fechaIngreso DESC;

SELECT nombre, apellido, fechaIngreso
FROM alumno
WHERE idAlumno = (SELECT MAX(idAlumno) FROM alumno);

/* Ítem 7) La función YEAR le permite extraer el año de un campo date, utilice esta función 
y especifique cuantos alumnos ingresarona a Henry por año.

*/

SELECT COUNT(idAlumno) AS numeroAlumno, YEAR(fechaIngreso) AS fecha
FROM alumno
GROUP BY YEAR(fechaIngreso)
ORDER BY YEAR(fechaIngreso);

/* Ítem 8) ¿En que años ingresaron más de 20 alumnos?

*/

SELECT COUNT(idAlumno) AS numeroAlumno, YEAR(fechaIngreso) AS fecha
FROM alumno
GROUP BY YEAR(fechaIngreso)
HAVING COUNT(idAlumno) > 20
ORDER BY YEAR(fechaIngreso);

/* Ítem 9) Investigue las funciones TIMESTAMPDIFF() y CURDATE(). 
¿Podría utilizarlas para saber cual es la edad de los instructores?. 
¿Sería correcto decir que el cálculo es suficiente para saber la edad de los instructores?.

*/

SELECT idInstructor, nombre, apellido, TIMESTAMPDIFF(YEAR, fechaNacimiento, CURDATE())
FROM instructor;

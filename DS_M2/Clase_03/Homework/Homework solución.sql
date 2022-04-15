# 1. ¿Cuantas carreas tiene Henry?

SELECT count(idCarrera)
FROM carreras

# 2. ¿Cuantos alumnos hay en total?
SELECT count(*)
FROM alumnos


# 3. ¿Cuantos alumnos tiene cada cohorte?
SELECT cohorte,count(*)
FROM alumnos
GROUP BY cohorte

# 4. ¿Cual es el nombre del primer alumno que ingreso a Henry?
SELECT nombre,apellido
FROM alumnos
ORDER BY fechaIngreso ASC
LIMIT 1

# 5. ¿En que fecha ingreso?
SELECT nombre,apellido,fechaIngreso
FROM alumnos
ORDER BY fechaIngreso ASC
LIMIT 1

# 6. ¿Cual es el nombre del ultimo alumno que ingreso a Henry?
SELECT nombre,apellido
FROM alumnos
ORDER BY fechaIngreso DESC
LIMIT 1

# 7. ¿Cuantos alumnos ingresaron por año?
SELECT YEAR(fechaIngreso) "Año Ingreso", COUNT(*) AS Cantidad
FROM alumnos
GROUP BY YEAR(fechaIngreso)

# 8. En que años ingreasaron más de 20 alumnos?
SELECT YEAR(fechaIngreso) AS "Año Ingreso", COUNT(*) AS Cantidad
FROM alumnos
GROUP BY YEAR(fechaIngreso)
HAVING COUNT(*)>20

# 9. ¿Cual es la edad de los instructores?. No sería correcto decir que esa es la edad de los instructores

SELECT TIMESTAMPDIFF(YEAR,fechaNacimiento,CURDATE()) AS Dias
FROM instructores

/*Si bien es correcta la aplicación, para obtener de forma precisa la edad se debería además incorporar en la consulta una condición
que valide si su fecha de cumpleaños del año en curso ya ocurrio.
*/

/*En el M3 incorporaremos los conocimientos necesarios para realizar con presición este cálculo.


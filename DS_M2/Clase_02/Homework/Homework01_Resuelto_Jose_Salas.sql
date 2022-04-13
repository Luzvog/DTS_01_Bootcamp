CREATE DATABASE DB_HENRY;

USE DB_HENRY;

CREATE TABLE carrera (
	idCarrera INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR (20),
    PRIMARY KEY (idCarrera)
);

CREATE TABLE cohorte (
	idCohorte INT NOT NULL,
    codigo VARCHAR (8) NOT NULL,
    idCarrera INT NOT NULL,
    idInstructor INT NOT NULL,
    fechaInicio DATE,
    fechaFinalizacion DATE,
    PRIMARY KEY (idCohorte)
);

ALTER TABLE cohorte
ADD CONSTRAINT FK_CarreraCohorte
FOREIGN KEY (idCarrera) REFERENCES carrera(idCarrera);

ALTER TABLE cohorte
ADD CONSTRAINT FK_CohorteInstructor
FOREIGN KEY (idInstructor) REFERENCES instructor(idInstructor);

CREATE TABLE instructor (
	idInstructor INT NOT NULL AUTO_INCREMENT,
    cedulaIdentidad INT NOT NULL,
    nombre VARCHAR (20),
    apellido VARCHAR (20),
    fechaNacimiento DATE,
    fechaIncorporacion DATE,
    PRIMARY KEY (idInstructor)
);


CREATE TABLE alumno (
	idAlumno INT NOT NULL,
    cedulaIdentidad INT NOT NULL,
    nombre VARCHAR (20),
    apellido VARCHAR (20),
    fechaNacimiento DATE,
    fechaIngreso DATE,
    idCohorte INT NOT NULL,
    PRIMARY KEY (idAlumno)
);

ALTER TABLE alumno
ADD CONSTRAINT FK_CohorteAlumno
FOREIGN KEY (idCohorte) REFERENCES cohorte(idCohorte);



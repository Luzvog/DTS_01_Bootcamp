USE master

CREATE DATABASE henry

USE henry

CREATE TABLE carreras (
	idCarrera INT NOT NULL AUTO_INCREMENT,
	nombre VARCHAR (20) NOT NULL,
	PRIMARY KEY (idCarrera)
)

CREATE TABLE instructores (
	idInstructor INT NOT NULL AUTO_INCREMENT ,
	cedulaIdentidad VARCHAR(25) NOT NULL,
	nombre VARCHAR (45) NOT NULL,
	apellido VARCHAR (45) NOT NULL,
	fechaNacimiento DATE NOT NULL,
	fechaIncorporacion DATE,
	PRIMARY KEY (idInstructor)
)

CREATE TABLE cohortes (
	idCohorte INT NOT NULL AUTO_INCREMENT,
	codigo VARCHAR (45) NOT NULL,
	carrera INT NOT NULL,
    instructor INT,
	fechaInicio DATE,
	fechaFinalizacion DATE,
	PRIMARY KEY (idCohorte),
	FOREIGN KEY (carrera) REFERENCES carreras(idCarrera),
	FOREIGN KEY (instructor) REFERENCES instructores(idInstructor)  
)

CREATE TABLE alumnos (
	idAlumno INT NOT NULL AUTO_INCREMENT ,
	cedulaIdentidad VARCHAR(25) NOT NULL,
	nombre VARCHAR (45) NOT NULL,
	apellido VARCHAR (45) NOT NULL,
	fechaNacimiento DATE NOT NULL,
	fechaIngreso DATE,
	cohorte INT,
	PRIMARY KEY (idAlumno),
	FOREIGN KEY (cohorte) REFERENCES cohortes(idCohorte) 
)

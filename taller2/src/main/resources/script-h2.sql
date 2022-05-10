create table `MAESTRO` (
	`ID_MAESTRO` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`NOMBRES` varchar(90) NOT NULL, 
	`APELLIDOS` varchar (90) NOT NULL, 
	`CORREO` varchar(90) NOT NULL,
	`TELEFONO` varchar(9) NOT NULL, 
	`DUI` varchar(10) NOT NULL
); 

create table `CURSO` (
	`ID_CURSO` int(11) AUTO_INCREMENT PRIMARY KEY,
	`DESCRIPCION` varchar(90) NOT NULL,
	`GRADO` varchar(90) NOT NULL,
	`SECCION` varchar(90) NOT NULL,
	`ID_MAESTRO` int NOT NULL,
	`MATERIA` varchar(20) NOT NULL,
 	 FOREIGN KEY (ID_MAESTRO) REFERENCES MAESTRO(ID_MAESTRO)
); 
 
insert into `MAESTRO` (`NOMBRES`, `APELLIDOS`,`CORREO`,`TELEFONO`,`DUI`) 
values('Felix Gerardo','Guevara Palacios','00055419@uca.edu.sv','7898-9899','01010101-2');
insert into `CURSO` (`DESCRIPCION`, `GRADO`, `SECCION`, `ID_MAESTRO`, `MATERIA`)
values ('Curso de matematicas', 'Octavo', 'D', 1, 'MATEMATICAS'); 





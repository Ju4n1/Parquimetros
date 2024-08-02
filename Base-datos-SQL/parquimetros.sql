CREATE DATABASE parquimetros;

USE parquimetros;

#--------------------------------------------------------------------------Creaci�n tablas entidades---------------------------------------#

CREATE TABLE Conductores (

dni INT UNSIGNED NOT NULL,
registro INT UNSIGNED NOT NULL,
nombre VARCHAR(32) NOT NULL,
apellido VARCHAR(32) NOT NULL,
direccion VARCHAR(32) NOT NULL,
telefono VARCHAR(32),

CONSTRAINT pk_conductores
PRIMARY KEY (dni)

) ENGINE = InnoDB;

CREATE TABLE Automoviles (

patente VARCHAR(6) NOT NULL,
marca VARCHAR(32) NOT NULL,
modelo VARCHAR(32) NOT NULL,
color VARCHAR(32) NOT NULL,
dni INT UNSIGNED NOT NULL,

CONSTRAINT pk_automoviles
PRIMARY KEY(patente),

CONSTRAINT fk_automoviles_conductores
FOREIGN KEY (dni) REFERENCES Conductores(dni)

) ENGINE = InnoDB;


CREATE TABLE Tipos_tarjeta (

tipo VARCHAR(32) NOT NULL,
descuento DECIMAL(3,2) UNSIGNED NOT NULL,

CHECK (descuento <=1.00),

CONSTRAINT pk_tipos_tarjeta
PRIMARY KEY (tipo)

) ENGINE = InnoDB;

CREATE TABLE Tarjetas (

id_tarjeta INT UNSIGNED NOT NULL AUTO_INCREMENT,
saldo DECIMAL(5,2) NOT NULL,
tipo VARCHAR(32) NOT NULL,
patente VARCHAR(6) NOT NULL,

CONSTRAINT pk_tarjeta
PRIMARY KEY (id_tarjeta),

CONSTRAINT pk_tarjeta_tipos_tarjeta
FOREIGN KEY (tipo) REFERENCES Tipos_tarjeta(tipo),

CONSTRAINT pk_tarjeta_automoviles
FOREIGN KEY(patente) REFERENCES Automoviles(patente)


) ENGINE = InnoDB;

CREATE TABLE Inspectores (

legajo INT UNSIGNED NOT NULL AUTO_INCREMENT,
dni INT UNSIGNED NOT NULL,
nombre VARCHAR(32) NOT NULL,
apellido VARCHAR(32) NOT NULL,
password VARCHAR(32) NOT NULL,

CONSTRAINT pk_inspectores
PRIMARY KEY (legajo)

) ENGINE = InnoDB;

CREATE TABLE Ubicaciones (

calle VARCHAR(32) NOT NULL,
altura INT UNSIGNED NOT NULL,
tarifa DECIMAL(5,2) UNSIGNED NOT NULL,

CONSTRAINT pk_ubicaciones
PRIMARY KEY (calle,altura)


) ENGINE = InnoDB;

CREATE TABLE Parquimetros (

id_parq INT UNSIGNED NOT NULL,
numero INT UNSIGNED NOT NULL,
altura INT UNSIGNED NOT NULL,
calle VARCHAR(20) NOT NULL,

CONSTRAINT pk_parq 
PRIMARY KEY (id_parq),

FOREIGN KEY (calle,altura) REFERENCES Ubicaciones(calle,altura)
ON DELETE RESTRICT ON UPDATE CASCADE

) ENGINE = InnoDB;

#--------------------------------------------------------------------------Creaci�n tablas relaciones--------------------------------------------------------------------------------------------------#

CREATE TABLE Estacionamientos(
	id_tarjeta INT unsigned NOT NULL,
	id_parq INT unsigned NOT NULL,
	fecha_ent date NOT NULL,
	hora_ent time NOT NULL,
	fecha_sal date,
	hora_sal time,

	CONSTRAINT pk_estacionamiento
	PRIMARY KEY (id_parq,fecha_ent,hora_ent),

	FOREIGN KEY (id_tarjeta) REFERENCES Tarjetas(id_tarjeta)
	ON DELETE RESTRICT ON UPDATE CASCADE,

	FOREIGN KEY (id_parq) REFERENCES Parquimetros(id_parq)
	ON DELETE RESTRICT ON UPDATE CASCADE

	
)ENGINE=InnoDB;

CREATE TABLE Accede(
	legajo INT UNSIGNED NOT NULL,
	id_parq INT UNSIGNED NOT NULL,
	fecha date NOT NULL,
	hora time NOT NULL,

	CONSTRAINT pk_accede 
	PRIMARY KEY (id_parq,fecha,hora),

	FOREIGN KEY (legajo) REFERENCES Inspectores(legajo)
	ON DELETE RESTRICT ON UPDATE CASCADE,

	FOREIGN KEY (id_parq) REFERENCES Parquimetros(id_parq) 
    ON DELETE RESTRICT ON UPDATE CASCADE

)ENGINE=InnoDB;

CREATE TABLE Asociado_con(
	id_asociado_con INT UNSIGNED NOT NULL AUTO_INCREMENT,
	legajo INT UNSIGNED NOT NULL,
	calle VARCHAR(20) NOT NULL,
	altura INT UNSIGNED NOT NULL,
	dia ENUM('do','lu','ma','mi','ju','vi','sa') NOT NULL,
	turno ENUM('M','T') NOT NULL,

	CONSTRAINT pk_asociado
	PRIMARY KEY (id_asociado_con),

	FOREIGN KEY (legajo) REFERENCES Inspectores(legajo)
	ON DELETE RESTRICT ON UPDATE CASCADE,

	FOREIGN KEY (calle,altura) REFERENCES Ubicaciones(calle,altura)
	ON DELETE RESTRICT ON UPDATE CASCADE

)ENGINE=InnoDB;

CREATE TABLE Multa(
	numero INT UNSIGNED NOT NULL AUTO_INCREMENT,
	fecha date NOT NULL,
	hora time NOT NULL,
	patente VARCHAR(6) NOT NULL,
	id_asociado_con INT unsigned NOT NULL,

	CONSTRAINT pk_multa
	PRIMARY KEY (numero),

	FOREIGN KEY (patente) REFERENCES Automoviles(patente)
	ON DELETE RESTRICT ON UPDATE CASCADE,

	FOREIGN KEY (id_asociado_con) REFERENCES Asociado_con(id_asociado_con)
	ON DELETE RESTRICT ON UPDATE CASCADE

)ENGINE=InnoDB;


#-----------------------------------------------------------Creaci�n Vista inspector--------------------------------------------------------------------------------------#

#Vista de prueba

CREATE VIEW estacionados AS
        SELECT patente,calle,altura
		FROM Tarjetas NATURAL JOIN Parquimetros NATURAL JOIN Estacionamientos
        WHERE fecha_sal IS NULL;


#-----------------------------------------------------------Creaci�n Usuarios---------------------------------------------------------------------------------------------#

#Elimina al usuario vacio.
#DROP USER ''@localhost;

#############################################################ADMIN################################################################################

#Creo el usuario admin que tiene acceso a todas las tablas de la base de datos
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin';

#Privilegios
GRANT ALL PRIVILEGES ON parquimetros.* TO 'admin'@'localhost' WITH GRANT OPTION;

#############################################################INSPECTOR#############################################################################

#Creo el usuario inspector que tiene acceso a estacionados, inspectores, multa, accede, parquímetros
CREATE USER 'inspector'@'%' IDENTIFIED BY 'inspector';

#Privilegios
GRANT SELECT ON parquimetros.Inspectores TO 'inspector'@'%';
GRANT SELECT ON parquimetros.Estacionados TO 'inspector'@'%';
GRANT SELECT ON parquimetros.Multa TO 'inspector'@'%';
GRANT SELECT ON parquimetros.Accede TO 'inspector'@'%';
GRANT SELECT ON parquimetros.Parquimetros TO 'inspector'@'%';
GRANT SELECT ON parquimetros.Asociado_con TO 'inspector'@'%';
GRANT INSERT ON parquimetros.Multa TO 'inspector'@'%';
GRANT INSERT ON parquimetros.Accede TO 'inspector'@'%';

#############################################################VENTA#################################################################################

#Creo el usuario venta que tiene acceso a estacionados
CREATE USER 'venta'@'%' IDENTIFIED BY 'venta';

#Privilegios
GRANT INSERT ON parquimetros.Tarjetas TO 'venta'@'%';
GRANT SELECT ON parquimetros.Automoviles TO 'venta'@'%';
GRANT SELECT ON parquimetros.Tipos_tarjeta TO 'venta'@'%';
GRANT SELECT ON parquimetros.Tarjetas TO 'venta'@'%';
CREATE SCHEMA ProyectoGrupo3;

USE ProyectoGrupo3;

CREATE TABLE categoria(
	categoria_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nomCategoria VARCHAR (25)

);

CREATE TABLE producto(
	producto_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    sku INTEGER,
    nombreProducto VARCHAR(25),
    talla VARCHAR(10),
    stock INTEGER,
    tipoCuerpo VARCHAR(25),
    precio INTEGER,
    cantMinima INTEGER

);

ALTER TABLE producto ADD categoria_id INTEGER NOT NULL;
ALTER TABLE producto
ADD FOREIGN KEY (categoria_id) REFERENCES categoria (categoria_id);


CREATE TABLE usuaria(
	usuaria_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(25),
    apellido VARCHAR(25),
    telefono INTEGER,
    correo VARCHAR(50),
    contrasenia VARCHAR (25)

);

#Poblar usuaria para probar que está conectado con java
INSERT INTO usuaria (nombre, apellido, telefono, correo, contrasenia)
VALUES ("Fernanda", "Bahamondes", 945612784, "fernanda@fenoseri.cl", "fenia123");

INSERT INTO usuaria (nombre, apellido, telefono, correo, contrasenia)
VALUES ("Diana", "Gutiérrez", 945781236, "diana@fenoseri.cl", "diania145");

INSERT INTO usuaria (nombre, apellido, telefono, correo, contrasenia)
VALUES ("Samantha", "Soto", 956874512, "samantha@jijijaja.cl", "sami458");

INSERT INTO usuaria (nombre, apellido, telefono, correo, contrasenia)
VALUES ("Sofia", "Vidal", 945261548, "sofia@jijijaja.cl", "sofia4545");

CREATE TABLE direccion(
	direccion_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    calle VARCHAR (25),
    numDireccion INTEGER,
    casaDpto VARCHAR (25),
    region VARCHAR (50),
    comuna VARCHAR (25)

);

ALTER TABLE direccion ADD usuaria_id INTEGER NOT NULL;
ALTER TABLE direccion
ADD FOREIGN KEY (usuaria_id) REFERENCES usuaria (usuaria_id);

CREATE TABLE boleta(
	boleta_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    medioDePago VARCHAR (25),
    fecha DATE,
    total INTEGER
);

ALTER TABLE boleta ADD usuaria_id INTEGER NOT NULL;
ALTER TABLE boleta
ADD FOREIGN KEY (usuaria_id) REFERENCES usuaria (usuaria_id);

ALTER TABLE boleta ADD direccion_id INTEGER NOT NULL;
ALTER TABLE boleta
ADD FOREIGN KEY (direccion_id) REFERENCES direccion (direccion_id);

CREATE TABLE carrito(
	carrito_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
	cantidad INTEGER,
    precioTotal INTEGER
);

ALTER TABLE carrito ADD producto_id INTEGER NOT NULL;
ALTER TABLE carrito
ADD FOREIGN KEY (producto_id) REFERENCES producto (producto_id);

#Tabla relacional carrito y boleta
CREATE TABLE carritoBoleta(
	carritoBoleta_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL

);

ALTER TABLE carritoBoleta ADD carrito_id INTEGER NOT NULL;
ALTER TABLE carritoBoleta
ADD FOREIGN KEY (carrito_id) REFERENCES carrito (carrito_id);

ALTER TABLE carritoBoleta ADD boleta_id INTEGER NOT NULL;
ALTER TABLE carritoBoleta
ADD FOREIGN KEY (boleta_id) REFERENCES boleta (boleta_id);

#megusta y fuerza son emojis que se puede interactuar
CREATE TABLE publicacion(
	publicacion_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    mensaje VARCHAR (150),
    megusta INTEGER, 
    fuerza INTEGER
);

#Poblar la tabla publicacion para ver si se conecta con java
INSERT INTO publicacion (mensaje, megusta, fuerza, usuaria_id)
VALUES("hoy desperté más feliz", 5, 3, 2);

INSERT INTO publicacion (mensaje, megusta, fuerza, usuaria_id)
VALUES("ayer pude levantar 50 kilos en el gym", 5, 9, 3);

INSERT INTO publicacion (mensaje, megusta, fuerza, usuaria_id)
VALUES("hoy desperté más feliz", 5, 3, 2);


#Comentarios a las publicaciones
CREATE TABLE comentarios(
	comentario_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    comentario VARCHAR(150)
);

ALTER TABLE comentarios ADD usuaria_id INTEGER NOT NULL;
ALTER TABLE comentarios
ADD FOREIGN KEY (usuaria_id) REFERENCES usuaria (usuaria_id);

ALTER TABLE comentarios ADD publicacion_id INTEGER NOT NULL;
ALTER TABLE comentarios
ADD FOREIGN KEY (publicacion_id) REFERENCES publicacion (publicacion_id);

ALTER TABLE publicacion ADD usuaria_id INTEGER NOT NULL;
ALTER TABLE publicacion
ADD FOREIGN KEY (usuaria_id) REFERENCES usuaria (usuaria_id);

#añadir a profesionales
CREATE TABLE profesional(
	profesional_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    area VARCHAR(50),
    nombreProfesional VARCHAR(50),
    apellidoProfesional VARCHAR (50),
    correo VARCHAR(50), 
    telefono INTEGER

);

CREATE TABLE logro(
	logro_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nombreLogro VARCHAR(50),
    completado BOOLEAN

);

ALTER TABLE logro ADD usuaria_id INTEGER NOT NULL;
ALTER TABLE logro
ADD FOREIGN KEY (usuaria_id) REFERENCES usuaria (usuaria_id);

#datetime indica fecha y hora
CREATE TABLE horaTomada(
	horaTomada_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    fecha DATETIME

);

ALTER TABLE horaTomada ADD usuaria_id INTEGER NOT NULL;
ALTER TABLE horaTomada
ADD FOREIGN KEY (usuaria_id) REFERENCES usuaria (usuaria_id);

ALTER TABLE horaTomada ADD profesional_id INTEGER NOT NULL;
ALTER TABLE horaTomada
ADD FOREIGN KEY (profesional_id) REFERENCES profesional (profesional_id);

#**************************************************************************
#Eliminar la tabla producto
#primero se elimina la relacion luego la tabla
ALTER TABLE carritoBoleta DROP constraint carritoboleta_ibfk_1;
DROP TABLE carritoBoleta CASCADE;
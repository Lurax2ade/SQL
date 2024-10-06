
 
 -------------------------------------------------------------------------------------------------------------------------------
--  Borrar registros (delete) 
 -------------------------------------------------------------------------------------------------------------------------------

-- Para eliminar los registros de una tabla usamos el comando "delete":

--  delete from usuarios;

-- Muestra un mensaje indicando la cantidad de registros que ha eliminado.

-- Si no queremos eliminar todos los registros, sino solamente algunos, debemos indicar cuál o cuáles, para ello utilizamos el comando "delete" junto con la clausula "where" con la cual establecemos la condición que deben cumplir los registros a borrar.

-- Por ejemplo, queremos eliminar aquel registro cuyo nombre de usuario es "Marcelo":

--  delete from usuarios
--  where nombre='Marcelo';

-- Si solicitamos el borrado de un registro que no existe, es decir, ningún registro cumple con la condición especificada, ningún registro será eliminado.

-- Tenga en cuenta que si no colocamos una condición, se eliminan todos los registros de la tabla nombrada.
-- Servidor de SQL Server instalado en forma local.

-- Ingresemos el siguiente lote de comandos en el SQL Server Management Studio:

-- if object_id('usuarios') is not null
--   drop table usuarios;

-- create table usuarios(
--   nombre varchar(30),
--   clave varchar(10)
-- );

-- go

-- insert into usuarios (nombre,clave)
--   values ('Marcelo','River');
-- insert into usuarios (nombre,clave)
--   values ('Susana','chapita');
-- insert into usuarios (nombre,clave)
--   values ('CarlosFuentes','Boca');
-- insert into usuarios (nombre,clave)
--   values ('FedericoLopez','Boca');

-- select * from usuarios;

-- -- Eliminamos el registro cuyo nombre de usuario es "Marcelo"
-- delete from usuarios
--   where nombre='Marcelo';

-- select * from usuarios;

-- -- Intentamos eliminarlo nuevamente (no se borra registro)
-- delete from usuarios
--  where nombre='Marcelo';

-- select * from usuarios;

-- -- Eliminamos todos los registros cuya clave es 'Boca'
-- delete from usuarios
--   where clave='Boca';

-- select * from usuarios;

-- -- Eliminemos todos los registros
-- delete from usuarios;

-- select * from usuarios;







-- 1---:********************************** Primer problema **********************************

-- Trabaje con la tabla "agenda" que registra la información referente a sus amigos.

-- 1- Elimine la tabla si existe:

if object_id('agenda') is not null
drop table agenda;



-- 2- Cree la tabla con los siguientes campos: apellido (cadena de 30), nombre (cadena de 20), 
-- domicilio (cadena de 30) y telefono (cadena de 11):

create table agenda(
  apellido varchar(30),
  nombre varchar(20),
  domicilio varchar(30),
  telefono varchar (11)
  );


-- 3- Ingrese los siguientes registros (insert into):

insert into agenda (apellido, nombre, domicilio, telefono)
values( 'Alvarez','Alberto','Colon 123',4234567,
);

insert into agenda (apellido, nombre, domicilio, telefono)
values( 'Juarez','Juan','Avellaneda 135',4458787,
);

insert into agenda (apellido, nombre, domicilio, telefono)
values( 'Lopez','Maria','Urquiza 333','4545454',
);

insert into agenda (apellido, nombre, domicilio, telefono)
values( 'Lopez','Jose','Urquiza 333','4545454',
);

insert into agenda (apellido, nombre, domicilio, telefono)
values( 'Salas','Susana,Gral', 'Paz 1234','4123456'
);

-- 4- Elimine el registro cuyo nombre sea "Juan" (1 registro afectado)

delete from agenda
where nombre='Juan';

-- 5- Elimine los registros cuyo número telefónico sea igual a "4545454" (2 registros afectados):

delete from agenda 
where telefono="4545454";

-- 6- Muestre la tabla.

select* from agenda;

-- 7- Elimine todos los registros (2 registros afectados):

delete from agenda;

-- 8- Muestre la tabla.

select* from agenda;





 







-- ********************* Segundo problema *********************



-- Un comercio que vende artículos de computación registra los datos de sus artículos en una tabla con 
-- ese nombre.

-- 1- Elimine "articulos", si existe:

if object_id('articulos') is not null
drop table articulos;


-- 2- Cree la tabla, con la siguiente estructura:

 create table articulos(
  codigo integer,
  nombre varchar(20),
  descripcion varchar(30),
  precio float,
  cantidad integer
 );

-- 3- Vea la estructura de la tabla.

exec sp_ columns articulos;

-- 4- Ingrese algunos registros:

 insert into articulos (codigo, nombre, descripcion, precio,cantidad)
  values (1,'impresora','Epson Stylus C45',400.80,20);

 insert into articulos (codigo, nombre, descripcion, precio,cantidad)
  values (2,'impresora','Epson Stylus C85',500,30);

 insert into articulos (codigo, nombre, descripcion, precio,cantidad)
  values (3,'monitor','Samsung 14',800,10);

 insert into articulos (codigo, nombre, descripcion, precio,cantidad)
  values (4,'teclado','ingles Biswal',100,50);

 insert into articulos (codigo, nombre, descripcion, precio,cantidad)
  values (5,'teclado','español Biswal',90,50);

-- 5- Elimine los artículos cuyo precio sea mayor o igual a 500 (2 registros)

delete from articulos
where precio >=500;


-- 7- Elimine todas las impresoras (1 registro)

delete from articulos
where nombre ='impresora';



-- 8- Elimine todos los artículos cuyo código sea diferente a 4 (1 registro)

delete from articulos
where codigo <>4;



-- 9- Mostrar la tabla después que borra cada registro.

 select * from articulos;





 


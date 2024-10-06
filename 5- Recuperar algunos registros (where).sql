
 
 ------------------------------------------------------------------------------------------------------------------
--  Recuperar algunos registros (where) 
 ------------------------------------------------------------------------------------------------------------------

-- Hemos aprendido a seleccionar algunos campos de una tabla.
-- También es posible recuperar algunos registros.

-- Existe una cláusula, "where" con la cual podemos especificar condiciones para una consulta "select". Es decir, podemos recuperar algunos registros, sólo los que cumplan con ciertas condiciones indicadas con la cláusula "where". Por ejemplo, queremos ver el usuario cuyo nombre es "Marcelo", para ello utilizamos "where" y luego de ella, la condición:

--  select nombre, clave
--   from usuarios
--   where nombre='Marcelo';

-- La sintaxis básica y general es la siguiente:

--  select NOMBRECAMPO1, ..., NOMBRECAMPOn
--   from NOMBRETABLA
--   where CONDICION;

-- Para las condiciones se utilizan operadores relacionales (tema que trataremos más adelante en detalle). El signo igual(=) es un operador relacional.
-- Para la siguiente selección de registros especificamos una condición que solicita los usuarios cuya clave es igual a "River":

--  select nombre,clave
--   from usuarios
--   where clave='River';

-- Si ningún registro cumple la condición establecida con el "where", no aparecerá ningún registro.

-- Entonces, con "where" establecemos condiciones para recuperar algunos registros.

-- Para recuperar algunos campos de algunos registros combinamos en la consulta la lista de campos y la cláusula "where":

--  select nombre
--   from usuarios
--   where clave='River';

-- En la consulta anterior solicitamos el nombre de todos los usuarios cuya clave sea igual a "River".
-- Servidor de SQL Server instalado en forma local.

-- Ingresemos el siguiente lote de comandos en el SQL Server Management Studio:

-- if object_id('usuarios') is not null
--   drop table usuarios;

-- create table usuarios (
--   nombre varchar(30),
--   clave varchar(10)
-- );

-- go 

-- exec sp_columns usuarios;

-- insert into usuarios (nombre, clave)
--   values ('Marcelo','Boca');
-- insert into usuarios (nombre, clave)
--   values ('JuanPerez','Juancito');
-- insert into usuarios (nombre, clave)
--   values ('Susana','River');
-- insert into usuarios (nombre, clave)
--   values ('Luis','River');

-- -- Recuperamos el usuario cuyo nombre es "Leonardo"
-- select * from usuarios
--   where nombre='Leonardo';

-- -- Recuperamos el nombre de los usuarios cuya clave es "River"
-- select nombre from usuarios
--   where clave='River';

-- -- Recuperamos el nombres de los usuarios cuya clave es "Santi"
-- select nombre from usuarios
--   where clave='Santi';







-- 1---:********************************** Primer problema **********************************


-- Trabaje con la tabla "agenda" en la que registra los datos de sus amigos.

-- 1- Elimine "agenda", si existe:

if object_id('agenda') is not null
drop table agenda;


-- 2- Cree la tabla, con los siguientes campos: apellido (cadena de 30), nombre (cadena de 20), 
-- domicilio (cadena de 30) y telefono (cadena de 11).

create table agenda(
  apellido varchar(30),
  nombre varchar(20),
  domicilio varchar(30), 
  telefono varchar (11)
);

-- 3- Visualice la estructura de la tabla "agenda".

exec sp_columns agenda;

-- 4- Ingrese los siguientes registros:

insert into agenda( apellido, nombre, domicilio, telefono)
values ( 'Acosta', 'Ana', 'Colon 123', '4234567');


insert into agenda( apellido, nombre, domicilio, telefono)
values ( 'Bustamante', 'Betina', 'Avellaneda 135', '4458787');

insert into agenda( apellido, nombre, domicilio, telefono)
values ( 'Lopez', 'Hector', 'Salta 545', '4887788');

insert into agenda( apellido, nombre, domicilio, telefono)
values ( 'Lopez', 'Luis', 'Urquiza 333', '4545454');

insert into agenda( apellido, nombre, domicilio, telefono)
values ( 'Lopez', 'Marisa', 'Urquiza 333', '4545454');


-- 5- Seleccione todos los registros de la tabla

select * from agenda;

-- 6- Seleccione el registro cuyo nombre sea "Marisa" (1 registro)

select * from agenda
where nombre='Marisa';

-- 7- Seleccione los nombres y domicilios de quienes tengan apellido igual a "Lopez" (3 registros)

select nombre, domicilio from agenda
where apellido='Lopez';

-- 8- Muestre el nombre de quienes tengan el teléfono "4545454" (2 registros)

select nombre from agenda
where telefono='4545454';

 







-- ********************* Segundo problema *********************




-- Trabaje con la tabla "libros" de una librería que guarda información referente a sus libros 
-- disponibles para la venta.

-- 1- Elimine la tabla si existe.

if object_id('libros') is not null
drop table libros;

-- 2- Cree la tabla "libros". Debe tener la siguiente estructura:

 create table libros (
  titulo varchar(20),
  autor varchar(30),
  editorial varchar(15));

-- 3- Visualice la estructura de la tabla "libros".

exec sp_columns libros;

-- 4- Ingrese los siguientes registros:

insert into libros (titulo, autor, editorial)
values('El aleph','Borges','Emece');


insert into libros (titulo, autor, editorial)
values('Martin Fierro','Jose Hernandez','Emece');


insert into libros (titulo, autor, editorial)
values('Martin Fierro','Jose Hernandez','Planeta');


insert into libros (titulo, autor, editorial)
values('Aprenda PHP','Mario Molina','Siglo XXI');



-- 5- Seleccione los registros cuyo autor sea "Borges" (1 registro)

select * from libros
where autor='Borges';

-- 6- Seleccione los títulos de los libros cuya editorial sea "Emece" (2 registros)

select titulo from libros
where editorial='Emece';

-- 7- Seleccione los nombres de las editoriales de los libros cuyo titulo sea "Martin Fierro" (2 
-- registros)

select editorial from libros
where titulo= 'Martin Fierro';

 



 
 -------------------------------------------------------------------------------------------------------------------------------
--  Insertar y recuperar registros de una tabla (insert into - select) 
 -------------------------------------------------------------------------------------------------------------------------------


-- Un registro es una fila de la tabla que contiene los datos propiamente dichos. Cada registro tiene un dato por cada columna (campo). Nuestra tabla "usuarios" consta de 2 campos, "nombre" y "clave".

-- Al ingresar los datos de cada registro debe tenerse en cuenta la cantidad y el orden de los campos.

-- La sintaxis básica y general es la siguiente:

--  insert into NOMBRETABLA (NOMBRECAMPO1, ..., NOMBRECAMPOn)
--  values (VALORCAMPO1, ..., VALORCAMPOn);

-- Usamos "insert into", luego el nombre de la tabla, detallamos los nombres de los campos entre paréntesis y separados por comas y luego de la cláusula "values" colocamos los valores para cada campo, también entre paréntesis y separados por comas.

-- Para agregar un registro a la tabla tipeamos:

--  insert into usuarios (nombre, clave) values ('Mariano','payaso');

-- Note que los datos ingresados, como corresponden a cadenas de caracteres se colocan entre comillas simples.

-- Para ver los registros de una tabla usamos "select":

--  select * from usuarios;

-- El comando "select" recupera los registros de una tabla.
-- Con el asterisco indicamos que muestre todos los campos de la tabla "usuarios".

-- Es importante ingresar los valores en el mismo orden en que se nombran los campos:

--  insert into usuarios (clave, nombre) values ('River','Juan');

-- En el ejemplo anterior se nombra primero el campo "clave" y luego el campo "nombre" por eso, los valores también se colocan en ese orden.

-- Si ingresamos los datos en un orden distinto al orden en que se nombraron los campos, no aparece un mensaje de error y los datos se guardan de modo incorrecto.

-- En el siguiente ejemplo se colocan los valores en distinto orden en que se nombran los campos, el valor de la clave (la cadena "Boca") se guardará en el campo "nombre" y el valor del nombre (la cadena "Luis") en el campo "clave":

--  insert into usuarios (nombre,clave) values ('Boca','Luis');

-- Servidor de SQL Server instalado en forma local.

-- Ingresemos el siguiente lote de comandos en el SQL Server Management Studio:

--  if object_id('usuarios') is not null
--   drop table usuarios;

--  create table usuarios(
--   nombre varchar(30),
--   clave varchar(10)
--  );

--  insert into usuarios (nombre, clave) values ('Mariano','payaso');

--  select * from usuarios;

--  insert into usuarios (clave, nombre) values ('River','Juan');

--  select * from usuarios;

--  insert into usuarios (nombre,clave) values ('Boca','Luis');

--  select * from usuarios;






-- 1---:********************************** Primer problema **********************************


-- Trabaje con la tabla "agenda" que almacena información de sus amigos.

-- 1- Elimine la tabla "agenda", si existe:

if object_id('agenda') is not null
drop table agenda;



-- 2- Cree una tabla llamada "agenda". Debe tener los siguientes campos: apellido (cadena de 30), 
-- nombre (cadena de 20), domicilio (cadena de 30) y telefono (cadena de 11):

create table agenda(
  apellido varchar (30),
  nombre varchar (20),
  domicilio varchar (30),
  telefono varchar(11)
);

-- 3- Visualice las tablas existentes para verificar la creación de "agenda" (exec sp_tables @table_owner='dbo').

exec sp_ tables @table_owner='dbo';

-- 4- Visualice la estructura de la tabla "agenda" (sp_columns).

exec sp_columns;

-- 5- Ingrese los siguientes registros: ('Moreno','Alberto','Colon 123','4234567') y ('Torres','Juan','Avellaneda 135','4458787')


insert into agenda (apellido, nombre, domicilio, telefono)
values('Moreno','Alberto','Colon 123','4234567');

insert into agenda (apellido,nombre, domicilio, telefono)
values ('Torres','Juan','Avellaneda 135','4458787');



-- 6- Seleccione todos los registros de la tabla:

select * from agenda;


-- 7- Elimine la tabla "agenda":

drop table agenda;


-- 8- Intente eliminar la tabla nuevamente (aparece un mensaje de error):

drop table agenda;



 



-- ********************* Segundo problema *********************



-- Trabaje con la tabla "libros" que almacena los datos de los libros de su propia biblioteca.

-- 1- Elimine la tabla "libros", si existe:


if object_id('libros') is not null
drop table libros;



-- 2- Cree una tabla llamada "libros". Debe definirse con los siguientes campos: titulo (cadena de 20), 
-- autor (cadena de 30) y editorial (cadena de 15).

create table libros(
  titulo varchar(20), 
  autor varchar(30), 
  aditorial varchar(15)
);

-- 3- Visualice las tablas existentes (exec sp_tables @table_owner='dbo').

exec sp_tables @tables_owner='dbo';

-- 4- Visualice la estructura de la tabla "libros" (sp_columns).

exec sp_columns libros;

-- 5- Ingrese los siguientes registros:

 insert into libros (titulo,autor,editorial)
  values ('El aleph','Borges','Planeta');
 insert into libros (titulo,autor,editorial) 
  values ('Martin Fierro','Jose Hernandez','Emece');
 insert into libros (titulo,autor,editorial)
  values ('Aprenda PHP','Mario Molina','Emece');

-- 6- Muestre todos los registros (select).

select * from libros;
 



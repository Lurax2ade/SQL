
 ------------------------------------------------------------------------------------------------------------------
--  Tipos de datos básicos 
 ------------------------------------------------------------------------------------------------------------------


-- a explicamos que al crear una tabla debemos resolver qué campos (columnas) tendrá y que tipo de datos almacenará cada uno de ellos, es decir, su estructura.

-- El tipo de dato especifica el tipo de información que puede guardar un campo: caracteres, números, etc.

-- Estos son algunos tipos de datos básicos de SQL Server (posteriormente veremos otros):

--     varchar: se usa para almacenar cadenas de caracteres. Una cadena es una secuencia de caracteres. Se coloca entre comillas (simples); ejemplo: 'Hola', 'Juan Perez'. El tipo "varchar" define una cadena de longitud variable en la cual determinamos el máximo de caracteres entre paréntesis. Puede guardar hasta 8000 caracteres. Por ejemplo, para almacenar cadenas de hasta 30 caracteres, definimos un campo de tipo varchar(30), es decir, entre paréntesis, junto al nombre del campo colocamos la longitud.
--     Si asignamos una cadena de caracteres de mayor longitud que la definida, la cadena no se carga, aparece un mensaje indicando tal situación y la sentencia no se ejecuta.
--     Por ejemplo, si definimos un campo de tipo varchar(10) e intentamos asignarle la cadena 'Buenas tardes', aparece un mensaje de error y la sentencia no se ejecuta.
--     integer: se usa para guardar valores numéricos enteros, de -2000000000 a 2000000000 aprox. Definimos campos de este tipo cuando queremos representar, por ejemplo, cantidades.
--     float: se usa para almacenar valores numéricos con decimales. Se utiliza como separador el punto (.). Definimos campos de este tipo para precios, por ejemplo.

-- Antes de crear una tabla debemos pensar en sus campos y optar por el tipo de dato adecuado para cada uno de ellos.
-- Por ejemplo, si en un campo almacenaremos números enteros, el tipo "float" sería una mala elección; si vamos a guardar precios, el tipo "float" es más adecuado, no así "integer" que no tiene decimales. Otro ejemplo, si en un campo vamos a guardar un número telefónico o un número de documento, usamos "varchar", no "integer" porque si bien son dígitos, con ellos no realizamos operaciones matemáticas.
-- Servidor de SQL Server instalado en forma local.

-- Ingresemos el siguiente lote de comandos en el SQL Server Management Studio:

-- if object_id('libros') is not null
--   drop table libros;

--  create table libros(
--   titulo varchar(80),
--   autor varchar(40),
--   editorial varchar(30),
--   precio float,
--   cantidad integer
--  );

--  exec sp_columns libros;

--  insert into libros (titulo,autor,editorial,precio, cantidad)
--   values ('El aleph','Borges','Emece',25.50, 100);
--  insert into libros (titulo,autor,editorial,precio,cantidad)
--   values ('Matematica estas ahi','Paenza','Siglo XXI',18.8,200);

--  select * from libros;

--  insert into libros (titulo,autor,editorial,precio,cantidad)
--   values ('Alicia en el pais de las maravillas','Lewis Carroll','Atlantida',10,200);

--  insert into libros (titulo,autor,editorial,precio,cantidad)
--   values ('Alicia en el pais','Lewis Carroll','Atlantida',10,200);

--  select * from libros;

-- Es importante el valor que definimos entre paréntesis luego de la palabra clave varchar. Si definimos el campo titulo de tamaño 80, luego significa que no podemos almacenar un nombre de libro de más de 80 caracteres.







-- 1---:********************************** Primer problema **********************************


-- Un videoclub que alquila películas en video almacena la información de sus películas en una tabla 
-- llamada "peliculas"; para cada película necesita los siguientes datos:

--  -nombre, cadena de caracteres de 20 de longitud,
--  -actor, cadena de caracteres de 20 de longitud,
--  -duración, valor numérico entero.
--  -cantidad de copias: valor entero.

-- 1- Elimine la tabla, si existe:


if object_id('peliculas')is not null
drop table peliculas;


-- 2- Cree la tabla eligiendo el tipo de dato adecuado para cada campo:

create table peliculas(
  nombre varchar(20),
  actor varchar(20),
  duracion integer,
  cantidad integer
);



-- 3- Vea la estructura de la tabla:

exec sp_columns peliculas;

-- 4- Ingrese los siguientes registros:


 insert into peliculas (nombre, actor, duracion, cantidad)
  values ('Mision imposible','Tom Cruise',128,3);
 insert into peliculas (nombre, actor, duracion, cantidad)
  values ('Mision imposible 2','Tom Cruise',130,2);
 insert into peliculas (nombre, actor, duracion, cantidad)
  values ('Mujer bonita','Julia Roberts',118,3);
 insert into peliculas (nombre, actor, duracion, cantidad)
  values ('Elsa y Fred','China Zorrilla',110,2);

-- 5- Muestre todos los registros.


 select * from peliculas;

 



-- ********************* Segundo problema *********************


-- Una empresa almacena los datos de sus empleados en una tabla "empleados" que guarda los siguientes 
-- datos: nombre, documento, sexo, domicilio, sueldobasico.

-- 1- Elimine la tabla, si existe:

if object_id ('empleados') is not null
drop table empleados;


-- 2- Cree la tabla eligiendo el tipo de dato adecuado para cada campo:

create table empleados(
  nombre varchar (20),
  documento varchar(8),
  sexo varchar (1),
  domicilio varchar(30),
  sueldobasico float
);


-- 3- Vea la estructura de la tabla:

exec sp_columns empleados;

-- 4- Ingrese algunos registros:


 insert into empleados (nombre, documento, sexo, domicilio, sueldobasico)
  values ('Juan Perez','22333444','m','Sarmiento 123',500);
 insert into empleados (nombre, documento, sexo, domicilio, sueldobasico)
  values ('Ana Acosta','24555666','f','Colon 134',650);
 insert into empleados (nombre, documento, sexo, domicilio, sueldobasico)
  values ('Bartolome Barrios','27888999','m','Urquiza 479',800);

-- 5- Seleccione todos los registros.


 select * from empleados;




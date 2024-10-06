
 
 ------------------------------------------------------------------------------------------------------------------
--  Recuperar algunos campos (select) 
 ------------------------------------------------------------------------------------------------------------------

-- Hemos aprendido cómo ver todos los registros de una tabla, empleando la instrucción "select".

-- La sintaxis básica y general es la siguiente:

--  select * from NOMBRETABLA;

-- El asterisco (*) indica que se seleccionan todos los campos de la tabla.

-- Podemos especificar el nombre de los campos que queremos ver separándolos por comas:

--  select titulo,autor from libros; 

-- La lista de campos luego del "select" selecciona los datos correspondientes a los campos nombrados. En el ejemplo anterior seleccionamos los campos "titulo" y "autor" de la tabla "libros", mostrando todos los registros. Los datos aparecen ordenados según la lista de selección, en dicha lista los nombres de los campos se separan con comas.
-- Servidor de SQL Server instalado en forma local.

-- Ingresemos el siguiente lote de comandos en el SQL Server Management Studio:

-- -- borramos la tabla libros si ya existe
-- if object_id('libros') is not null
--   drop table libros;

-- -- creamos la tabla libros
-- create table libros(
--   titulo varchar(40),
--   autor varchar(30),
--   editorial varchar(15),
--   precio float,
--   cantidad integer
-- );

-- -- llamamos al procedimiento almacenado sp_columns para conocer los campos
-- -- de la tabla libros
-- exec sp_columns libros;

-- -- insertamos varias filas en la tabla libros
-- insert into libros (titulo,autor,editorial,precio,cantidad)
--   values ('El aleph','Borges','Emece',25.50,100);
-- insert into libros (titulo,autor,editorial,precio,cantidad)
--   values ('Alicia en el pais de las maravillas','Lewis Carroll','Atlantida',10,200);
-- insert into libros (titulo,autor,editorial,precio,cantidad)
--   values ('Matematica estas ahi','Paenza','Siglo XXI',18.8,200);

-- -- recuperamos todas los datos de la tabla libros
-- select * from libros;

-- -- recuperamos solo el titulo, autor y editorial de la tabla libros
-- select titulo,autor,editorial from libros; 

-- -- recuperamos el titulo y el precio
-- select titulo,precio from libros;

-- -- recuperamos la editorial y la cantidad
-- select editorial,cantidad from libros; 

-- Para disponer un comentario y que no lo tenga en cuenta el servidor SQL Server debemos anteceder los caracteres --

-- Es bueno comentar los algoritmos que implementamos sobre todo aquellos que sean complejos de entender.







-- 1---:********************************** Primer problema **********************************


-- Un videoclub que alquila películas en video almacena la información de sus películas en alquiler en 
-- una tabla llamada "peliculas".

-- 1- Elimine la tabla, si existe:

if object_id('peliculas') is not null
drop table peliculas;



-- 2- Cree la tabla:

create table peliculas(
  titulo varchar(20). 
  actor varchar(20),
  duracion integer, 
  cantidad integer
);

-- 3- Vea la estructura de la tabla (sp_columns).

exec sp_columns peliculas;

-- 4- Ingrese alos siguientes registros:

insert into peliculas(titulo, actor, duracion, cantidad)
values ('Mision imposible','Tom Cruise',180,3);

insert into peliculas (titulo, actor, duracion, cantidad)
values ('Mision imposible 2','Tom Cruise',190,2);

insert into peliculas (titulo, actor, duracion, cantidad)
values ('Mujer bonita','Julia Roberts',118,3);
 
insert into peliculas (titulo, actor, duracion, cantidad)
values ('Elsa y Fred','China Zorrilla',110,2);

-- 5- Realice un "select" mostrando solamente el título y actor de todas las películas

select titulo, actor from peliculas;

-- 6- Muestre el título y duración de todas las peliculas

select titulo, duracion from peliculas;

-- 7- Muestre el título y la cantidad de copias

select titulo, cantidad from peliculas; 








-- ********************* Segundo problema *********************




--  Una empresa almacena los datos de sus empleados en una tabla llamada "empleados".

-- 1- Elimine la tabla, si existe:

if object_id('empleados') is not null
drop table empleados;



-- 2- Cree la tabla:
 create table empleados(
  nombre varchar(20),
  documento varchar(8), 
  sexo varchar(1),
  domicilio varchar(30),
  sueldobasico float
 );

-- 3- Vea la estructura de la tabla:


exec sp_columns empleados;

-- 4- Ingrese algunos registros:

insert into empleados(nombre, documento, sexo, domicilio, sueldobasico)
values ('Juan Juarez','22333444','m','Sarmiento 123',500);
 
insert into empleados (nombre, documento, sexo, domicilio, sueldobasico)
values ('Ana Acosta','27888999','f','Colon 134',700);

insert into empleados (nombre, documento, sexo, domicilio, sueldobasico)
values ('Carlos Caseres','31222333','m','Urquiza 479',850);

-- 5- Muestre todos los datos de los empleados

select * from empleados;

-- 6- Muestre el nombre, documento y domicilio de los empleados

select nombre, documento, domicilio from empleados;

-- 7- Realice un "select" mostrando el documento, sexo y sueldo básico de todos los empleados

 select documento,sexo,sueldobasico from empleados;

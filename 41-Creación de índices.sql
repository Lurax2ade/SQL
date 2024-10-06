
 -------------------------------------------------------------------------------------------------------------------------------
-- 	Creación de índices
 -------------------------------------------------------------------------------------------------------------------------------

-- Para crear índices empleamos la instrucción "create index".

-- La sintaxis básica es la siguiente:

--  create TIPODEINDICE index NOMBREINDICE
--  on TABLA(CAMPO);

-- "TIPODEINDICE" indica si es agrupado (clustered) o no agrupado (nonclustered). Si no especificamos crea uno No agrupado. 
--Independientemente de si es agrupado o no, también se puede especificar que sea "unique", es decir, no haya valores repetidos. 
--Si se intenta crear un índice unique para un campo que tiene valores duplicados, SQL Server no lo permite.

-- En este ejemplo se crea un índice agrupado único para el campo "codigo" de la tabla "libros":

--  create unique clustered index I_libros_codigo
--  on libros(codigo);

-- Para identificar los índices fácilmente, podemos agregar un prefijo al nombre del índice, por ejemplo "I" y luego el nombre de la tabla y/o campo.

-- En este ejemplo se crea un índice no agrupado para el campo "titulo" de la tabla "libros":

--  create nonclustered index I_libros_titulo
--  on libros(titulo);

-- Un índice puede tener más de un campo como clave, son índices compuestos. Los campos de un índice compuesto tienen que ser de la misma tabla (excepto cuando se crea en una vista - tema que veremos posteriormente).

-- Creamos un índice compuesto para el campo "autor" y "editorial":

--  create index I_libros_autoreditorial
--  on libros(autor,editorial);

-- SQL Server crea automáticamente índices cuando se establece una restricción "primary key" o "unique" en una tabla. Al crear una restricción "primary key", si no se especifica, el índice será agrupado (clustered) a menos que ya exista un índice agrupado para dicha tabla. Al crear una restricción "unique", si no se especifica, el índice será no agrupado (non-clustered).

-- Ahora podemos entender el resultado del procedimiento almacenado "sp_helpconstraint" cuando en la columna "constraint_type" mostraba el tipo de índice seguido de las palabras "clustered" o "non_clustered".

-- Puede especificarse que un índice sea agrupado o no agrupado al agregar estas restricciones.
-- Agregamos una restricción "primary key" al campo "codigo" de la tabla "libros" especificando que cree un índice NO agrupado:

--  alter table libros
--   add constraint PK_libros_codigo
--   primary key nonclustered (codigo);

-- Para ver los indices de una tabla:

--  exec sp_helpindex libros;

-- Muestra el nombre del índice, si es agrupado (o no), primary (o unique) y el campo por el cual se indexa.

-- Todos los índices de la base de datos activa se almacenan en la tabla del sistema "sysindexes", podemos consultar dicha tabla tipeando:

--  select name from sysindexes;

-- Para ver todos los índices de la base de datos activa creados por nosotros podemos tipear la siguiente consulta:

--  select name from sysindexes
--   where name like 'I_%';


-- ********************* primer problema *********************

-- Un profesor guarda algunos datos de sus alumnos en una tabla llamada "alumnos".
-- 1- Elimine la tabla si existe y créela con la siguiente estructura:

if object_id('alumnos') is not null
drop table alumnos;


 create table alumnos(
  legajo char(5) not null,
  documento char(8) not null,
  apellido varchar(30),
  nombre varchar(30),
  notafinal decimal(4,2)
 );

-- 2- Ingresamos algunos registros:

insert into alumnos values ('A125','22322222','Rodríguez','Laura',5.54);

 insert into alumnos values ('A123','22222222','Perez','Patricia',5.50);

 insert into alumnos values ('A234','23333333','Lopez','Ana',9);

 insert into alumnos values ('A345','24444444','Garcia','Carlos',8.5);

 insert into alumnos values ('A348','25555555','Perez','Daniela',7.85);

 insert into alumnos values ('A457','26666666','Perez','Fabian',3.2);

 insert into alumnos values ('A589','27777777','Gomez','Gaston',6.90);

-- 3- Intente crear un índice agrupado único para el campo "apellido".
-- No lo permite porque hay valores duplicados.

create unique clustered index I_alumnos_apellido
on alumnos(apellido);


-- 4- Cree un índice agrupado, no único, para el campo "apellido".

create  clustered index I_alumnos_apellido
on alumnos(apellido);

-- 5- Intente establecer una restricción "primary key" al campo "legajo" especificando que cree un 
-- índice agrupado.
-- No lo permite porque ya existe un índice agrupado y solamente puede haber uno por tabla.

alter table alumnos
add constraint PK_alumnos_legajo
primary key clustered (legajo);

-- 6- Establezca la restricción "primary key" al campo "legajo" especificando que cree un índice NO 
-- agrupado.

alter table alumnos
add constraint PK_alumnos_legajo
primary key nonclustered (legajo);


 

-- 7- Vea los índices de "alumnos":

exec sp_helpindex alumnos;

-- 2 índices: uno "I_alumnos_apellido", agrupado, con "apellido" y otro "PK_alumnos_legajo", no 
-- agrupado, unique, con "legajo" que se creó automáticamente al crear la restricción "primary key".

-- 8- Analice la información que muestra "sp_helpconstraint":


 exec sp_helpconstraint alumnos;

-- En la columna "constraint_type" aparece "PRIMARY KEY" y entre paréntesis, el tipo de índice creado.

-- 9- Cree un índice unique no agrupado para el campo "documento".

create unique nonclustered index I_alumnos_documento
on alumnos(documento);

-- 10- Intente ingresar un alumno con documento duplicado.
-- No lo permite.

 insert into alumnos values ('A789','27777777','Morales','Hector',8);

-- 11- Veamos los indices de "alumnos".
-- Aparecen 3 filas, uno por cada índice.

exec sp_helpindex alumnos;


-- 12- Cree un índice compuesto para el campo "apellido" y "nombre".
-- Se creará uno no agrupado porque no especificamos el tipo, además, ya existe uno agrupado y 
-- solamente puede haber uno por tabla.


create  index I_alumnos_apellidonombre
on alumnos(apellido, nombre);




-- 13- Consulte la tabla "sysindexes", para ver los nombres de todos los índices creados para 
-- "alumnos":

select name from sysindexes
where name like '%alumnos%';



-- 4 índices.

-- 14- Cree una restricción unique para el campo "documento".

alter table alumnos
add constraint UQ_alumnos_documento
unique(documento); 

-- 15- Vea la información de "sp_helpconstraint".

exec sp_helpconstraint alumnos;

-- 16- Vea los índices de "alumnos".
-- Aparecen 5 filas, uno por cada índice.


 exec sp_helpindex alumnos;



-- 17- Consulte la tabla "sysindexes", para ver los nombres de todos los índices creados para 
-- "alumnos":


 select name from sysindexes
  where name like '%alumnos%';


-- 5 índices.



-- 18- Consulte la tabla "sysindexes", para ver los nombres de todos los índices creados por usted:

select name from sysindexes
where name like 'I_%';

-- 3 índices. Recuerde que los índices que crea SQL Server automáticamente al agregarse una restricción 
-- "primary" o "unique" no comienzan con "I_".








-- ********************* Segundo problema *********************



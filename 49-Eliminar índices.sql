
 -------------------------------------------------------------------------------------------------------------------------------
-- 		Eliminar índices
 -------------------------------------------------------------------------------------------------------------------------------



-- Los índices creados con "create index" se eliminan con "drop index"; la siguiente es la sintaxis básica:

--  drop index NOMBRETABLA.NOMBREINDICE;

-- Eliminamos el índice "I_libros_titulo":

--  drop index libros.I_libros_titulo;

-- Los índices que SQL Server crea automáticamente al establecer una restricción "primary key" o "unique" no pueden eliminarse con "drop index", se eliminan automáticamente cuando quitamos la restricción.

-- Podemos averiguar si existe un índice para eliminarlo, consultando la tabla del sistema "sysindexes":

--  if exists (select name from sysindexes
--   where name = 'NOMBREINDICE')
--    drop index NOMBRETABLA.NOMBREINDICE;

-- Eliminamos el índice "I_libros_titulo" si existe:

--  if exists (select *from sysindexes
--   where name = 'I_libros_titulo')
--    drop index libros.I_libros_titulo;



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

-- 2- Cree un índice no agrupado para el campo "apellido".


create nonclustered index I_alumnos_apellido
on alumnos(apellido);





-- 3- Establezca una restricción "primary" para el campo "legajo" y especifique que cree un índice 
-- "agrupado".

alter table alumnos
add constraint PK_alumnos_legajo
primary key clustered (legajo);

-- 4- Vea la información que muestra "sp_helpindex":
--   exec sp_helpindex alumnos;

exec sp_helpindex alumnos;






-- 5- Intente eliminar el índice "PK_alumnos_legajo" con "drop index":
--  drop index PK_alumnos_legajo;
-- No se puede.

drop index PK_alumnos_legajo;

-- 6- Intente eliminar el índice "I_alumnos_apellido" sin especificar el nombre de la tabla:
-- Mensaje de error.
 drop index I_alumnos_apellido;

-- 7- Elimine el índice "I_alumnos_apellido" especificando el nombre de la tabla.

drop index alumnos.I_alumnos_legajo;

-- 8- Verifique que se eliminó:

 exec sp_helpindex alumnos;

-- 9- Solicite que se elimine el índice "I_alumnos_apellido" si existe:

--  if exists (select name from sysindexes
--   where name = 'I_alumnos_apellido')
--    drop index alumnos.I_alumnos_apellido;


if exists (Select name from sysindexes
where name='I_alumnos_apellido')
drop index alumnos.I_alumnos_apellido;

-- 10- Elimine el índice "PK_alumnos_legajo" (quite la restricción).

alter table alumnos
drop PK_alumnos_legajo;
-- 11- Verifique que el índice "PK_alumnos_legajo" ya no existe:

 exec sp_helpindex alumnos;








-- ********************* Segundo problema *********************



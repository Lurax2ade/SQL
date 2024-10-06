
 -------------------------------------------------------------------------------------------------------------------------------
-- 	Regenerar índices
 -------------------------------------------------------------------------------------------------------------------------------


-- Vimos que para crear índices empleamos la instrucción "create index".

-- Empleando la opción "drop_existing" junto con "create index" permite regenerar un índice, 
--con ello evitamos eliminarlo y volver a crearlo. La sintaxis es la siguiente:

-- %  create TIPODEINDICE index NOMBREINDICE
-- %  on TABLA(CAMPO)
-- %  with drop_existing;

-- % También podemos modificar alguna de las características de un índice con esta opción, a saber:

-- % - tipo: cambiándolo de no agrupado a agrupado (siempre que no exista uno agrupado para la misma tabla). No se puede convertir un índice agrupado en No agrupado.

-- % - campo: se puede cambiar el campo por el cual se indexa, agregar campos, eliminar algún campo de un índice compuesto.

-- % - único: se puede modificar un índice para que los valores sean únicos o dejen de serlo.

-- % En este ejemplo se crea un índice no agrupado para el campo "titulo" de la tabla "libros":

-- %  create nonclustered index I_libros
-- %  on libros(titulo);

-- % Regeneramos el índice "I_libros" y lo convertimos a agrupado:

-- %  create clustered index I_libros
-- %  on libros(titulo)
-- %  with drop_existing;

-- % Agregamos un campo al índice "I_libros":

-- %  create clustered index I_libros
-- %  on libros(titulo,editorial)
-- %  with drop_existing;

-- % Esta opción no puede emplearse con índices creados a partir de una restricción "primary key" o "unique".



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

-- 3- Vea la información de los índices de "alumnos".

exec sp_helpindex alumnos;

-- 4- Modifíquelo agregando el campo "nombre".

create nonclustered index I_alumnos_apellido
on alumnos(apellido, nombre)
with drop_existing;

-- 5- Verifique que se modificó:


exec sp_helpindex alumnos;


-- 6- Establezca una restricción "unique" para el campo "documento".


alter table alumnos
add constraint UG_alumnos_documento
unique nonclustered (documento);


-- 7- Vea la información que muestra "sp_helpindex":

 exec sp_helpindex alumnos;

-- 8- Intente modificar con "drop_existing" alguna característica del índice que se creó 
-- automáticamente al agregar la restricción "unique":

create clustered index UQ_alumnos_documento
on alumnos(documento)
with drop_existing;

-- No se puede emplear "drop_existing" con índices creados a partir de una restricción.



-- 9- Cree un índice no agrupado para el campo "legajo".
create nonclustered index I_alumnos_legajo
on alumnos(legajo);

-- 10- Muestre todos los índices:
--  exec sp_helpindex alumnos;
 exec sp_helpindex alumnos;


-- 11- Convierta el índice creado en el punto 9 a agrupado conservando las demás características.

alter table alumnos
add constraint UQ_alumnos_documento
unique nonclustered (documento);


-- 12- Verifique que se modificó:
--  exec sp_helpindex alumnos;

 exec sp_helpindex alumnos;

-- 13- Intente convertir el índice "I_alumnos_legajo" a no agrupado:

-- No se puede convertir un índice agrupado en no agrupado.
create nonclustered index I_alumnos_legajo
on alumnos(legajo);
-- 14- Modifique el índice "I_alumnos_apellido" quitándole el campo "nombre".

 create nonclustered index I_alumnos_legajo
  on alumnos(legajo); 
-- 15- Intente convertir el índice "I_alumnos_apellido" en agrupado:
 create clustered index I_alumnos_apellido
  on alumnos(apellido)
  with drop_existing;
-- No lo permite porque ya existe un índice agrupado.

-- 16- Modifique el índice "I_alumnos_legajo" para que sea único y conserve todas las otras 
-- características.
create clustered index I_alumnos_legajo
  on alumnos(legajo)
  with drop_existing;
-- 17- Verifique la modificación:
 exec sp_helpindex alumnos;

-- 18- Modifique nuevamente el índice "I_alumnos_legajo" para que no sea único y conserve las demás 
-- características.
 create clustered index I_alumnos_legajo
  on alumnos(legajo)
  with drop_existing;

-- 19- Verifique la modificación:
 exec sp_helpindex alumnos;







-- ********************* Segundo problema *********************



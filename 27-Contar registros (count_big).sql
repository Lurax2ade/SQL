
 
 -------------------------------------------------------------------------------------------------------------------------------
--Contar registros (count_big)
 -------------------------------------------------------------------------------------------------------------------------------


-- Retorna la cantidad de registros. Es similar a la función "count(*)", la diferencia es que "count_big" retorna un valor "bigint" y "count", un "int".

-- "count_big(*)" cuenta la cantidad de registros de una tabla, incluyendo los valores nulos y duplicados.

-- "count_big(CAMPO)" retorna la cantidad de registros cuyo valor en el campo especificado entre paréntesis no es nulo.

-- "count_big(distinct CAMPO)" retorna la cantidad de registros cuyo valor en el campo especificado no es nulo, sin considerar los repetidos.

-- Averiguemos la cantidad de libros usando la función "count_big()":

--  select count_big(*)
--   from libros;

-- Note que incluye todos los libros aunque tengan valor nulo en algún campo.

-- Contamos los libros de editorial "Planeta":

--  select count_big(*)
--   from libros
--   where editorial='Planeta';

-- Contamos los registros que tienen precio (sin tener en cuenta los que tienen valor nulo):

--  select count_big(precio)
--   from libros;

-- Contamos las editoriales (sin repetir):

--  select count_big(distinct editorial)
--   from libros;


-- ********************* primer problema *********************

-- Trabaje con la tabla llamada "medicamentos" de una farmacia.

-- 1- Elimine la tabla, si existe:

 if object_id('medicamentos') is not null
  drop table medicamentos;

-- 2- Cree la tabla con la siguiente estructura:

 create table medicamentos(
  codigo int identity,
  nombre varchar(20),
  laboratorio varchar(20),
  precio decimal(6,2),
  cantidad tinyint,
  fechavencimiento datetime not null,
  numerolote int default null,
  primary key(codigo)
 );

-- 3- Ingrese algunos registros:

 insert into medicamentos
  values('Sertal','Roche',5.2,1,'2015-02-01',null);

 insert into medicamentos 
  values('Buscapina','Roche',4.10,3,'2016-03-01',null);

 insert into medicamentos 
  values('Amoxidal 500','Bayer',15.60,100,'2017-05-01',null);

 insert into medicamentos
  values('Paracetamol 500','Bago',1.90,20,'2018-02-01',null);

 insert into medicamentos 
  values('Bayaspirina',null,2.10,null,'2019-12-01',null); 

  insert into medicamentos 
  values('Amoxidal jarabe','Bayer',null,250,'2019-12-15',null); 


-- 4- Muestre la cantidad de registros empleando la función "count_big(*)" (6 registros)

select count_big(*) 
from medicamentos;

-- 5- Cuente la cantidad de laboratorios distintos (3 registros)

select count_big(distinct laboratorio)
from medicamentos;

-- 6- Cuente la cantidad de medicamentos que tienen precio y cantidad distinto de "null" (5 y 5)




 select count_big(precio) as 'Con precio',
  count_big(cantidad) as 'Con cantidad'
  from medicamentos;




-- ********************* Segundo problema *********************


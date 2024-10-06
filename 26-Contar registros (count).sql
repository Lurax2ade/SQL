
 
 -------------------------------------------------------------------------------------------------------------------------------
-- 	Contar registros (count)
 -------------------------------------------------------------------------------------------------------------------------------





-- Existen en SQL Server funciones que nos permiten contar registros, calcular sumas, promedios, obtener valores máximos y mínimos. Estas funciones se denominan funciones de agregado y operan sobre un conjunto de valores (registros), no con datos individuales y devuelven un único valor.

-- Imaginemos que nuestra tabla "libros" contiene muchos registros. Para averiguar la cantidad sin necesidad de contarlos manualmente usamos la función "count()":

--  select count(*)
--   from libros;

-- La función "count()" cuenta la cantidad de registros de una tabla, incluyendo los que tienen valor nulo.

-- También podemos utilizar esta función junto con la cláusula "where" para una consulta más específica. Queremos saber la cantidad de libros de la editorial "Planeta":

--  select count(*)
--   from libros
--   where editorial='Planeta';

-- Para contar los registros que tienen precio (sin tener en cuenta los que tienen valor nulo), usamos la función "count()" y en los paréntesis colocamos el nombre del campo que necesitamos contar:

--  select count(precio)
--   from libros;

-- Note que "count(*)" retorna la cantidad de registros de una tabla (incluyendo los que tienen valor "null") mientras que "count(precio)" retorna la cantidad de registros en los cuales el campo "precio" no es nulo. No es lo mismo. "count(*)" cuenta registros, si en lugar de un asterisco colocamos como argumento el nombre de un campo, se contabilizan los registros cuyo valor en ese campo NO es nulo.








-- ********************* primer problema *********************


-- Trabaje con la tabla llamada "medicamentos" de una farmacia.

-- 1- Elimine la tabla, si existe:

if object_if('medicamento') is not null
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


-- 4- Muestre la cantidad de registros empleando la función "count(*)" (6 registros)

select count(*) from medicamentos;

-- 5- Cuente la cantidad de medicamentos que tienen laboratorio conocido (5 registros)

select count(laboratorio)
from medicamentos;

-- 6- Cuente la cantidad de medicamentos que tienen precio distinto a "null" y que tienen cantidad 
-- distinto a "null", disponer alias para las columnas.

 select count(precio) as 'Con precio',
  count(cantidad) as 'Con cantidad'
  from medicamentos;

-- 7- Cuente la cantidad de remedios con precio conocido, cuyo laboratorio comience con "B" (2 
-- registros)

select count(precio) 
from medicamentos

where laboratorio like 'B%';

-- 8- Cuente la cantidad de medicamentos con número de lote distitno de "null" (0 registros)



 select count(numerolote) from medicamentos;


-- ********************* Segundo problema *********************

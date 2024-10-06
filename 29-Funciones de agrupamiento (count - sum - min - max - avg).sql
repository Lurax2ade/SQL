
 -------------------------------------------------------------------------------------------------------------------------------
-- 	Funciones de agrupamiento (count - sum - min - max - avg) 
 -------------------------------------------------------------------------------------------------------------------------------



-- Hemos visto que SQL Server tiene funciones que nos permiten contar registros, calcular sumas, promedios, obtener valores máximos y mínimos, las funciones de agregado.

-- Ya hemos aprendido una de ellas, "count()", veamos otras.

-- Se pueden usar en una instrucción "select" y combinarlas con la cláusula "group by".

-- Todas estas funciones retornan "null" si ningún registro cumple con la condición del "where", excepto "count" que en tal caso retorna cero.

-- El tipo de dato del campo determina las funciones que se pueden emplear con ellas.

-- Las relaciones entre las funciones de agrupamiento y los tipos de datos es la siguiente:

-- - count: se puede emplear con cualquier tipo de dato.

-- - min y max: con cualquier tipo de dato.

-- - sum y avg: sólo en campos de tipo numérico.

-- La función "sum()" retorna la suma de los valores que contiene el campo especificado. Si queremos saber la cantidad total de libros que tenemos disponibles para la venta, debemos sumar todos los valores del campo "cantidad":

--  select sum(cantidad)
--   from libros;

-- Para averiguar el valor máximo o mínimo de un campo usamos las funciones "max()" y "min()" respectivamente.
-- Queremos saber cuál es el mayor precio de todos los libros:

--  select max(precio)
--   from libros;

-- Entonces, dentro del paréntesis de la función colocamos el nombre del campo del cuál queremos el máximo valor.

-- La función "avg()" retorna el valor promedio de los valores del campo especificado. Queremos saber el promedio del precio de los libros referentes a "PHP":

--  select avg(precio)
--   from libros
--   where titulo like '%PHP%';

-- Ahora podemos entender porque estas funciones se denominan "funciones de agrupamiento", porque operan sobre conjuntos de registros, no con datos individuales.

-- Tratamiento de los valores nulos:

-- Si realiza una consulta con la función "count" de un campo que contiene 18 registros, 2 de los cuales contienen valor nulo, el resultado devuelve un total de 16 filas porque no considera aquellos con valor nulo.

-- Todas las funciones de agregado, excepto "count(*)", excluye los valores nulos de los campos. "count(*)" cuenta todos los registros, incluidos los que contienen "null".




-- ********************* primer problema *********************




-- Una empresa almacena los datos de sus empleados en una tabla "empleados".

-- 1- Elimine la tabla, si existe:
if object_id('empleados') is  not null
drop table empleados;



-- 2- Cree la tabla:

 create table empleados(
  nombre varchar(30),
  documento char(8),
  domicilio varchar(30),
  seccion varchar(20),
  sueldo decimal(6,2),
  cantidadhijos tinyint,
  primary key(documento)
 );

-- 3- Ingrese algunos registros:

insert into empleados
values('Laura', '74589612', 'Oaxaca23', 'Gerencia', 2000, 1);

 insert into empleados
  values('Juan Perez','22333444','Colon 123','Gerencia',5000,2);

 insert into empleados
  values('Ana Acosta','23444555','Caseros 987','Secretaria',2000,0);

 insert into empleados
  values('Lucas Duarte','25666777','Sucre 235','Sistemas',4000,1);

 insert into empleados
  values('Pamela Gonzalez','26777888','Sarmiento 873','Secretaria',2200,3);

 insert into empleados
  values('Marcos Juarez','30000111','Rivadavia 801','Contaduria',3000,0);

 insert into empleados
  values('Yolanda Perez','35111222','Colon 180','Administracion',3200,1);

 insert into empleados
  values('Rodolfo Perez','35555888','Coronel Olmedo 588','Sistemas',4000,3);

 insert into empleados
  values('Martina Rodriguez','30141414','Sarmiento 1234','Administracion',3800,4);

 insert into empleados
  values('Andres Costa','28444555',default,'Secretaria',null,null);

-- 4- Muestre la cantidad de empleados usando "count" (9 empleados)

select count(*)
from empleados;

-- 5- Muestre la cantidad de empleados con sueldo no nulo de la sección "Secretaria" (2 empleados)

select count(sueldo)
from empleados
where seccion='Secretaria';

-- 6- Muestre el sueldo más alto y el más bajo colocando un alias (5000 y 2000)

select max(sueldo) as 'Mayor sueldo', 
min(sueldo) as 'Menor sueldo'
from empleados;

-- 7- Muestre el valor mayor de "cantidadhijos" de los empleados "Perez" (3 hijos)	

select max(cantidadhijos)
from empleados
where nombre like '%Perez%';

-- 8- Muestre el promedio de sueldos de todo los empleados (3400. Note que hay un sueldo nulo y no es 
-- tenido en cuenta)

select avg(sueldo)
from empleados;

-- 9- Muestre el promedio de sueldos de los empleados de la sección "Secretaría" (2100)


select avg(sueldo)
from empleados
where seccion='Secretaria';

-- 10- Muestre el promedio de hijos de todos los empleados de "Sistemas" (2)

select avg(cantidadhijos)
from empleados
where seccion='Sistemas';




-- ********************* Segundo problema *********************

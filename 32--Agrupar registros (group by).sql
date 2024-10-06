
 
 -------------------------------------------------------------------------------------------------------------------------------
--Agrupar registros (group by)
 -------------------------------------------------------------------------------------------------------------------------------


-- Ver video

-- Hemos aprendido que las funciones de agregado permiten realizar varios cálculos operando con conjuntos de registros.

-- Las funciones de agregado solas producen un valor de resumen para todos los registros de un campo. Podemos generar valores de resumen para un solo campo, combinando las funciones de agregado con la cláusula "group by", que agrupa registros para consultas detalladas.

-- Queremos saber la cantidad de libros de cada editorial, podemos tipear la siguiente sentencia:

--  select count(*) from libros
--   where editorial='Planeta';

-- y repetirla con cada valor de "editorial":

--  select count(*) from libros
--   where editorial='Emece';
--  select count(*) from libros
--   where editorial='Paidos';
--  ...

-- Pero hay otra manera, utilizando la cláusula "group by":

--  select editorial, count(*)
--   from libros
--   group by editorial;

-- La instrucción anterior solicita que muestre el nombre de la editorial y cuente la cantidad agrupando los registros por el campo "editorial". Como resultado aparecen los nombres de las editoriales y la cantidad de registros para cada valor del campo.

-- Los valores nulos se procesan como otro grupo.

-- Entonces, para saber la cantidad de libros que tenemos de cada editorial, utilizamos la función "count()", agregamos "group by" (que agrupa registros) y el campo por el que deseamos que se realice el agrupamiento, también colocamos el nombre del campo a recuperar; la sintaxis básica es la siguiente:

--  select CAMPO, FUNCIONDEAGREGADO
--   from NOMBRETABLA
--   group by CAMPO;

-- También se puede agrupar por más de un campo, en tal caso, luego del "group by" se listan los campos, separados por comas. Todos los campos que se especifican en la cláusula "group by" deben estar en la lista de selección.

--  select CAMPO1, CAMPO2, FUNCIONDEAGREGADO
--   from NOMBRETABLA
--   group by CAMPO1,CAMPO2;

-- Para obtener la cantidad libros con precio no nulo, de cada editorial utilizamos la función "count()" enviándole como argumento el campo "precio", agregamos "group by" y el campo por el que deseamos que se realice el agrupamiento (editorial):

--  select editorial, count(precio)
--   from libros
--   group by editorial;

-- Como resultado aparecen los nombres de las editoriales y la cantidad de registros de cada una, sin contar los que tienen precio nulo.

-- Recuerde la diferencia de los valores que retorna la función "count()" cuando enviamos como argumento un asterisco o el nombre de un campo: en el primer caso cuenta todos los registros incluyendo los que tienen valor nulo, en el segundo, los registros en los cuales el campo especificado es no nulo.

-- Para conocer el total en dinero de los libros agrupados por editorial:

--  select editorial, sum(precio)
--   from libros
--   group by editorial;

-- Para saber el máximo y mínimo valor de los libros agrupados por editorial:

--  select editorial,
--   max(precio) as mayor,
--   min(precio) as menor
--   from libros
--   group by editorial;

-- Para calcular el promedio del valor de los libros agrupados por editorial:

--  select editorial, avg(precio)
--   from libros
--   group by editorial;

-- Es posible limitar la consulta con "where".

-- Si incluye una cláusula "where", sólo se agrupan los registros que cumplen las condiciones.

-- Vamos a contar y agrupar por editorial considerando solamente los libros cuyo precio sea menor a 30 pesos:

--  select editorial, count(*)
--   from libros
--   where precio<30
--   group by editorial;

-- Note que las editoriales que no tienen libros que cumplan la condición, no aparecen en la salida. Para que aparezcan todos los valores de editorial, incluso los que devuelven cero o "null" en la columna de agregado, debemos emplear la palabra clave "all" al lado de "group by":

--  select editorial, count(*)
--   from libros
--   where precio<30
--   group by all editorial;

-- Entonces, usamos "group by" para organizar registros en grupos y obtener un resumen de dichos grupos. SQL Server produce una columna de valores por cada grupo, devolviendo filas por cada grupo especificado.





-- ********************* primer problema *********************


-- Una empresa almacena los datos de sus empleados en una tabla "empleados".
-- 1- Elimine la tabla, si existe:
if object_id('empleados') is not null
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
values ('Lucia', '784596123', 'Pierre', 'Gerencia',1200, 2);

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
from empledos;

-- 7- Muestre el valor mayor de "cantidadhijos" de los empleados "Perez" (3 hijos)	

select max(cantidadhijos)
from empleados
where nombre like '%Perez%';

-- 8- Muestre el promedio de sueldos de todo los empleados (3400. Note que hay un sueldo nulo y no es 
-- tenido en cuenta)

select avg(sueldo) as promedio
from empleados;

-- 9- Muestre el promedio de sueldos de los empleados de la sección "Secretaría" (2100)

select avg(sueldo) as promedio
from empleados
where seccion='Secretaria';

-- 10- Muestre el promedio de hijos de todos los empleados de "Sistemas" (2)


 select avg(cantidadhijos)
  from empleados
  where seccion='Sistemas';



-- ********************* Segundo problema *********************


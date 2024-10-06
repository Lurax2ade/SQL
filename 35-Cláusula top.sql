
 -------------------------------------------------------------------------------------------------------------------------------
-- 	Cláusula top
 -------------------------------------------------------------------------------------------------------------------------------





-- La palabra clave "top" se emplea para obtener sólo una cantidad limitada de registros, los primeros n registros de una consulta.

-- Con la siguiente consulta obtenemos todos los datos de los primeros 2 libros de la tabla:

--  select top 2 * from libros;

-- Es decir, luego del "select" se coloca "top" seguido de un número entero positivo y luego se continúa con la consulta.

-- Se puede combinar con "order by":

--  select top 3 titulo,autor 
--   from libros
--   order by autor;

-- En la consulta anterior solicitamos los títulos y autores de los 3 primeros libros, ordenados por autor.

-- Cuando se combina con "order by" es posible emplear también la cláusula "with ties". Esta cláusula permite incluir en la selección, todos los registros que tengan el mismo valor del campo por el que se ordena en la última posición. Es decir, si el valor del campo por el cual se ordena el último registro retornado (el número n) está repetido en los siguientes registros (es decir, el n+1 tiene el mismo valor que n, y el n+2, etc.), lo incluye en la selección.

-- Veamos un ejemplo:

--  select top 3 with ties
--   * from libros
--   order by autor;

-- Esta consulta solicita el retorno de los primeros 3 registros; en caso que el registro número 4 (y los posteriores), tengan el mismo valor en "autor" que el último registro retornado (número 3), también aparecerán en la selección.

-- Otro argumento posible cuando utilizamos la cláusula 'top' es 'percent' indicando el porcentaje de registros a recuperar y no la cantidad, por ejemplo:

--  select top 50 percent
--   * from libros
--   order by autor;

-- Se recuperan la mitad de registros de la tabla 'libros'.

-- Los valores fraccionarios se redondean al siguiente valor entero.

-- Si colocamos un valor para "top" que supera la cantidad de registros de la tabla, SQL Server muestra todos los registros.



-- ********************* primer problema *********************


-- Una empresa tiene registrados sus empleados en una tabla llamada "empleados".
-- 1- Elimine la tabla si existe:

 if object_id('empleados') is not null
  drop table empleados;

-- 2- Créela con la siguiente estructura:
 create table empleados (
  documento varchar(8) not null,
  nombre varchar(30),
  estadocivil char(1),--c=casado, s=soltero,v=viudo
  seccion varchar(20)
 );

-- 3- Ingrese algunos registros:
 insert into empleados
  values ('22222222','Alberto Lopez','c','Sistemas');
 insert into empleados
  values ('23333333','Beatriz Garcia','c','Administracion');
 insert into empleados
  values ('24444444','Carlos Fuentes','s','Administracion');
 insert into empleados
  values ('25555555','Daniel Garcia','s','Sistemas');
 insert into empleados
  values ('26666666','Ester Juarez','c','Sistemas');
 insert into empleados
  values ('27777777','Fabian Torres','s','Sistemas');
 insert into empleados
  values ('28888888','Gabriela Lopez',null,'Sistemas');
 insert into empleados
  values ('29999999','Hector Garcia',null,'Administracion');

-- 4- Muestre los 5 primeros registros (5 registros)


select top 5 * from empleados;

-- 5- Muestre nombre y seccion de los 4 primeros registros ordenados por sección (4 registros)

select top 4 with ties nombre, seccion
from empleados
order by seccion;

-- 6- Realice la misma consulta anterior pero incluya todos los registros que tengan el mismo valor en 
-- "seccion" que el último (8 registros)

select top 4 with ties nombre, seccion
from empleados
order by seccion;

-- 7- Muestre nombre, estado civil y seccion de los primeros 4 empleados ordenados por estado civil y 
-- sección (4 registros)

select top 4 nombre, seccion, estadocivil
from empleados
order by estadocivil, seccion;

-- 8- Realice la misma consulta anterior pero incluya todos los valores iguales al último registro 
-- retornado (5 registros)




 select top 4 with ties nombre,estadocivil,seccion
  from empleados
  order by estadocivil,seccion;




-- ********************* Segundo problema *********************



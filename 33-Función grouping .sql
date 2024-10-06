
 -------------------------------------------------------------------------------------------------------------------------------
--Función grouping 
 -------------------------------------------------------------------------------------------------------------------------------


-- La función "grouping" se emplea con los operadores "rollup" y "cube" para distinguir los valores de detalle y de resumen en el resultado. Es decir, permite diferenciar si los valores "null" que aparecen en el resultado son valores nulos de las tablas o si son una fila generada por los operadores "rollup" o "cube".

-- Con esta función aparece una nueva columna en la salida, una por cada "grouping"; retorna el valor 1 para indicar que la fila representa los valores de resumen de "rollup" o "cube" y el valor 0 para representar los valores de campo.

-- Sólo se puede emplear la función "grouping" en los campos que aparecen en la cláusula "group by".

-- Si tenemos una tabla "visitantes" con los siguientes registros almacenados:

-- Nombre		sexo	ciudad
-- -------------------------------
-- Susana Molina	f	Cordoba
-- Marcela Mercado	f	Cordoba
-- Roberto Perez	f	null
-- Alberto Garcia	m	Cordoba
-- Teresa Garcia	f	Alta Gracia

-- y contamos la cantidad agrupando por ciudad (note que hay un valor nulo en dicho campo) empleando "rollup":

--  select ciudad,
--   count(*) as cantidad
--   from visitantes
--   group by ciudad
--   with rollup;

-- aparece la siguiente salida:

-- ciudad		cantidad
-- -------------------------
-- NULL		1
-- Alta Gracia	1
-- Cordoba		3
-- NULL		5

-- La última fila es la de resumen generada por "rollup", pero no es posible distinguirla de la primera fila, en la cual "null" es un valor del campo. Para diferenciarla empleamos "grouping":

--  select ciudad,
--   count(*) as cantidad,
--   grouping(ciudad) as resumen
--   from visitantes
--   group by ciudad
--   with rollup;

-- aparece la siguiente salida:

-- ciudad		cantidad	resumen
-- ---------------------------------------
-- NULL		1		0
-- Alta Gracia	1		0
-- Cordoba		3		0
-- NULL		5		1

-- La última fila contiene en la columna generada por "grouping" el valor 1, indicando que es la fila de resumen generada por "rollup"; la primera fila, contiene en dicha columna el valor 0, que indica que el valor "null" es un valor del campo "ciudad".

-- Entonces, si emplea los operadores "rollup" y "cube" y los campos por los cuales agrupa admiten valores nulos, utilice la función "grouping" para distinguir los valores de detalle y de resumen en el resultado.




-- ********************* primer problema *********************



-- Una empresa tiene registrados sus empleados en una tabla llamada "empleados".
-- 1- Elimine la tabla si existe:

if object_id('empleados') is not null
drop table empleados;



-- 2- Créela con la siguiente estructura:

 create table empleados (
  documento varchar(8) not null,
  nombre varchar(30),
  sexo char(1),
  estadocivil char(1),--c=casado, s=soltero,v=viudo
  seccion varchar(20),
  primary key (documento)
 );

-- 3- Ingrese algunos registros:
insert into empleados
values('47856912', 'Laura', 'f', 'c', 'técnico');

 insert into empleados
  values ('22222222','Alberto Lopez','m','c','Sistemas');

 insert into empleados
  values ('23333333','Beatriz Garcia','f','c','Administracion');

 insert into empleados
  values ('24444444','Carlos Fuentes','m','s','Administracion');

 insert into empleados
  values ('25555555','Daniel Garcia','m','s','Sistemas');

 insert into empleados
  values ('26666666','Ester Juarez',null,'c','Sistemas');

 insert into empleados
  values ('27777777','Fabian Torres',null,'s','Sistemas');

 insert into empleados
  values ('28888888','Gabriela Lopez','f',null,'Sistemas');

 insert into empleados
  values ('29999999','Hector Garcia','m',null,'Administracion');

-- 4- Cuente la cantidad de empleados agrupados por sexo y estado civil, empleando "rollup".
-- Es dificil distinguir los valores de detalle y resumen.

select sexo, estadocivil, 
count(*) as cantidad
from empleados
group by sexo, estadocivil with rollup;

-- 5- Realice la misma consulta anterior pero emplee la función "grouping" para los dos campos por los 
-- que se agrupa para distinguir los valores de resumen y de detalle.
-- Note que las columnas de resumen contienen 1 y las de detalle 0.

select sexo, estadocivil, 
count(*) as cantidad,
CASE WHEN sexo IS NULL THEN 1 ELSE 0 END as 'resumen sexo',
CASE WHEN estadocivil IS NULL THEN 1 ELSE 0 END as 'resumen estado civil'
from empleados
group by sexo, estadocivil with rollup;

-- 6- Realice la misma consulta anterior pero con "cube" en lugar de "rollup", distinguiendo los 
-- valores de resumen y de detalle.
-- Note que las columnas de resumen contienen 1 y las de detalle 0.


select sexo, estadocivil, 
count(*) as cantidad,
CASE WHEN sexo IS NULL THEN 1 ELSE 0 END as 'resumen sexo',
CASE WHEN estadocivil IS NULL THEN 1 ELSE 0 END as 'resumen estado civil'
from empleados
group by sexo, estadocivil with cube;
 

 





-- ********************* Segundo problema *********************


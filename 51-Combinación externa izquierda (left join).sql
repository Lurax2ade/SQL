
 -------------------------------------------------------------------------------------------------------------------------------
--	Combinación externa izquierda (left join)
 -------------------------------------------------------------------------------------------------------------------------------



 
-- Vimos que una combinación interna (join) encuentra registros de la primera tabla que se correspondan con los registros de la segunda, es decir, que cumplan la condición del "on" y si un valor de la primera tabla no se encuentra en la segunda tabla, el registro no aparece.

-- Si queremos saber qué registros de una tabla NO encuentran correspondencia en la otra, es decir, no existe valor coincidente en la segunda, necesitamos otro tipo de combinación, "outer join" (combinación externa).

-- Las combinaciones externas combinan registros de dos tablas que cumplen la condición, más los registros de la segunda tabla que no la cumplen; es decir, muestran todos los registros de las tablas relacionadas, aún cuando no haya valores coincidentes entre ellas.

-- Este tipo de combinación se emplea cuando se necesita una lista completa de los datos de una de las tablas y la información que cumple con la condición. Las combinaciones externas se realizan solamente entre 2 tablas.

-- Hay tres tipos de combinaciones externas: "left outer join", "right outer join" y "full outer join"; se pueden abreviar con "left join", "right join" y "full join" respectivamente.

-- Vamos a estudiar las primeras.

-- Se emplea una combinación externa izquierda para mostrar todos los registros de la tabla de la izquierda. Si no encuentra coincidencia con la tabla de la derecha, el registro muestra los campos de la segunda tabla seteados a "null".

-- En el siguiente ejemplo solicitamos el título y nombre de la editorial de los libros:

--   select titulo,nombre
--   from editoriales as e
--   left join libros as l
--   on codigoeditorial = e.codigo;

-- El resultado mostrará el título y nombre de la editorial; las editoriales de las cuales no hay libros, es decir, cuyo código de editorial no está presente en "libros" aparece en el resultado, pero con el valor "null" en el campo "titulo".

-- Es importante la posición en que se colocan las tablas en un "left join", la tabla de la izquierda es la que se usa para localizar registros en la tabla de la derecha.

-- Entonces, un "left join" se usa para hacer coincidir registros en una tabla (izquierda) con otra tabla (derecha); si un valor de la tabla de la izquierda no encuentra coincidencia en la tabla de la derecha, se genera una fila extra (una por cada valor no encontrado) con todos los campos correspondientes a la tabla derecha seteados a "null". La sintaxis básica es la siguiente:

--   select CAMPOS
--   from TABLAIZQUIERDA
--   left join TABLADERECHA
--   on CONDICION;

-- En el siguiente ejemplo solicitamos el título y el nombre la editorial, la sentencia es similar a la anterior, la diferencia está en el orden de las tablas:

--   select titulo,nombre
--   from libros as l
--   left join editoriales as e
--   on codigoeditorial = e.codigo;

-- El resultado mostrará el título del libro y el nombre de la editorial; los títulos cuyo código de editorial no está presente en "editoriales" aparecen en el resultado, pero con el valor "null" en el campo "nombre".

-- Un "left join" puede tener clausula "where" que restringa el resultado de la consulta considerando solamente los registros que encuentran coincidencia en la tabla de la derecha, es decir, cuyo valor de código está presente en "libros":

--  select titulo,nombre
--   from editoriales as e
--   left join libros as l
--   on e.codigo=codigoeditorial
--   where codigoeditorial is not null;

-- También podemos mostrar las editoriales que NO están presentes en "libros", es decir, que NO encuentran coincidencia en la tabla de la derecha:

--  select titulo,nombre
--   from editoriales as e
--   left join libros as l
--   on e.codigo=codigoeditorial
--   where codigoeditorial is null;


-- ********************* primer problema *********************

-- Una empresa tiene registrados sus clientes en una tabla llamada "clientes", también tiene una tabla 
-- "provincias" donde registra los nombres de las provincias.

-- 1- Elimine las tablas "clientes" y "provincias", si existen y cree las tablas:

if object_id('clientes') is not null
drop table clientes;

if object_id('provincias') is not null
drop table provincias;



 create table clientes (
  codigo int identity,
  nombre varchar(30),
  domicilio varchar(30),
  ciudad varchar(20),
  codigoprovincia tinyint not null,
  primary key(codigo)
 );

 create table provincias(
  codigo tinyint identity,
  nombre varchar(20),
  primary key (codigo)
 );

-- 2- Ingrese algunos registros para ambas tablas:

 insert into provincias (nombre) values('Cordoba');
 insert into provincias (nombre) values('Santa Fe');
 insert into provincias (nombre) values('Corrientes');

 insert into clientes values ('Lopez Marcos','Colon 111','Córdoba',1);
 insert into clientes values ('Perez Ana','San Martin 222','Cruz del Eje',1);
 insert into clientes values ('Garcia Juan','Rivadavia 333','Villa Maria',1);
 insert into clientes values ('Perez Luis','Sarmiento 444','Rosario',2);
 insert into clientes values ('Gomez Ines','San Martin 666','Santa Fe',2);
 insert into clientes values ('Torres Fabiola','Alem 777','La Plata',4);
 insert into clientes values ('Garcia Luis','Sucre 475','Santa Rosa',5);

-- 3- Muestre todos los datos de los clientes, incluido el nombre de la provincia:

 select c.nombre,domicilio,ciudad, p.nombre
  from clientes as c
  left join provincias as p
  on codigoprovincia = p.codigo;


-- 4- Realice la misma consulta anterior pero alterando el orden de las tablas:

select c.nombre, domicilio, ciudad, p.nombre
from provincias as p
left join clientes as c
on codigoprovincia=p.codigo;



-- 5- Muestre solamente los clientes de las provincias que existen en "provincias" (5 registros):

select c.nombre,domicilio,ciudad, p.nombre
from clientes as c
left join provincias as p
on codigoprovincia=p.codigo
where p.codigo is not null;


-- 6- Muestre todos los clientes cuyo código de provincia NO existe en "provincias" ordenados por 
-- nombre del cliente (2 registros):

select c.nombre, domicilio, ciudad, p.nombre
from clientes as c
left join provincias as p
on codigoprovincia=p.codigo
where p.codigo is null
order by c.nombre;



-- 7- Obtenga todos los datos de los clientes de "Cordoba" (3 registros):

select c.nombre, domicilio, ciudad, p.nombre
from clientes as c
left join provincias as p
on codigoprovincia=p.codigo
where p.nombre='Cordoba';




-- ********************* segundo problema ***
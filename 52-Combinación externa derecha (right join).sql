
 -------------------------------------------------------------------------------------------------------------------------------
--	Combinación externa derecha (right join)
 -------------------------------------------------------------------------------------------------------------------------------



-- Vimos que una combinación externa izquierda (left join) encuentra registros de la tabla izquierda que se correspondan con los registros de la tabla derecha y si un valor de la tabla izquierda no se encuentra en la tabla derecha, el registro muestra los campos correspondientes a la tabla de la derecha seteados a "null".

-- Una combinación externa derecha ("right outer join" o "right join") opera del mismo modo sólo que la tabla derecha es la que localiza los registros en la tabla izquierda.

-- En el siguiente ejemplo solicitamos el título y nombre de la editorial de los libros empleando un "right join":

--   select titulo,nombre
--   from libros as l
--   right join editoriales as e
--   on codigoeditorial = e.codigo;

-- El resultado mostrará el título y nombre de la editorial; las editoriales de las cuales no hay libros, es decir, cuyo código de editorial no está presente en "libros" aparece en el resultado, pero con el valor "null" en el campo "titulo".

-- Es FUNDAMENTAL tener en cuenta la posición en que se colocan las tablas en los "outer join". En un "left join" la primera tabla (izquierda) es la que busca coincidencias en la segunda tabla (derecha); en el "right join" la segunda tabla (derecha) es la que busca coincidencias en la primera tabla (izquierda).

-- En la siguiente consulta empleamos un "left join" para conseguir el mismo resultado que el "right join" anterior:

--  select titulo,nombre
--   from editoriales as e
--   left join libros as l
--   on codigoeditorial = e.codigo;

-- Note que la tabla que busca coincidencias ("editoriales") está en primer lugar porque es un "left join"; en el "right join" precedente, estaba en segundo lugar.

-- Un "right join" hace coincidir registros en una tabla (derecha) con otra tabla (izquierda); si un valor de la tabla de la derecha no encuentra coincidencia en la tabla izquierda, se genera una fila extra (una por cada valor no encontrado) con todos los campos correspondientes a la tabla izquierda seteados a "null". La sintaxis básica es la siguiente:

--   select CAMPOS
--   from TABLAIZQUIERDA
--   right join TABLADERECHA
--   on CONDICION;

-- Un "right join" también puede tener cláusula "where" que restringa el resultado de la consulta considerando solamente los registros que encuentran coincidencia en la tabla izquierda:

--  select titulo,nombre
--   from libros as l
--   right join editoriales as e
--   on e.codigo=codigoeditorial
--   where codigoeditorial is not null;

-- Mostramos las editoriales que NO están presentes en "libros", es decir, que NO encuentran coincidencia en la tabla de la derecha empleando un "right join":

--  select titulo,nombre
--   from libros as l
--   right join editoriales as e
--   on e.codigo=codigoeditorial
--   where codigoeditorial is null;


-- ********************* primer problema *********************

-- Una empresa tiene registrados sus clientes en una tabla llamada "clientes", también tiene una 
-- tabla "provincias" donde registra los nombres de las provincias.
-- 1- Elimine las tablas "clientes" y "provincias", si existen y cree las tablas:

  if (object_id('clientes')) is not null
   drop table clientes;
  if (object_id('provincias')) is not null
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

-- 3- Muestre todos los datos de los clientes, incluido el nombre de la provincia empleando un "right 
-- join".

select c.nombre, domicilio, ciudad, p.nombre
from provincias as p
right join clientes as c
on codigoprovincia=p.codigo;



-- 4- Obtenga la misma salida que la consulta anterior pero empleando un "left join".

select c.nombre, domicilio, ciudad, p.nombre
from clientes as c
left join provincias as p
on codigoprovincia=p.codigo;


-- 5- Empleando un "right join", muestre solamente los clientes de las provincias que existen en 
-- "provincias" (5 registros)

select c.nombre, domicilio, ciudad, p.nombre
from provincias as p
right join clientes as c
on codigoprovincia=p.codigo
where p.codigo is not null;


-- 6- Muestre todos los clientes cuyo código de provincia NO existe en "provincias" ordenados por 
-- ciudad (2 registros)



select c.nombre, domicilio, ciudad, p.nombre
from provincias as p
right join clientes as c
on codigoprovincia=p.codigo
where p.codigo is  null
order by ciudad;





-- ********************* segundo problema *********************


--  -------------------------------------------------------------------------------------------------------------------------------
-- -- 	Combinaciones y funciones de agrupamiento	
--  -------------------------------------------------------------------------------------------------------------------------------


-- -- Podemos usar "group by" y las funciones de agrupamiento con combinaciones de tablas.

-- -- Para ver la cantidad de libros de cada editorial consultando la tabla "libros" y "editoriales", tipeamos:

-- --  select nombre as editorial,
-- --   count(*) as cantidad
-- --   from editoriales as e
-- --   join libros as l
-- --   on codigoeditorial=e.codigo
-- --   group by e.nombre;

-- -- Note que las editoriales que no tienen libros no aparecen en la salida porque empleamos un "join".

-- -- Empleamos otra función de agrupamiento con "left join". Para conocer el mayor precio de los libros de cada editorial usamos la función "max()", hacemos un "left join" y agrupamos por nombre de la editorial:

-- --  select nombre as editorial,
-- --   max(precio) as 'mayor precio'
-- --   from editoriales as e
-- --   left join libros as l
-- --   on codigoeditorial=e.codigo
-- --   group by nombre;

-- -- En la sentencia anterior, mostrará, para la editorial de la cual no haya libros, el valor "null" en la columna calculada.


-- -- ********************* primer problema *********************




-- -- Un comercio que tiene un stand en una feria registra en una tabla llamada "visitantes" algunos datos 
-- -- de las personas que visitan o compran en su stand para luego enviarle publicidad de sus productos y 
-- -- en otra tabla llamada "ciudades" los nombres de las ciudades.
-- -- 1- Elimine las tablas si existen:

--  if object_id('visitantes') is not null
--   drop table visitantes;
--  if object_id('ciudades') is not null
--   drop table ciudades;

-- -- 2- Cree las tablas:
--  create table visitantes(
--   nombre varchar(30),
--   edad tinyint,
--   sexo char(1) default 'f',
--   domicilio varchar(30),
--   codigociudad tinyint not null,
--   mail varchar(30),
--   montocompra decimal (6,2)
--  );

--  create table ciudades(
--   codigo tinyint identity,
--   nombre varchar(20)
--  );
 
-- 3- Ingrese algunos registros:
--  insert into ciudades values('Cordoba');
--  insert into ciudades values('Carlos Paz');
--  insert into ciudades values('La Falda');
--  insert into ciudades values('Cruz del Eje');

--  insert into visitantes values 
--    ('Susana Molina', 35,'f','Colon 123', 1, null,59.80);
--  insert into visitantes values 
--    ('Marcos Torres', 29,'m','Sucre 56', 1, 'marcostorres@hotmail.com',150.50);
--  insert into visitantes values 
--    ('Mariana Juarez', 45,'f','San Martin 111',2,null,23.90);
--  insert into visitantes values 
--    ('Fabian Perez',36,'m','Avellaneda 213',3,'fabianperez@xaxamail.com',0);
--  insert into visitantes values 
--    ('Alejandra Garcia',28,'f',null,2,null,280.50);
--  insert into visitantes values 
--    ('Gaston Perez',29,'m',null,5,'gastonperez1@gmail.com',95.40);
--  insert into visitantes values 
--    ('Mariana Juarez',33,'f',null,2,null,90);

-- -- 4- Cuente la cantidad de visitas por ciudad mostrando el nombre de la ciudad (3 filas)
-- select c.nombre
-- count(*) as cantidad
-- from ciudades as c
-- join visitantes as v
-- on codigociudad=c.codigo
-- group by c.nombre;

-- -- 5- Muestre el promedio de gastos de las visitas agrupados por ciudad y sexo (4 filas)
-- select c.nombre, sexo, 
-- avg(montocompra) as 'promeido de compra'
-- from ciudades as c
-- join visitantes as v
-- on codigociudad=c.codigo
-- group by c.nombre, sexo;

-- -- 6- Muestre la cantidad de visitantes con mail, agrupados por ciudad (3 filas)

-- select c.nombre, 
-- count(mail) as 'tienen mail'
--   from ciudades as c
--   join visitantes as v
--   on codigociudad=c.codigo
--   group by c.nombre;

-- -- 7- Obtenga el monto de compra más alto de cada ciudad (3 filas)

-- select c.nombre,
-- max(montocompra)
--   from visitantes as v
--   join ciudades as c
--   on codigociudad=c.codigo
--   group by c.nombre;







-- -- ********************* Segundo problema *********************



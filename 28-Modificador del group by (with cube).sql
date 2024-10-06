 
 -------------------------------------------------------------------------------------------------------------------------------
--Modificador del group by (with cube) 
 -------------------------------------------------------------------------------------------------------------------------------

-- Hemos aprendido el modificador "rollup", que agrega filas extras mostrando resultados de resumen por cada grupo y subgrupo.

-- Por ejemplo, tenemos una tabla llamada "empleados" que contiene, entre otros, los campos "sexo", "estadocivil" y "seccion".

-- Si se agrupa por esos tres campos (en ese orden) y se emplea "rollup":

--  select sexo,estadocivil,seccion,
--   count(*) from empleados
--   group by sexo,estadocivil,seccion
--   with rollup;

-- SQL Server genera varias filas extras con información de resumen para los siguientes subgrupos:

-- - sexo y estadocivil (seccion seteado a "null"),
-- - sexo (estadocivil y seccion seteados a "null") y
-- - total (todos los campos seteados a "null").

-- Si se emplea "cube":

--  select sexo,estadocivil,seccion,
--   count(*) from empleados
--   group by sexo,estadocivil,seccion
--   with cube;

-- retorna más filas extras además de las anteriores:

-- - sexo y seccion (estadocivil seteado a "null"),
-- - estadocivil y seccion (sexo seteado a "null"),
-- - seccion (sexo y estadocivil seteados a "null") y
-- - estadocivil (sexo y seccion seteados a "null"),

-- Es decir, "cube" genera filas de resumen de subgrupos para todas las combinaciones posibles de los valores de los campos por los que agrupamos.

-- Se pueden colocar hasta 10 campos en el "group by".

-- Con "cube" se puede emplear "where" y "having", pero no es compatible con "all".



-- ********************* primer problema *********************




-- Un comercio guarda la información de sus ventas en una tabla llamada "ventas" en la que se registra 
-- diariamente, el número de venta, el monto total de la compra, el tipo de pago (c=contado, t=tarjeta) 
-- y el nombre del vendedor.

-- 1- Elimine la tabla si existe:

if object_id('ventas') is not null
drop table ventas;



-- 2- Cree la tabla:

 create table ventas(
  numero int identity,
  montocompra decimal(6,2),
  tipopago char(1),--c=contado, t=tarjeta
  vendedor varchar(30),
  primary key (numero)
 );

-- 3- Ingrese algunos registros:

insert into ventas 
values (300.50, 't', 'Lucía');

 insert into ventas
  values(100.50,'c','Marisa Perez');

 insert into ventas
  values(200,'c','Marisa Perez');

 insert into ventas
  values(50,'t','Juan Lopez');

 insert into ventas
  values(220,'c','Juan Lopez');

 insert into ventas
  values(150,'t','Marisa Perez');

 insert into ventas
  values(550.80,'c','Marisa Perez');

 insert into ventas
  values(300,'t','Juan Lopez');

 insert into ventas
  values(25,'c','Marisa Perez');

-- 4- Agrupe por "tipopago" y "vendedor" y cuente la cantidad empleando "rollup".
-- Las agrupaciones de resumen son las siguientes:
-- - vendedor (tipopago seteado a "null"), 2 filas y
-- - total (todos los campos seteados a "null"), 1 fila

select vendedor, tipopago, 
count(*) as cantidad from ventas
group by vendedor, tipopago with rollup;

-- 5- Agrupe por "tipopago" y "vendedor" y cuente la cantidad empleando "cube".
-- Las agrupaciones de resumen son las siguientes:
-- - vendedor (tipopago seteado a "null"), 2 filas,
-- - total (todos los campos seteados a "null"), 1 fila y
-- - tipopago (vendedor seteado a "null"), 2 filas.


select tipopago, vendedor, 
count(*) as cantidad 
from ventas
group by tipopago, vendedor
with cube;







-- ********************* Segundo problema *********************

-- Un comercio que tiene un stand en una feria registra en una tabla llamada "visitantes" algunos datos 
-- de las personas que visitan o compran en su stand para luego enviarle publicidad de sus productos.

-- 1- Elimine la tabla "visitantes", si existe:
if object_id('visitantes') is not null
drop table visitantes;


-- 2- Créela con la siguiente estructura:

 create table visitantes(
  nombre varchar(30),
  edad tinyint,
  sexo char(1),
  domicilio varchar(30),
  ciudad varchar(20),
  mail varchar(30) default 'no tiene',
  montocompra decimal(6,2)
 );

-- 3- Ingrese algunos registros:

insert into visitantes 
values('Laura', 28, 'f', 'Oaxaca', 'CACERES','albertogarcia@hotmail.com', 22.67 );

 insert into visitantes
  values ('Susana Molina',28,'f',null,'Cordoba',null,45.50); 

 insert into visitantes
  values ('Marcela Mercado',36,'f','Avellaneda 345','Cordoba',default,22.40);

 insert into visitantes
  values ('Alberto Garcia',35,'m',default,'Alta Gracia','albertogarcia@hotmail.com',25); 

 insert into visitantes
  values ('Teresa Garcia',33,'f',default,'Alta Gracia',default,120);

 insert into visitantes
  values ('Roberto Perez',45,'m',null,'Cordoba','robertoperez@xaxamail.com',33.20);

 insert into visitantes
  values ('Marina Torres',22,'f',null,'Villa Dolores',default,95);

 insert into visitantes
  values ('Julieta Gomez',24,'f','San Martin 333','Alta Gracia','julietagomez@gmail.com',53.50);

 insert into visitantes
  values ('Roxana Lopez',20,'f','null','Alta Gracia',default,240);

 insert into visitantes
  values ('Liliana Garcia',50,'f','Paso 999','Cordoba',default,48);

 insert into visitantes
  values ('Juan Torres',43,'m','Sarmiento 876','Cordoba',null,15.30);


-- 4- Agrupe por sexo y ciudad y calcule el total de la compra empleando "rollup" y luego "cube":


  select sum(montocompra) as total
  from visitantes
  group by sexo,ciudad
  with rollup;

-- Se generan 2 filas con "ciudad" conteniendo "null" y 1 fila con ambos campos seteados a "null".
 select sexo,ciudad,
  sum(montocompra) as total
  from visitantes
  group by sexo,ciudad
  with cube;

-- Se generan 2 filas con "ciudad" conteniendo "null" (total de sexo femenino y masculino); 1 fila con 
-- ambos campos seteados a "null" (monto total de todos los visitantes) y 3 filas con "sexo" 
-- conteniendo "null" (monto total de cada ciudad). 



-- 5- Calcule la edad promedio de los visitantes agrupando por sexo y ciudad, sin considerar los que no 
-- tienen mail, use ambos modificadores de "group by" ("rollup" y "cube"):


 select sexo,ciudad,
  avg(edad) as 'edad promedio'
  from visitantes
  where mail is not null and
  mail <>'no tiene'
  group by sexo,ciudad
  with rollup;

-- Se generan 2 filas con el promedio de edad por sexo de cada ciudad y 1 fila con el promedio de edad 
-- de todos los visitantes.

 select sexo,ciudad,
  avg(edad) as 'edad promedio'
  from visitantes
  where mail is not null and
  mail <>'no tiene'
  group by sexo,ciudad
  with cube;
-- Se generan 2 filas con el promedio de edad por sexo de cada ciudad, 1 fila con el promedio de edad 
-- de todos los visitantes y 3 filas con el promedio de edad por ciudad.


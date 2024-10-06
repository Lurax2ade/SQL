Autocombinación
 -------------------------------------------------------------------------------------------------------------------------------
-- 		Autocombinación
 -------------------------------------------------------------------------------------------------------------------------------


-- Dijimos que es posible combinar una tabla consigo misma.

-- Un pequeño restaurante tiene almacenadas sus comidas en una tabla llamada "comidas" que consta de los siguientes campos:

-- - nombre varchar(20),
-- - precio decimal (4,2) y
-- - rubro char(6)-- que indica con 'plato' si es un plato principal y 'postre' si es postre.

-- Podemos obtener la combinación de platos empleando un "cross join" con una sola tabla:

--  select c1.nombre as 'plato principal',
--   c2.nombre as postre,
--   c1.precio+c2.precio as total
--   from comidas as c1
--   cross join comidas as c2;

-- En la consulta anterior aparecen filas duplicadas, para evitarlo debemos emplear un "where":

--  select c1.nombre as 'plato principal',
--   c2.nombre as postre,
--   c1.precio+c2.precio as total
--   from comidas as c1
--   cross join comidas as c2
--   where c1.rubro='plato' and
--   c2.rubro='postre';

-- En la consulta anterior se empleó un "where" que especifica que se combine "plato" con "postre".

-- En una autocombinación se combina una tabla con una copia de si misma. Para ello debemos utilizar 2 alias para la tabla. Para evitar que aparezcan filas duplicadas, debemos emplear un "where".

-- También se puede realizar una autocombinación con "join":

--  select c1.nombre as 'plato principal',
--   c2.nombre as postre,
--   c1.precio+c2.precio as total
--   from comidas as c1
--   join comidas as c2
--   on c1.codigo<>c2.codigo
--   where c1.rubro='plato' and
--   c2.rubro='postre';

-- Para que no aparezcan filas duplicadas se agrega un "where".

-- ********************* primer problema *********************



-- Una agencia matrimonial almacena la información de sus clientes en una tabla llamada "clientes".
-- 1- Elimine la tabla si existe y créela:

 if object_id('clientes') is not null
  drop table clientes;

 create table clientes(
  nombre varchar(30),
  sexo char(1),--'f'=femenino, 'm'=masculino
  edad int,
  domicilio varchar(30)
 );


-- 2- Ingrese los siguientes registros:

 insert into clientes values('Maria Lopez','f',45,'Colon 123');
 insert into clientes values('Liliana Garcia','f',35,'Sucre 456');
 insert into clientes values('Susana Lopez','f',41,'Avellaneda 98');
 insert into clientes values('Juan Torres','m',44,'Sarmiento 755');
 insert into clientes values('Marcelo Oliva','m',56,'San Martin 874');
 insert into clientes values('Federico Pereyra','m',38,'Colon 234');
 insert into clientes values('Juan Garcia','m',50,'Peru 333');

-- 3- La agencia necesita la combinación de todas las personas de sexo femenino con las de sexo 
-- masculino. Use un  "cross join" (12 registros)


select cm.nombre, cm.edad, cv.nombre, cv.edad
from clientes as cm
cross join clientes  cv
where cm.seco='f' and cv.sexo='m';
-- 4- Obtenga la misma salida enterior pero realizando un "join".




 select cm.nombre,cm.edad,cv.nombre,cv.edad
  from clientes as cm
  join clientes cv
  on cm.nombre<>cv.nombre
  where cm.sexo='f' and cv.sexo='m';
-- 5- Realice la misma autocombinación que el punto 3 pero agregue la condición que las parejas no 
-- tengan una diferencia superior a 5 años (5 registros)





 select cm.nombre,cm.edad,cv.nombre,cv.edad
  from clientes as cm
  cross join clientes cv
  where cm.sexo='f' and cv.sexo='m' and
  cm.edad-cv.edad between -5 and 5;






-- ********************* Segundo problema *********************

-- Varios clubes de barrio se organizaron para realizar campeonatos entre ellos. La tabla llamada 
-- "equipos" guarda la informacion de los distintos equipos que jugarán.
-- 1- Elimine la tabla, si existe y créela nuevamente:

 if object_id('equipos') is not null
  drop table equipos;

 create table equipos(
  nombre varchar(30),
  barrio varchar(20),
  domicilio varchar(30),
  entrenador varchar(30)
 );

-- 2- Ingrese los siguientes registros:
 insert into equipos values('Los tigres','Gral. Paz','Sarmiento 234','Juan Lopez');
 insert into equipos values('Los leones','Centro','Colon 123','Gustavo Fuentes');
 insert into equipos values('Campeones','Pueyrredon','Guemes 346','Carlos Moreno');
 insert into equipos values('Cebollitas','Alberdi','Colon 1234','Luis Duarte');

-- 4- Cada equipo jugará con todos los demás 2 veces, una vez en cada sede. Realice un "cross join" 
-- para combinar los equipos teniendo en cuenta que un equipo no juega consigo mismo (12 registros)

select e1.nombre, e2.nombre, e1.barrio as 'sede'
from equipos as e1
cross join equipos as e2
where e1.nombre <> e2.nombre;

-- 5- Obtenga el mismo resultado empleando un "join".

select e1.nombre, e2.nombre, e1.barrio as 'sede'
from equipos as e1
 join equipos as e2
 on e1.nombre <> e2.nombre;

-- 6- Realice un "cross join" para combinar los equipos para que cada equipo juegue con cada uno de los 
-- otros una sola vez (6 registros)




 select e1.nombre,e2.nombre,e1.barrio as 'sede'
  from equipos as e1
  cross join equipos as e2
  where e1.nombre>e2.nombre;


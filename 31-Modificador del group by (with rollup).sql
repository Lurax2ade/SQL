
 
 -------------------------------------------------------------------------------------------------------------------------------
-- 	Modificador del group by (with rollup)
 -------------------------------------------------------------------------------------------------------------------------------





-- Podemos combinar "group by" con los operadores "rollup" y "cube" para generar valores de resumen a la salida.

-- El operador "rollup" resume valores de grupos. representan los valores de resumen de la precedente.

-- Tenemos la tabla "visitantes" con los siguientes campos: nombre, edad, sexo, domicilio, ciudad, telefono, montocompra.

-- Si necesitamos la cantidad de visitantes por ciudad empleamos la siguiente sentencia:

--  select ciudad,count(*) as cantidad
--   from visitantes
--   group by ciudad;

-- Esta consulta muestra el total de visitantes agrupados por ciudad; pero si queremos además la cantidad total de visitantes, debemos realizar otra consulta:

--   select count(*) as total
--    from visitantes;

-- Para obtener ambos resultados en una sola consulta podemos usar "with rollup" que nos devolverá ambas salidas en una sola consulta:

--  select ciudad,count(*) as cantidad
--   from visitantes
--   group by ciudad with rollup;

-- La consulta anterior retorna los registros agrupados por ciudad y una fila extra en la que la primera columna contiene "null" y la columna con la cantidad muestra la cantidad total.

-- La cláusula "group by" permite agregar el modificador "with rollup", el cual agrega registros extras al resultado de una consulta, que muestran operaciones de resumen.

-- Si agrupamos por 2 campos, "ciudad" y "sexo":

--  select ciudad,sexo,count(*) as cantidad
--   from visitantes
--   group by ciudad,sexo
--   with rollup;

-- La salida muestra los totales por ciudad y sexo y produce tantas filas extras como valores existen del primer campo por el que se agrupa ("ciudad" en este caso), mostrando los totales para cada valor, con la columna correspondiente al segundo campo por el que se agrupa ("sexo" en este ejemplo) conteniendo "null", y 1 fila extra mostrando el total de todos los visitantes (con las columnas correspondientes a ambos campos conteniendo "null"). Es decir, por cada agrupación, aparece una fila extra con el/ los campos que no se consideran, seteados a "null".

-- Con "rollup" se puede agrupar hasta por 10 campos.

-- Es posible incluir varias funciones de agrupamiento, por ejemplo, queremos la cantidad de visitantes y la suma de sus compras agrupados por ciudad y sexo:

--  select ciudad,sexo,
--   count(*) as cantidad,
--   sum(montocompra) as total
--   from visitantes
--   group by ciudad,sexo
--   with rollup;

-- Entonces, "rollup" es un modificador para "group by" que agrega filas extras mostrando resultados de resumen de los subgrupos. Si se agrupa por 2 campos SQL Server genera tantas filas extras como valores existen del primer campo (con el segundo campo seteado a "null") y una fila extra con ambos campos conteniendo "null".

-- Con "rollup" se puede emplear "where" y "having", pero no es compatible con "all".






-- ********************* primer problema *********************


-- Una empresa tiene registrados sus clientes en una tabla llamada "clientes".

-- 1- Elimine la tabla "clientes", si existe:

if object_id('clientes') is not null
drop table clientes;


-- 2- Créela con la siguiente estructura:

 create table clientes (
  codigo int identity,
  nombre varchar(30) not null,
  domicilio varchar(30),
  ciudad varchar(20),
  estado varchar (20),
  pais varchar(20),
  primary key(codigo)
 );

-- 3- Ingrese algunos registros:


insert into clientes
values ('Lucia', 'Oaxaca 23', 'Caceres', 'México', 'Argentina');

 insert into clientes
  values ('Lopez Marcos','Colon 111', 'Cordoba','Cordoba','Argentina');

 insert into clientes
  values ('Perez Ana','San Martin 222', 'Carlos Paz','Cordoba','Argentina');

 insert into clientes
  values ('Garcia Juan','Rivadavia 333', 'Carlos Paz','Cordoba','Argentina');

 insert into clientes
  values ('Perez Luis','Sarmiento 444', 'Rosario','Santa Fe','Argentina');

 insert into clientes
  values ('Gomez Ines','San Martin 987', 'Santa Fe','Santa Fe','Argentina');

 insert into clientes
  values ('Gomez Ines','San Martin 666', 'Santa Fe','Santa Fe','Argentina');

 insert into clientes
  values ('Lopez Carlos','Irigoyen 888', 'Cordoba','Cordoba','Argentina');

 insert into clientes
  values ('Ramos Betina','San Martin 999', 'Cordoba','Cordoba','Argentina');

 insert into clientes
  values ('Fernando Salas','Mariano Osorio 1234', 'Santiago','Region metropolitana','Chile');

 insert into clientes
  values ('German Rojas','Allende 345', 'Valparaiso','Region V','Chile');

 insert into clientes
  values ('Ricardo Jara','Pablo Neruda 146', 'Santiago','Region metropolitana','Chile');

 insert into clientes
  values ('Joaquin Robles','Diego Rivera 147', 'Guadalajara','Jalisco','Mexico');


-- 4- Necesitamos la cantidad de clientes por país y la cantidad total de clientes en una sola consulta 
-- (4 filas)
-- Note que la consulta retorna los registros agrupados por pais y una fila extra en la que la columna 
-- "pais" contiene "null" y la columna con la cantidad muestra la cantidad total.

select pais, count(*) as cantidad
from clientes
group by pais with rollup;

-- 5- Necesitamos la cantidad de clientes agrupados por pais y estado, incluyendo resultados paciales 
-- (9 filas)
-- Note que la salida muestra los totales por pais y estado y produce 4 filas extras: 3 muestran los 
-- totales para cada pais, con la columna "estado" conteniendo "null" y 1 muestra el total de todos los 
-- clientes, con las columnas "pais" y "estado" conteniendo "null".

select pais, estado, 
count(*)as cantidad
from clientes
group by pais, estado with rollup;


-- 6- Necesitamos la cantidad de clientes agrupados por pais, estado y ciudad, empleando "rollup" (16 
-- filas)
-- El resultado muestra los totales por pais, estado y ciudad y genera 9 filas extras: 5 muestran los 
-- totales para cada estado, con la columna correspondiente a "ciudad" conteniendo "null", 3 muestran 
-- los totales para cada pais, con las columnas "ciudad" y "estado" conteniendo "null" y 1 muestra el 
-- total de todos los clientes, con las columnas "pais", "estado" y "ciudad" conteniendo "null".


select pais, estado, ciudad, 
count(*) as cantidad
from clientes
group by pais, estado, ciudad
with rollup;

 





-- ********************* Segundo problema *********************



-- Un instituto de enseñanza guarda las notas de sus alumnos en una tabla llamada "notas".

-- 1- Elimine la tabla si existe:

 if object_id('notas') is not null
  drop table notas;

-- 2- Cree la tabla con la siguiente estructura:

 create table notas(
  documento char(8) not null,
  materia varchar(30),
  nota decimal(4,2)
 );

-- 3-Ingrese algunos registros:

 insert into notas values ('22333444','Programacion',8);

 insert into notas values ('22333444','Programacion',9);

 insert into notas values ('22333444','Ingles',8);

 insert into notas values ('22333444','Ingles',7);

 insert into notas values ('22333444','Ingles',6);

 insert into notas values ('22333444','Sistemas de datos',10);

 insert into notas values ('22333444','Sistemas de datos',9);

 insert into notas values ('23444555','Programacion',5);

 insert into notas values ('23444555','Programacion',4);

 insert into notas values ('23444555','Programacion',3);

 insert into notas values ('23444555','Ingles',9);

 insert into notas values ('23444555','Ingles',7);

 insert into notas values ('23444555','Sistemas de datos',9);

 insert into notas values ('24555666','Programacion',1);

 insert into notas values ('24555666','Programacion',3.5);

 insert into notas values ('24555666','Ingles',4.5);

 insert into notas values ('24555666','Sistemas de datos',6);

-- 4- Se necesita el promedio por alumno por materia y el promedio de cada alumno en todas las materias 
-- cursadas hasta el momento (13 registros):

select documento, materia, 
avg(nota) as promedio
from notas
group by documento, materia with rollup;



-- Note que  hay 4 filas extras, 3 con el promedio de cada alumno y 1 con el promedio de todos los 
-- alumnos de todas las materias.

-- 5- Compruebe los resultados parciales de la consulta anterior realizando otra consulta mostrando el 
-- promedio de todas las carreras de cada alumno (4 filas)

select documento, 
avg(nota) as promedio
from notas
group by documento with rollup;


-- 6- Muestre la cantidad de notas de cada alumno, por materia (9 filas)

select documento, materia, 
count(nota) as cantidad
from notas
group by documento, materia;

-- 7- Realice la misma consulta anterior con resultados parciales incluidos (13 filas)

select documento, materia, 
count(nota) as cantidad
from notas
group by documento, materia with rollup;

-- 8- Muestre la nota menor y la mayor de cada alumno y la menor y mayor nota de todos (use "rollup") 
-- (4 filas)



select documento, 
min(nota) as 'Nota menor', 
max(nota) as 'Nota mayor'
from notas
  group by documento with rollup;



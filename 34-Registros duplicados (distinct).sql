
 
 -------------------------------------------------------------------------------------------------------------------------------
--	Registros duplicados (distinct)
 -------------------------------------------------------------------------------------------------------------------------------

-- Ver video

-- Con la cláusula "distinct" se especifica que los registros con ciertos datos duplicados sean obviadas en el resultado. Por ejemplo, queremos conocer todos los autores de los cuales tenemos libros, si utilizamos esta sentencia:

--  select autor from libros;

-- Aparecen repetidos. Para obtener la lista de autores sin repetición usamos:

--  select distinct autor from libros;

-- También podemos tipear:

--  select autor from libros
--   group by autor;

-- Note que en los tres casos anteriores aparece "null" como un valor para "autor"· Si sólo queremos la lista de autores conocidos, es decir, no queremos incluir "null" en la lista, podemos utilizar la sentencia siguiente:

--  select distinct autor from libros
--   where autor is not null;

-- Para contar los distintos autores, sin considerar el valor "null" usamos:

--  select count(distinct autor)
--   from libros;

-- Note que si contamos los autores sin "distinct", no incluirá los valores "null" pero si los repetidos:

--  select count(autor)
--   from libros;

-- Esta sentencia cuenta los registros que tienen autor.

-- Podemos combinarla con "where". Por ejemplo, queremos conocer los distintos autores de la editorial "Planeta":

--  select distinct autor from libros
--   where editorial='Planeta';

-- También puede utilizarse con "group by" para contar los diferentes autores por editorial:

--  select editorial, count(distinct autor)
--   from libros
--   group by editorial;

-- La cláusula "distinct" afecta a todos los campos presentados. Para mostrar los títulos y editoriales de los libros sin repetir títulos ni editoriales, usamos:

--  select distinct titulo,editorial
--   from libros
--   order by titulo;

-- Note que los registros no están duplicados, aparecen títulos iguales pero con editorial diferente, cada registro es diferente.

-- Entonces, "distinct" elimina registros duplicados.



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
  provincia varchar (20),
  primary key(codigo)
);

-- 3- Ingrese algunos registros:

 insert into clientes
  values ('Lopez Marcos','Colon 111','Cordoba','Cordoba');

 insert into clientes
  values ('Perez Ana','San Martin 222','Cruz del Eje','Cordoba');

 insert into clientes
  values ('Garcia Juan','Rivadavia 333','Villa del Rosario','Cordoba');

 insert into clientes
  values ('Perez Luis','Sarmiento 444','Rosario','Santa Fe');

 insert into clientes
  values ('Pereyra Lucas','San Martin 555','Cruz del Eje','Cordoba');

 insert into clientes
  values ('Gomez Ines','San Martin 666','Santa Fe','Santa Fe');

 insert into clientes
  values ('Torres Fabiola','Alem 777','Villa del Rosario','Cordoba');

 insert into clientes
  values ('Lopez Carlos',null,'Cruz del Eje','Cordoba');

 insert into clientes
  values ('Ramos Betina','San Martin 999','Cordoba','Cordoba');

 insert into clientes
  values ('Lopez Lucas','San Martin 1010','Posadas','Misiones');


-- 4- Obtenga las provincias sin repetir (3 registros)

select distinct provincia from clientes;

-- 5- Cuente las distintas provincias.

select count(distinct provincia) as cantidad
from clientes;

-- 6- Se necesitan los nombres de las ciudades sin repetir (6 registros)

select distinct ciudad from clientes;

-- 7- Obtenga la cantidad de ciudades distintas.

select count(distinct ciudad)
 as cantidad
 from clientes;

-- 8- Combine con "where" para obtener las distintas ciudades de la provincia de Cordoba (3 registros)

select ditinct ciudad from clientes
where provincia='Cordoba';

-- 9- Contamos las distintas ciudades de cada provincia empleando "group by" (3 registros)


select provincia, count(distinct ciudad)
from clientes
group by provincia;




 




-- ********************* Segundo problema *********************


-- La provincia almacena en una tabla llamada "inmuebles" los siguientes datos de los inmuebles y sus 
-- propietarios para cobrar impuestos:


-- 1- Elimine la tabla si existe:

 if object_id('inmuebles') is not null
  drop table inmuebles;

-- 2- Créela con la siguiente estructura:

 create table inmuebles (
  documento varchar(8) not null,
  apellido varchar(30),
  nombre varchar(30),
  domicilio varchar(20),
  barrio varchar(20),
  ciudad varchar(20),
  tipo char(1),--b=baldio, e: edificado
  superficie decimal (8,2)
 );

-- 3- Ingrese algunos registros:

 insert into inmuebles
  values ('11000000','Perez','Alberto','San Martin 800','Centro','Cordoba','e',100);

 insert into inmuebles
  values ('11000000','Perez','Alberto','Sarmiento 245','Gral. Paz','Cordoba','e',200);

 insert into inmuebles
  values ('12222222','Lopez','Maria','San Martin 202','Centro','Cordoba','e',250);

 insert into inmuebles
  values ('13333333','Garcia','Carlos','Paso 1234','Alberdi','Cordoba','b',200);

 insert into inmuebles
  values ('13333333','Garcia','Carlos','Guemes 876','Alberdi','Cordoba','b',300);

 insert into inmuebles
  values ('14444444','Perez','Mariana','Caseros 456','Flores','Cordoba','b',200);

 insert into inmuebles
  values ('15555555','Lopez','Luis','San Martin 321','Centro','Carlos Paz','e',500);

 insert into inmuebles
  values ('15555555','Lopez','Luis','Lopez y Planes 853','Flores','Carlos Paz','e',350);

 insert into inmuebles
  values ('16666666','Perez','Alberto','Sucre 1877','Flores','Cordoba','e',150);


-- 4- Muestre los distintos apellidos de los propietarios, sin repetir (3 registros)

select distinct apellido from inmuebles;

-- 5- Muestre los distintos documentos de los propietarios, sin repetir (6 registros)

select distinct documento from inmuebles;

-- 6- Cuente, sin repetir, la cantidad de propietarios de inmuebles de la ciudad de Cordoba (5)

select count(distinct documento)
from inmuebles
where ciudad='Cordoba';

-- 7- Cuente la cantidad de inmuebles con domicilio en 'San Martin', sin repetir la ciudad (2)

select count(ciudad)
from inmuebles
where domicilio like '%San Martin%';

-- 8- Muestre los apellidos y nombres, sin repetir (5 registros)
-- Note que hay 2 personas con igual nombre y apellido que aparece una sola vez.

select distinct apellido, nombre
from inmuebles;

-- 9- Muestre la cantidad de inmuebles que tiene cada propietario agrupando por documento, sin repetir 
-- barrio (6 registros)

select documento, count(distinct barrio) as cantidad
from inmuebles
group by documento;



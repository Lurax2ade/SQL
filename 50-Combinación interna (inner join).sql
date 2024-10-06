
 -------------------------------------------------------------------------------------------------------------------------------
-- 		Combinación interna (inner join)
 -------------------------------------------------------------------------------------------------------------------------------


-- Un join es una operación que relaciona dos o más tablas para obtener un resultado que incluya datos (campos y registros) de ambas; las tablas participantes se combinan según los campos comunes a ambas tablas.

-- Hay tres tipos de combinaciones:

--     combinaciones internas (inner join o join),
--     combinaciones externas y
--     combinaciones cruzadas.

-- También es posible emplear varias combinaciones en una consulta "select", incluso puede combinarse una tabla consigo misma.

-- La combinación interna emplea "join", que es la forma abreviada de "inner join". Se emplea para obtener información de dos tablas y combinar dicha información en una salida.

-- La sintaxis básica es la siguiente:

--  select CAMPOS
--   from TABLA1
--   join TABLA2
--   on CONDICIONdeCOMBINACION;

-- Ejemplo:

--  select * from libros
--   join editoriales
--   on codigoeditorial=editoriales.codigo;

-- Analicemos la consulta anterior.

-- - especificamos los campos que aparecerán en el resultado en la lista de selección;

-- - indicamos el nombre de la tabla luego del "from" ("libros");

-- - combinamos esa tabla con "join" y el nombre de la otra tabla ("editoriales"); se especifica qué tablas se van a combinar y cómo;

-- - cuando se combina información de varias tablas, es necesario especificar qué registro de una tabla se combinará con qué registro de la otra tabla, con "on". Se debe especificar la condición para enlazarlas, es decir, el campo por el cual se combinarán, que tienen en común.
-- "on" hace coincidir registros de ambas tablas basándose en el valor de tal campo, en el ejemplo, el campo "codigoeditorial" de "libros" y el campo "codigo" de "editoriales" son los que enlazarán ambas tablas. Se emplean campos comunes, que deben tener tipos de datos iguales o similares.

-- La condicion de combinación, es decir, el o los campos por los que se van a combinar (parte "on"), se especifica según las claves primarias y externas.

-- Note que en la consulta, al nombrar el campo usamos el nombre de la tabla también. Cuando las tablas referenciadas tienen campos con igual nombre, esto es necesario para evitar confusiones y ambiguedades al momento de referenciar un campo. En el ejemplo, si no especificamos "editoriales.codigo" y solamente tipeamos "codigo", SQL Server no sabrá si nos referimos al campo "codigo" de "libros" o de "editoriales" y mostrará un mensaje de error indicando que "codigo" es ambiguo.

-- Entonces, si las tablas que combinamos tienen nombres de campos iguales, DEBE especificarse a qué tabla pertenece anteponiendo el nombre de la tabla al nombre del campo, separado por un punto (.).

-- Si una de las tablas tiene clave primaria compuesta, al combinarla con la otra, en la cláusula "on" se debe hacer referencia a la clave completa, es decir, la condición referenciará a todos los campos clave que identifican al registro.

-- Se puede incluir en la consulta join la cláusula "where" para restringir los registros que retorna el resultado; también "order by", "distinct", etc..

-- Se emplea este tipo de combinación para encontrar registros de la primera tabla que se correspondan con los registros de la otra, es decir, que cumplan la condición del "on". Si un valor de la primera tabla no se encuentra en la segunda tabla, el registro no aparece.

-- Para simplificar la sentencia podemos usar un alias para cada tabla:

--  select l.codigo,titulo,autor,nombre
--   from libros as l
--   join editoriales as e
--   on l.codigoeditorial=e.codigo;

-- En algunos casos (como en este ejemplo) el uso de alias es para fines de simplificación y hace más legible la consulta si es larga y compleja, pero en algunas consultas es absolutamente necesario.



-- ********************* primer problema *********************


-- Una empresa tiene registrados sus clientes en una tabla llamada "clientes", también tiene una tabla 
-- "provincias" donde registra los nombres de las provincias.

-- 1- Elimine las tablas "clientes" y "provincias", si existen:

if object_id('clientes') is not null
drop table clientes;

if object_id('provincias') is not null
drop table provincias;



-- 2- Créelas con las siguientes estructuras:

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

-- 3- Ingrese algunos registros para ambas tablas:

 insert into provincias (nombre) values('Cordoba');
 insert into provincias (nombre) values('Santa Fe');
 insert into provincias (nombre) values('Corrientes');

 insert into clientes values ('Lopez Marcos','Colon 111','Córdoba',1);
 insert into clientes values ('Perez Ana','San Martin 222','Cruz del Eje',1);
 insert into clientes values ('Garcia Juan','Rivadavia 333','Villa Maria',1);
 insert into clientes values ('Perez Luis','Sarmiento 444','Rosario',2);
 insert into clientes values ('Pereyra Lucas','San Martin 555','Cruz del Eje',1);
 insert into clientes values ('Gomez Ines','San Martin 666','Santa Fe',2);
 insert into clientes values ('Torres Fabiola','Alem 777','Ibera',3);

-- 4- Obtenga los datos de ambas tablas, usando alias:

select c.nombre, domicilio, ciudad, p.nombre
from clientes as c
join provincias as p
on c.codigoprovincia=p.codigo;



-- 5- Obtenga la misma información anterior pero ordenada por nombre de provincia.

select c.nombre, domicilio, ciudad, p.nombre
from clientes as c
join provincias as p
on c.codigoprovincia=p.codigo
order by p.nombre;

-- 6- Recupere los clientes de la provincia "Santa Fe" (2 registros devueltos)

select c.nombre, domicilio, ciudad
from clientes as c
join provincias as p
on c.codigoprovincia=p.codigo
where p.nombre='Santa Fe';







-- ********************* Segundo problema *********************


-- Un club dicta clases de distintos deportes. Almacena la información en una tabla llamada 
-- "inscriptos" que incluye el documento, el nombre, el deporte y si la matricula esta paga o no y una 
-- tabla llamada "inasistencias" que incluye el documento, el deporte y la fecha de la inasistencia.
-- 1- Elimine las tablas si existen y cree las tablas:

if object_id('inscriptos') is not null
drop table inscriptos;

if object_id('inasistencias') is not null
drop table inasistencias;



 create table inscriptos(
  nombre varchar(30),
  documento char(8),
  deporte varchar(15),
  matricula char(1), --'s'=paga 'n'=impaga
  primary key(documento,deporte)
 );

 create table inasistencias(
  documento char(8),
  deporte varchar(15),
  fecha datetime
 );

-- 2- Ingrese algunos registros para ambas tablas:

 insert into inscriptos values('Juan Perez','22222222','tenis','s');
 insert into inscriptos values('Maria Lopez','23333333','tenis','s');
 insert into inscriptos values('Agustin Juarez','24444444','tenis','n');
 insert into inscriptos values('Marta Garcia','25555555','natacion','s');
 insert into inscriptos values('Juan Perez','22222222','natacion','s');
 insert into inscriptos values('Maria Lopez','23333333','natacion','n');

 insert into inasistencias values('22222222','tenis','2006-12-01');
 insert into inasistencias values('22222222','tenis','2006-12-08');
 insert into inasistencias values('23333333','tenis','2006-12-01');
 insert into inasistencias values('24444444','tenis','2006-12-08');
 insert into inasistencias values('22222222','natacion','2006-12-02');
 insert into inasistencias values('23333333','natacion','2006-12-02');

-- 3- Muestre el nombre, el deporte y las fechas de inasistencias, ordenado por nombre y deporte.
-- Note que la condición es compuesta porque para identificar los registros de la tabla "inasistencias" 
-- necesitamos ambos campos.


select ins.nombre, ins.deporte, ina.fecha
from inscriptos as ins
join inasistencias as ina
on ins.documento=ina.documento and
inc.deporte= ina.deporte
order by nombre, insc.deporte;

-- 4- Obtenga el nombre, deporte y las fechas de inasistencias de un determinado inscripto en un 
-- determinado deporte (3 registros)


 select nombre,insc.deporte, ina.fecha
  from inscriptos as insc
  join inasistencias as ina
  on insc.documento=ina.documento and
  insc.deporte=ina.deporte
  where insc.documento='22222222';
-- 5- Obtenga el nombre, deporte y las fechas de inasistencias de todos los inscriptos que pagaron la 
-- matrícula(4 registros)



 select nombre,insc.deporte, ina.fecha
  from inscriptos as insc
  join inasistencias as ina
  on insc.documento=ina.documento and
  insc.deporte=ina.deporte
  where insc.matricula='s';

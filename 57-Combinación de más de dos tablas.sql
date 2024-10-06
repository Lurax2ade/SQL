
 -------------------------------------------------------------------------------------------------------------------------------
-- 		Combinación de más de dos tablas
 -------------------------------------------------------------------------------------------------------------------------------

-- Podemos hacer un "join" con más de dos tablas.

-- Cada join combina 2 tablas. Se pueden emplear varios join para enlazar varias tablas. Cada resultado de un join es una tabla que puede combinarse con otro join.

-- La librería almacena los datos de sus libros en tres tablas: libros, editoriales y autores.
-- En la tabla "libros" un campo "codigoautor" hace referencia al autor y un campo "codigoeditorial" referencia la editorial.

-- Para recuperar todos los datos de los libros empleamos la siguiente consulta:

--  select titulo,a.nombre,e.nombre
--   from autores as a
--   join libros as l
--   on codigoautor=a.codigo
--   join editoriales as e  on codigoeditorial=e.codigo;

-- Analicemos la consulta anterior. Indicamos el nombre de la tabla luego del "from" ("autores"), combinamos esa tabla con la tabla "libros" especificando con "on" el campo por el cual se combinarán; luego debemos hacer coincidir los valores para el enlace con la tabla "editoriales" enlazándolas por los campos correspondientes. Utilizamos alias para una sentencia más sencilla y comprensible.

-- Note que especificamos a qué tabla pertenecen los campos cuyo nombre se repiten en las tablas, esto es necesario para evitar confusiones y ambiguedades al momento de referenciar un campo.

-- Note que no aparecen los libros cuyo código de autor no se encuentra en "autores" y cuya editorial no existe en "editoriales", esto es porque realizamos una combinación interna.

-- Podemos combinar varios tipos de join en una misma sentencia:

--  select titulo,a.nombre,e.nombre
--   from autores as a
--   right join libros as l
--   on codigoautor=a.codigo
--   left join editoriales as e  on codigoeditorial=e.codigo;

-- En la consulta anterior solicitamos el título, autor y editorial de todos los libros que encuentren o no coincidencia con "autores" ("right join") y a ese resultado lo combinamos con "editoriales", encuentren o no coincidencia.

-- Es posible realizar varias combinaciones para obtener información de varias tablas. Las tablas deben tener claves externas relacionadas con las tablas a combinar.

-- En consultas en las cuales empleamos varios "join" es importante tener en cuenta el orden de las tablas y los tipos de "join"; recuerde que la tabla resultado del primer join es la que se combina con el segundo join, no la segunda tabla nombrada. En el ejemplo anterior, el "left join" no se realiza entre las tablas "libros" y "editoriales" sino entre el resultado del "right join" y la tabla "editoriales".



-- ********************* primer problema *********************




-- Un club dicta clases de distintos deportes. En una tabla llamada "socios" guarda los datos de los 
-- socios, en una tabla llamada "deportes" la información referente a los diferentes deportes que se 
-- dictan y en una tabla denominada "inscriptos", las inscripciones de los socios a los distintos 
-- deportes.
-- Un socio puede inscribirse en varios deportes el mismo año. Un socio no puede inscribirse en el 
-- mismo deporte el mismo año. Distintos socios se inscriben en un mismo deporte en el mismo año.
-- 1- Elimine las tablas si existen:
 if object_id('socios') is not null
  drop table socios;
 if object_id('deportes') is not null
  drop table deportes;
 if object_id('inscriptos') is not null
  drop table inscriptos;

-- 2- Cree las tablas con las siguientes estructuras:
 create table socios(
  documento char(8) not null, 
  nombre varchar(30),
  domicilio varchar(30),
  primary key(documento)
 );
 create table deportes(
  codigo tinyint identity,
  nombre varchar(20),
  profesor varchar(15),
  primary key(codigo)
 );
 create table inscriptos(
  documento char(8) not null, 
  codigodeporte tinyint not null,
  anio char(4),
  matricula char(1),--'s'=paga, 'n'=impaga
  primary key(documento,codigodeporte,anio)
 );

-- 3- Ingrese algunos registros en "socios":
 insert into socios values('22222222','Ana Acosta','Avellaneda 111');
 insert into socios values('23333333','Betina Bustos','Bulnes 222');
 insert into socios values('24444444','Carlos Castro','Caseros 333');
 insert into socios values('25555555','Daniel Duarte','Dinamarca 44');
-- 4- Ingrese algunos registros en "deportes":
 insert into deportes values('basquet','Juan Juarez');
 insert into deportes values('futbol','Pedro Perez');
 insert into deportes values('natacion','Marina Morales');
 insert into deportes values('tenis','Marina Morales');

-- 5- Inscriba a varios socios en el mismo deporte en el mismo año:
 insert into inscriptos values ('22222222',3,'2006','s');
 insert into inscriptos values ('23333333',3,'2006','s');
 insert into inscriptos values ('24444444',3,'2006','n');

-- 6- Inscriba a un mismo socio en el mismo deporte en distintos años:
 insert into inscriptos values ('22222222',3,'2005','s');
 insert into inscriptos values ('22222222',3,'2007','n');

-- 7- Inscriba a un mismo socio en distintos deportes el mismo año:
 insert into inscriptos values ('24444444',1,'2006','s');
 insert into inscriptos values ('24444444',2,'2006','s');

-- 8- Ingrese una inscripción con un código de deporte inexistente y un documento de socio que no 
-- exista en "socios":
 insert into inscriptos values ('26666666',0,'2006','s');

-- 9- Muestre el nombre del socio, el nombre del deporte en que se inscribió y el año empleando 
-- diferentes tipos de join.

select s.nombre, d.nombre, anio
from deportes as d
right join inscriptos as i
on codigodeporte=d.codigoleft join socias as s
on i.documento=s.documento;


-- 10- Muestre todos los datos de las inscripciones (excepto los códigos) incluyendo aquellas 
-- inscripciones cuyo código de deporte no existe en "deportes" y cuyo documento de socio no se 
-- encuentra en "socios".


 select s.nombre,d.nombre,anio,matricula
  from deportes as d
  full join inscriptos as i
  on codigodeporte=d.codigo
  full join socios as s
  on s.documento=i.documento;



-- 11- Muestre todas las inscripciones del socio con documento "22222222".




 select s.nombre,d.nombre,anio,matricula
  from deportes as d
  join inscriptos as i
  on codigodeporte=d.codigo
  join socios as s
  on s.documento=i.documento
  where s.documento='22222222';


-- ********************* Segundo problema *********************



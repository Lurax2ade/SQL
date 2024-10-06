
 -------------------------------------------------------------------------------------------------------------------------------
--	Combinación externa completa (full join)
 -------------------------------------------------------------------------------------------------------------------------------

-- Vimos que un "left join" encuentra registros de la tabla izquierda que se correspondan con los registros de la tabla derecha y si un valor de la tabla izquierda no se encuentra en la tabla derecha, el registro muestra los campos correspondientes a la tabla de la derecha seteados a "null". Aprendimos también que un "right join" opera del mismo modo sólo que la tabla derecha es la que localiza los registros en la tabla izquierda.

-- Una combinación externa completa ("full outer join" o "full join") retorna todos los registros de ambas tablas. Si un registro de una tabla izquierda no encuentra coincidencia en la tabla derecha, las columnas correspondientes a campos de la tabla derecha aparecen seteadas a "null", y si la tabla de la derecha no encuentra correspondencia en la tabla izquierda, los campos de esta última aparecen conteniendo "null".

-- Veamos un ejemplo:

--  select titulo,nombre
--   from editoriales as e
--   full join libros as l
--   on codigoeditorial = e.codigo;

-- La salida del "full join" precedente muestra todos los registros de ambas tablas, incluyendo los libros cuyo código de editorial no existe en la tabla "editoriales" y las editoriales de las cuales no hay correspondencia en "libros".



 -- ********************* primer problema *********************



-- Un club dicta clases de distintos deportes. Almacena la información en una tabla llamada "deportes" 
-- en la cual incluye el nombre del deporte y el nombre del profesor y en otra tabla llamada 
-- "inscriptos" que incluye el documento del socio que se inscribe, el deporte y si la matricula está 
-- paga o no.
-- 1- Elimine las tablas si existen y cree las tablas:

 if (object_id('deportes')) is not null
  drop table deportes;

 if (object_id('inscriptos')) is not null
  drop table inscriptos;


 create table deportes(
  codigo tinyint identity,
  nombre varchar(30),
  profesor varchar(30),
  primary key (codigo)
 );
 create table inscriptos(
  documento char(8),
  codigodeporte tinyint not null,
  matricula char(1) --'s'=paga 'n'=impaga
 );

-- 2- Ingrese algunos registros para ambas tablas:
 insert into deportes values('tenis','Marcelo Roca');
 insert into deportes values('natacion','Marta Torres');
 insert into deportes values('basquet','Luis Garcia');
 insert into deportes values('futbol','Marcelo Roca');
 
 insert into inscriptos values('22222222',3,'s');
 insert into inscriptos values('23333333',3,'s');
 insert into inscriptos values('24444444',3,'n');
 insert into inscriptos values('22222222',2,'s');
 insert into inscriptos values('23333333',2,'s');
 insert into inscriptos values('22222222',4,'n'); 
 insert into inscriptos values('22222222',5,'n'); 

-- 3- Muestre todos la información de la tabla "inscriptos", y consulte la tabla "deportes" para 
-- obtener el nombre de cada deporte (6 registros)



select documento,matricula, d.nombre
from inscriptos as i
join deportes as d
on codigodeporte=codigo;


-- 4- Empleando un "left join" con "deportes" obtenga todos los datos de los inscriptos (7 registros)


select documento,matricula, d.nombre
from inscriptos as i
left join deportes as d
on codigodeporte=codigo;




-- 5- Obtenga la misma salida anterior empleando un "rigth join".


select documento,matricula, d.nombre
from deportes as d
right join inscriptos as i
on codigodeporte=codigo;


-- 6- Muestre los deportes para los cuales no hay inscriptos, empleando un "left join" (1 registro)

select documento,matricula, d.nombre
from inscriptos as i
left join deportes as d
on codigodeporte=codigo
where codigodeporte is null;



 

-- 7- Muestre los documentos de los inscriptos a deportes que no existen en la tabla "deportes" (1 
-- registro)


 select documento
  from inscriptos as i
  left join deportes as d
  on codigodeporte=codigo
  where codigo is null;

-- 8- Emplee un "full join" para obtener todos los datos de ambas tablas, incluyendo las inscripciones 
-- a deportes inexistentes en "deportes" y los deportes que no tienen inscriptos (8 registros)



 select documento,nombre,profesor,matricula
  from inscriptos as i
  full join deportes as d
  on codigodeporte=codigo; 





-- ********************* segundo problema *********************



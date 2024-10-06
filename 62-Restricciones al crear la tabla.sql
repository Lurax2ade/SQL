
 
--  -------------------------------------------------------------------------------------------------------------------------------
-- --	Restricciones al crear la tabla
--  -------------------------------------------------------------------------------------------------------------------------------

-- Hasta el momento hemos agregado restricciones a tablas existentes con "alter table" (manera aconsejada), también pueden establecerse al momento de 
--crear una tabla (en la instrucción "create table").

-- Podemos aplicar restricciones a nivel de campo (restricción de campo) o a nivel de tabla (restricción de tabla).

-- En el siguiente ejemplo creamos la tabla "libros" con varias restricciones:

--  create table libros(
--   codigo int identity,
--   titulo varchar(40),
--   codigoautor int not null,
--   codigoeditorial tinyint not null,
--   precio decimal(5,2)
--    constraint DF_precio default (0),
--   constraint PK_libros_codigo
--    primary key clustered (codigo),
--   constraint UQ_libros_tituloautor
--     unique (titulo,codigoautor),
--   constraint FK_libros_editorial
--    foreign key (codigoeditorial)
--    references editoriales(codigo)
--    on update cascade,
--   constraint FK_libros_autores
--    foreign key (codigoautor)
--    references autores(codigo)
--    on update cascade,
--   constraint CK_precio_positivo check (precio>=0)
-- );

-- En el ejemplo anterior creamos:

-- - una restricción "default" para el campo "precio" (restricción a nivel de campo);

-- - una restricción "primary key" con índice agrupado para el campo "codigo" (a nivel de tabla);

-- - una restricción "unique" con índice no agrupado (por defecto) para los campos "titulo" y "codigoautor" (a nivel de tabla);

-- - una restricción "foreign key" para establecer el campo "codigoeditorial" como clave externa que haga referencia al campo "codigo" de "editoriales y permita actualizaciones en cascada y no eliminaciones (por defecto "no action");

-- - una restricción "foreign key" para establecer el campo "codigoautor" como clave externa que haga referencia al campo "codigo" de "autores" y permita actualizaciones en cascada y no eliminaciones;

-- - una restricción "check" para el campo "precio" que no admita valores negativos;

-- Si definimos una restricción "foreign key" al crear una tabla, la tabla referenciada debe existir.

-- -- ********************* primer problema *********************


-- Un club de barrio tiene en su sistema 4 tablas:

-- - "socios": en la cual almacena documento, número, nombre y domicilio de cada socio;

-- - "deportes": que guarda un código, nombre del deporte, día de la semana que se dicta y documento 
-- del profesor instructor;

-- - "profesores": donde se guarda el documento, nombre y domicilio de los profesores e

-- - "inscriptos": que almacena el número de socio, el código de deporte y si la matricula está paga o 
-- no.

-- 1- Elimine las tablas si existen:

if object_id('socios') is not null
drop table socios;

if object_id('profesores') is not null
drop table profesores;

if object_id('deportes') is not null
drop table deportes;

if object_id('inscriptos') is not null
drop table inscriptos;

-- 2- Considere que:

-- - un socio puede inscribirse en varios deportes, pero no dos veces en el mismo.
-- - un socio tiene un documento único y un número de socio único.
-- - el documento del socio debe contener 8 dígitos.
-- - un deporte debe tener asignado un profesor que exista en "profesores" o "null" si aún no tiene un 
-- instructor definido.
-- - el campo "dia" de "deportes" puede ser: lunes, martes, miercoles, jueves, viernes o sabado.
-- - el campo "dia" de "deportes" por defecto debe almacenar 'sabado'.
-- - un profesor puede ser instructor de varios deportes o puede no dictar ningún deporte.
-- - un profesor no puede estar repetido en "profesores".
-- - el documento del profesor debe contener 8 dígitos.
-- - un inscripto debe ser socio, un socio puede no estar inscripto en ningún deporte.
-- - una inscripción debe tener un valor en socio existente en "socios" y un deporte que exista en 
-- "deportes".
-- - el campo "matricula" de "inscriptos" debe aceptar solamente los caracteres 's' o 'n'.

-- 3- Cree las tablas con las restricciones necesarias:
 create table profesores(
  documento char(8) not null,
  nombre varchar(30),
  domicilio varchar(30),
  constraint CK_profesores_documento_patron check (documento like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
  constraint PK_profesores_documento
   primary key (documento)
 );

 create table deportes(
  codigo tinyint identity,
  nombre varchar(20) not null,
  dia varchar(30)
   constraint DF_deportes_dia default('sabado'),
  profesor char(8),--documento del profesor
  constraint CK_deportes_dia_lista check (dia in ('lunes','martes','miercoles','jueves','viernes','sabado')),
  constraint PK_deportes_codigo
   primary key (codigo)
 );

 create table socios(
  numero int identity,
  documento char(8),
  nombre varchar(30),
  domicilio varchar(30),
  constraint CK_documento_patron check (documento like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
  constraint PK_socios_numero
   primary key nonclustered(numero),
  constraint UQ_socios_documento
   unique clustered(documento)
 );

 create table inscriptos(
  numerosocio int not null,
  codigodeporte tinyint,
  matricula char(1),
  constraint PK_inscriptos_numerodeporte
   primary key clustered (numerosocio,codigodeporte),
  constraint FK_inscriptos_deporte
   foreign key (codigodeporte)
   references deportes(codigo)
   on update cascade,
  constraint FK_inscriptos_socios
   foreign key (numerosocio)
   references socios(numero)
   on update cascade
   on delete cascade,
  constraint CK_matricula_valores check (matricula in ('s','n'))
);

-- 4- Ingrese registros en "profesores":

 insert into profesores values('21111111','Andres Acosta','Avellaneda 111');
 insert into profesores values('22222222','Betina Bustos','Bulnes 222');
 insert into profesores values('23333333','Carlos Caseros','Colon 333');

-- 5- Ingrese registros en "deportes". Ingrese el mismo día para distintos deportes, un deporte sin día 
-- confirmado, un deporte sin profesor definido:

 insert into deportes values('basquet','lunes',null);
 insert into deportes values('futbol','lunes','23333333');
 insert into deportes values('natacion',null,'22222222');
 insert into deportes values('padle',default,'23333333');
 insert into deportes (nombre,dia) values('tenis','jueves');

-- 6- Ingrese registros en "socios":

 insert into socios values('30111111','Ana Acosta','America 111');
 insert into socios values('30222222','Bernardo Bueno','Bolivia 222');
 insert into socios values('30333333','Camila Conte','Caseros 333');
 insert into socios values('30444444','Daniel Duarte','Dinamarca 444');

-- 7- Ingrese registros en "inscriptos". Inscriba a un socio en distintos deportes, inscriba varios 
-- socios en el mismo deporte.

 insert into inscriptos values(1,3,'s');
 insert into inscriptos values(1,5,'s');
 insert into inscriptos values(2,1,'s');
 insert into inscriptos values(4,1,'n');
 insert into inscriptos values(4,4,'s');

-- 8- Realice un "join" (del tipo que sea necesario) para mostrar todos los datos del socio junto con 
-- el nombre de los deportes en los cuales está inscripto, el día que tiene que asistir y el nombre del 
-- profesor que lo instruirá.
-- 5 registros.




 select s.*,d.nombre as deporte,d.dia,p.nombre as profesor
  from socios as s
  join inscriptos as i
  on numero=i.numerosocio
  join deportes as d
  on d.codigo=i.codigodeporte
  left join profesores as p
  on d.profesor=p.documento;
-- 9- Realice la misma consulta anterior pero incluya los socios que no están inscriptos en ningún 
-- deporte.
-- 6 registros.




select s.*,d.nombre as deporte,d.dia,p.nombre as profesor
  from socios as s
  full join inscriptos as i
  on numero=i.numerosocio
  left join deportes as d
  on d.codigo=i.codigodeporte
  left join profesores as p
  on d.profesor=p.documento;
-- 10- Muestre todos los datos de los profesores, incluido el deporte que dicta y el día, incluyendo 
-- los profesores que no tienen asignado ningún deporte.
-- 4 registros.




 select p.*,d.nombre as deporte,d.dia
  from profesores as p
  left join deportes as d
  on d.profesor=p.documento;
-- 11- Muestre todos los deportes y la cantidad de inscriptos, incluyendo aquellos deportes para los 
-- cuales no hay inscriptos.
-- 5 registros.





 select d.nombre,count(i.codigodeporte) as cantidad
  from deportes as d
  left join inscriptos as i
  on d.codigo=i.codigodeporte
  group by d.nombre;  
-- 12- Muestre las restricciones de "socios".
-- 3 restricciones y 1 "foreign key" de "inscriptos" que la referencia.



 exec sp_helpconstraint socios;
-- 13- Muestre las restricciones de "deportes".
-- 3 restricciones y 1 "foreign key" de "inscriptos" que la referencia.



 exec sp_helpconstraint deportes;
-- 14- Muestre las restricciones de "profesores".
-- 2 restricciones.




 exec sp_helpconstraint profesores;
-- 15- Muestre las restricciones de "inscriptos".
-- 4 restricciones.



 exec sp_helpconstraint inscriptos;
-- -- ********************* segundo problema *********************

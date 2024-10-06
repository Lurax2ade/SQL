
 
 -------------------------------------------------------------------------------------------------------------------------------
--Clave primaria compuesta
 -------------------------------------------------------------------------------------------------------------------------------

-- Las claves primarias pueden ser simples, formadas por un solo campo o compuestas, más de un campo.

-- Recordemos que una clave primaria identifica 1 solo registro en una tabla.

-- Para un valor del campo clave existe solamente 1 registro. Los valores no se repiten ni pueden ser nulos.

-- Existe una playa de estacionamiento que almacena cada día los datos de los vehículos que ingresan en la tabla llamada "vehiculos" con los siguientes campos:

--  - patente char(6) not null,
--  - tipo char (1), 'a'= auto, 'm'=moto,
--  - horallegada datetime,
--  - horasalida datetime,

-- Necesitamos definir una clave primaria para una tabla con los datos descriptos arriba. No podemos usar solamente la patente porque un mismo auto puede ingresar más de una vez en el día a la playa; tampoco podemos usar la hora de entrada porque varios autos pueden ingresar a una misma hora.
-- Tampoco sirven los otros campos.

-- Como ningún campo, por si sólo cumple con la condición para ser clave, es decir, debe identificar un solo registro, el valor no puede repetirse, debemos usar 2 campos.

-- Definimos una clave compuesta cuando ningún campo por si solo cumple con la condición para ser clave.

-- En este ejemplo, un auto puede ingresar varias veces en un día a la playa, pero siempre será a distinta hora.

-- Usamos 2 campos como clave, la patente junto con la hora de llegada, así identificamos unívocamente cada registro.

-- Para establecer más de un campo como clave primaria usamos la siguiente sintaxis:

--  create table vehiculos(
--   patente char(6) not null,
--   tipo char(1),--'a'=auto, 'm'=moto
--   horallegada datetime,
--   horasalida datetime,
--   primary key(patente,horallegada)
--  );

-- Nombramos los campos que formarán parte de la clave separados por comas.

-- Al ingresar los registros, SQL Server controla que los valores para los campos establecidos como clave primaria no estén repetidos en la tabla; si estuviesen repetidos, muestra un mensaje y la inserción no se realiza. Lo mismo sucede si realizamos una actualización.

-- Entonces, si un solo campo no identifica unívocamente un registro podemos definir una clave primaria compuesta, es decir formada por más de un campo.


-- ********************* primer problema *********************
-- Un consultorio médico en el cual trabajan 3 médicos registra las consultas de los pacientes en una 
-- tabla llamada "consultas".
-- 1- Elimine la tabla si existe:
 if object_id('consultas') is not null
  drop table consultas;


-- 3- Un médico sólo puede atender a un paciente en una fecha y hora determianada. En una fecha y hora 
-- determinada, varios médicos atienden a distintos pacientes. Cree la tabla definiendo una clave 
-- primaria compuesta:
 create table consultas(
  fechayhora datetime not null,
  medico varchar(30) not null,
  documento char(8) not null,
  paciente varchar(30),
  obrasocial varchar(30),
  primary key(fechayhora,medico)
 );

-- 4- Ingrese varias consultas para un mismo médico en distintas horas el mismo día.


 insert into consultas
  values ('2006/11/05 8:00','Lopez','12222222','Acosta Betina','PAMI');
 insert into consultas
  values ('2006/11/05 8:30','Lopez','23333333','Fuentes Carlos','PAMI');


 insert into consultas
  values ('2006/11/05 8:00','Perez','23333333','Fuentes Carlos','PAMI');

-- 5- Ingrese varias consultas para diferentes médicos en la misma fecha y hora.


-- 6- Intente ingresar una consulta para un mismo médico en la misma hora el mismo día.



 



 


-- ********************* Segundo problema *********************


-- Un club dicta clases de distintos deportes. En una tabla llamada "inscriptos" almacena la 
-- información necesaria.
-- 1- Elimine la tabla "inscriptos" si existe:
 if object_id('inscriptos') is not null
  drop table inscriptos;


-- 3- Necesitamos una clave primaria que identifique cada registro. Un socio puede inscribirse en 
-- varios deportes en distintos años. Un socio no puede inscribirse en el mismo deporte el mismo año. 
-- Varios socios se inscriben en un mismo deporte en distintos años. Cree la tabla con una clave 
-- compuesta:
 create table inscriptos(
  documento char(8) not null, 
  nombre varchar(30),
  deporte varchar(15) not null,
  año datetime,
  matricula char(1),
  primary key(documento,deporte,año)
 );

-- 4- Inscriba a varios alumnos en el mismo deporte en el mismo año:
 insert into inscriptos
  values ('12222222','Juan Perez','tenis','2005','s');
 insert into inscriptos
  values ('23333333','Marta Garcia','tenis','2005','s');
 insert into inscriptos
  values ('34444444','Luis Perez','tenis','2005','n');

-- 5- Inscriba a un mismo alumno en varios deportes en el mismo año:
 insert into inscriptos
  values ('12222222','Juan Perez','futbol','2005','s');
 insert into inscriptos
  values ('12222222','Juan Perez','natacion','2005','s');
 insert into inscriptos
  values ('12222222','Juan Perez','basquet','2005','n');

-- 6- Ingrese un registro con el mismo documento de socio en el mismo deporte en distintos años:
 insert into inscriptos
  values ('12222222','Juan Perez','tenis','2006','s');
 insert into inscriptos
  values ('12222222','Juan Perez','tenis','2007','s');



-- 7- Intente inscribir a un socio alumno en un deporte en el cual ya esté inscripto en un año en el 
-- cual ya se haya inscripto.
 insert into inscriptos
  values ('12222222','Juan Perez','tenis','2005','s');


-- 8- Intente actualizar un registro para que la clave primaria se repita.
 update inscriptos set deporte='tenis'
  where documento='12222222' and
  deporte='futbol' and
  año='2005';


 
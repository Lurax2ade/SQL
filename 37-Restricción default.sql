
 
 -------------------------------------------------------------------------------------------------------------------------------
--	Restricción default
 -------------------------------------------------------------------------------------------------------------------------------


-- La restricción "default" especifica un valor por defecto para un campo cuando no se inserta explícitamente en un comando "insert".

-- Anteriormente, para establecer un valor por defecto para un campo empleábamos la cláusula "default" al crear la tabla, por ejemplo:

--  create table libros(
--   ...
--   autor varchar(30) default 'Desconocido',
--   ...
--  );

-- Cada vez que establecíamos un valor por defecto para un campo de una tabla, SQL Server creaba automáticamente una restricción "default" para ese campo de esa tabla.

-- Dicha restricción, a la cual no le dábamos un nombre, recibía un nombre dado por SQL Server que consiste "DF" (por default), seguido del nombre de la tabla, el nombre del campo y letras y números aleatorios.

-- Podemos agregar una restricción "default" a una tabla existente con la sintaxis básica siguiente:

--  alter table NOMBRETABLA
--  add constraint NOMBRECONSTRAINT
--  default VALORPORDEFECTO
--  for CAMPO;

-- En la sentencia siguiente agregamos una restricción "default" al campo autor de la tabla existente "libros", que almacena el valor "Desconocido" en dicho campo si no ingresamos un valor en un "insert":

--  alter table libros
--  add constraint DF_libros_autor
--  default 'Desconocido'
--  for autor;

-- Por convención, cuando demos el nombre a las restricciones "default" emplearemos un formato similar al que le da SQL Server: "DF_NOMBRETABLA_NOMBRECAMPO".

-- Solamente se permite una restricción "default" por campo y no se puede emplear junto con la propiedad "identity". Una tabla puede tener varias restricciones "default" para sus distintos campos.

-- La restricción "default" acepta valores tomados de funciones del sistema, por ejemplo, podemos establecer que el valor por defecto de un campo de tipo datetime sea "getdate()".

-- Podemos ver información referente a las restriciones de una tabla con el procedimiento almacenado "sp_helpcontraint":

--  exec sp_helpconstraint libros;

-- aparecen varias columnas con la siguiente información:

-- - constraint_type: el tipo de restricción y sobre qué campo está establecida 
--   (DEFAULT on column autor),
-- - constraint_name: el nombre de la restricción (DF_libros_autor),
-- - delete_action y update_action: no tienen valores para este tipo de restricción.
-- - status_enabled y status_for_replication: no tienen valores para este tipo 
--   de restricción.
-- - constraint_keys: el valor por defecto (Desconocido).

-- Entonces, la restricción "default" especifica un valor por defecto para un campo cuando no se inserta explícitamente en un "insert", se puede establecer uno por campo y no se puede emplear junto con la propiedad "identity".


-- ********************* primer problema *********************

-- Un comercio que tiene un stand en una feria registra en una tabla llamada "visitantes" algunos datos 
-- de las personas que visitan o compran en su stand para luego enviarle publicidad de sus productos.
-- 1- Elimine la tabla "visitantes", si existe:

if object_id('visitantes') is not null
drop table visitantes;


-- 2- Cree la tabla con la siguiente estructura:

 create table visitantes(
  numero int identity,
  nombre varchar(30),
  edad tinyint,
  domicilio varchar(30),
  ciudad varchar(20),
  montocompra decimal (6,2) not null
 );

-- 3- Defina una restricción "default" para el campo "ciudad" que almacene el valor "Cordoba" en caso 
-- de no ingresar valor para dicho campo:

alter table visitantes
add constraint DF_visitantes_ciudad
default 'Cordoba'
for ciudad;


-- 4- Defina una restricción "default" para el campo "montocompra" que almacene el valor "0" en caso de 
-- no ingresar valor para dicho campo:

alter table visitantes
add constraint DF_visitantes_montocompra
default 0
for montocompra;


-- 5- Ingrese algunos registros sin valor para los campos con restricción "default":

insert into visitantes 
values ('Lau', 23, 'Oaxaca 23', default, default);

 insert into visitantes
  values ('Susana Molina',35,'Colon 123',default,59.80);

 insert into visitantes (nombre,edad,domicilio)
  values ('Marcos Torres',29,'Carlos Paz');

 insert into visitantes
  values ('Mariana Juarez',45,'Carlos Paz',null,23.90);

-- 6- Vea cómo se almacenaron los registros:

select * from visitantes;


-- 7- Vea las restricciones creadas anteriormente.
-- aparecen dos filas, una por cada restricción.

exec sp_helpconstraint visitantes;


-- 8- Intente agregar otra restricción "default" al campo "ciudad".
-- Aparece un mensaje de error indicando que el campo ya tiene una restricción "default" y sabemos 
-- que no puede establecerse más de una restricción "default" por campo.

alter table visitantes
add constraint DF_visitantes_ciudad
default 'Cordoba'
for ciudad;


-- 9- Intente establecer una restricción "default" al campo "identity".
-- No se permite.

 alter table visitantes
 add constraint DF_visitantes_numero
 default 0
 for numero;





-- ********************* Segundo problema *********************



-- Una playa de estacionamiento almacena cada día los datos de los vehículos que ingresan en la tabla 
-- llamada "vehiculos".

-- 1- Elimine la tabla, si existe:
if object_id('vehiculos') is not null
drop table vehiculos;


-- 2- Cree la tabla:
 create table vehiculos(
  patente char(6) not null,
  tipo char(1),--'a'=auto, 'm'=moto
  horallegada datetime,
  horasalida datetime
 );

-- 3- Establezca una restricción "default" para el campo "tipo" que almacene el valor "a" en caso de no 
-- ingresarse valor para dicho campo.

alter table vehiculos
add constraint DF_vehiculos_tipo
default 'a'
for tipo;

-- 4- Ingrese un registro sin valor para el campo "tipo":

insert into vehiculos
values('BVH 457', default, default, null);

 insert into vehiculos 
 values('BVB111',default,default,null);

-- 5- Recupere los registros:

select * from vehiculos;


-- 6- Intente establecer otra restricción "default" para el campo "tipo" que almacene el valor "m" en 
-- caso de no ingresarse valor para dicho campo.
-- No lo permite porque un campo solamente admite una restricción "default" y ya tiene una.

alter table vehiculos
add constraint DF_vehiculos_tipo
default 'm'
for tipo;

-- 7- Establezca una restricción "default" para el campo "horallegada" que almacene la fecha y hora del 
-- sistema.


alter table vehiculos
add constraint DF_vehiculos_horallegada
default getdate()
for horallegada;

-- 8- Ingrese un registro sin valor para los campos de tipo datetime.

 insert into vehiculos (patente,tipo) values('CAA258','a');




-- 9- Recupere los registros:

 select * from vehiculos;



-- 10- Vea las restricciones.
-- 2 restricciones.

exec sp_helpconstraint vehiculos;


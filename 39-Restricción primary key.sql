
 
 -------------------------------------------------------------------------------------------------------------------------------
-- 	Restricción primary key
 -------------------------------------------------------------------------------------------------------------------------------


-- Hemos visto las restricciones que se aplican a los campos, "default" y "check".

-- Ahora veremos las restricciones que se aplican a las tablas, que aseguran valores únicos para cada registro.

-- Hay 2 tipos: 1) primary key y 2) unique.

-- Anteriormente, para establecer una clave primaria para una tabla empleábamos la siguiente sintaxis al crear la tabla, por ejemplo:

--  create table libros(
--   codigo int not null,
--   titulo varchar(30),
--   autor varchar(30),
--   editorial varchar(20),
--   primary key(codigo)
--  );

-- Cada vez que establecíamos la clave primaria para la tabla, SQL Server creaba automáticamente una restricción "primary key" para dicha tabla. Dicha restricción, a la cual no le dábamos un nombre, recibía un nombre dado por SQL Server que comienza con "PK" (por primary key), seguido del nombre de la tabla y una serie de letras y números aleatorios.

-- Podemos agregar una restricción "primary key" a una tabla existente con la sintaxis básica siguiente:

--  alter table NOMBRETABLA
--  add constraint NOMBRECONSTRAINT
--  primary key (CAMPO,...);

-- En el siguiente ejemplo definimos una restricción "primary key" para nuestra tabla "libros" para asegurarnos que cada libro tendrá un código diferente y único:

--  alter table libros
--  add constraint PK_libros_codigo
--  primary key(codigo);

-- Con esta restricción, si intentamos ingresar un registro con un valor para el campo "codigo" que ya existe o el valor "null", aparece un mensaje de error, porque no se permiten valores duplicados ni nulos. Igualmente, si actualizamos.

-- Por convención, cuando demos el nombre a las restricciones "primary key" seguiremos el formato "PK_NOMBRETABLA_NOMBRECAMPO".

-- Sabemos que cuando agregamos una restricción a una tabla que contiene información, SQL Server controla los datos existentes para confirmar que cumplen las exigencias de la restricción, si no los cumple, la restricción no se aplica y aparece un mensaje de error. Por ejemplo, si intentamos definir la restricción "primary key" para "libros" y hay registros con códigos repetidos o con un valor "null", la restricción no se establece.

-- Cuando establecíamos una clave primaria al definir la tabla, automáticamente SQL Server redefinía el campo como "not null"; pero al agregar una restricción "primary key", los campos que son clave primaria DEBEN haber sido definidos "not null" (o ser implícitamente "not null" si se definen identity).

-- SQL Server permite definir solamente una restricción "primary key" por tabla, que asegura la unicidad de cada registro de una tabla.

-- Si ejecutamos el procedimiento almacenado "sp_helpconstraint" junto al nombre de la tabla, podemos ver las restricciones "primary key" (y todos los tipos de restricciones) de dicha tabla.

-- Un campo con una restricción "primary key" puede tener una restricción "check".

-- Un campo "primary key" también acepta una restricción "default" (excepto si es identity), pero no tiene sentido ya que el valor por defecto solamente podrá ingresarse una vez; si intenta ingresarse cuando otro registro ya lo tiene almacenado, aparecerá un mensaje de error indicando que se intenta duplicar la clave.



-- ********************* primer problema *********************

-- Una empresa tiene registrados datos de sus empleados en una tabla llamada "empleados".
-- 1- Elimine la tabla si existe:

if object_id('empleados') is not null
drop table empleados;



-- 2- Créela con la siguiente estructura:
  create table empleados (
  documento varchar(8) not null,
  nombre varchar(30),
  seccion varchar(20)
 );

-- 3- Ingrese algunos registros, dos de ellos con el mismo número de documento:
insert into empleados
values('78459612', 'Laura', 'Sanidad');

 insert into empleados
  values ('22222222','Alberto Lopez','Sistemas');

 insert into empleados
  values ('23333333','Beatriz Garcia','Administracion');

 insert into empleados
  values ('23333333','Carlos Fuentes','Administracion');


-- 4- Intente establecer una restricción "primary key" para la tabla para que el documento no se repita 
-- ni admita valores nulos:

alter table empleados
add constraint PK_empleados_documento
primary key(documento);


-- No lo permite porque la tabla contiene datos que no cumplen con la restricción, debemos eliminar (o 
-- modificar) el registro que tiene documento duplicado:

 delete from empleados
  where nombre='Carlos Fuentes';

-- 5- Establezca la restricción "primary key" del punto 4.


 alter table empleados
 add constraint PK_empleados_documento
 primary key(documento);

-- 6- Intente actualizar un documento para que se repita.
-- No lo permite porque va contra la restricción.


 update empleados set documento='22222222'
  where documento='23333333';

-- 7-Intente establecer otra restricción "primary key" con el campo "nombre".
-- No lo permite, sólo puede haber una restricción "primary key" por tabla.

alter table empleados
add constraint PK_empleados_nombre
primary key (nombre);

-- 8- Intente ingresar un registro con valor nulo para el documento.
-- No lo permite porque la restricción no admite valores nulos.

insert into empleados values(null, 'Laura', 'Sanidad');

-- 9- Establezca una restricción "default" para que almacene "00000000" en el documento en caso de 
-- omitirlo en un "insert".

alter table empleados
add constraint DF_empleados_documento
default '00000000'
for documento;

-- 10- Ingrese un registro sin valor para el documento.

insert into empleados(nombre, seccion) values('Laura', 'Sanidad');


-- 11- Vea el registro:


select * from empleados;



-- 12- Intente ingresar otro empleado sin documento explícito.
-- No lo permite porque se duplicaría la clave.

 insert into empleados (nombre,seccion) values('Ana Fuentes','Sistemas'); 


-- 13- Vea las restricciones de la tabla empleados (2 filas):
--  exec sp_helpconstraint empleados;


exec sp_helpconstraint empleados;




-- ********************* Segundo problema *********************


-- Una empresa de remises tiene registrada la información de sus vehículos en una tabla llamada 
-- "remis".

-- 1- Elimine la tabla si existe:
if object_id('remis') is not null
drop table remis;


-- 2- Cree la tabla con la siguiente estructura:

 create table remis(
  numero tinyint identity,
  patente char(6),
  marca varchar(15),
  modelo char(4)
 );

-- 3- Ingrese algunos registros sin repetir patente:

insert into remis values('ADC123', 'Citroen C5', '2020');

 insert into remis values('ABC123','Renault 12','1990');

 insert into remis values('DEF456','Fiat Duna','1995');

-- 4- Intente definir una restricción "primary key" para el campo "patente".
-- No lo permite porque el campo no fue definido "not null".

alter table remis
add constraint PK_remis_patente
primary key(patente);

-- 5- Establezca una restricción "primary key" para el campo "numero".
-- Si bien "numero" no fue definido explícitamente "not null", no acepta valores nulos por ser 
-- "identity".

alter table remis
add constraint PK_remis_numero
primary key(numero);

-- 6- Vea la información de las restricciones (2 filas):

 exec sp_helpconstraint remis;


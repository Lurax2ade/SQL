
 -------------------------------------------------------------------------------------------------------------------------------
--Restricción check
 -------------------------------------------------------------------------------------------------------------------------------


-- La restricción "check" especifica los valores que acepta un campo, evitando que se ingresen valores inapropiados.

-- La sintaxis básica es la siguiente:

--  alter table NOMBRETABLA
--  add constraint NOMBRECONSTRAINT
--  check CONDICION;

-- Trabajamos con la tabla "libros" de una librería que tiene los siguientes campos: codigo, titulo, autor, editorial, preciomin (que indica el precio para los minoristas) y preciomay (que indica el precio para los mayoristas).

-- Los campos correspondientes a los precios (minorista y mayorista) se definen de tipo decimal(5,2), es decir, aceptan valores entre -999.99 y 999.99. Podemos controlar que no se ingresen valores negativos para dichos campos agregando una restricción "check":

--  alter table libros
--  add constraint CK_libros_precio_positivo
--  check (preciomin>=0 and preciomay>=0);

-- Este tipo de restricción verifica los datos cada vez que se ejecuta una sentencia "insert" o "update", es decir, actúa en inserciones y actualizaciones.

-- Si la tabla contiene registros que no cumplen con la restricción que se va a establecer, la restricción no se puede establecer, hasta que todos los registros cumplan con dicha restricción.

-- La condición puede hacer referencia a otros campos de la misma tabla. Por ejemplo, podemos controlar que el precio mayorista no sea mayor al precio minorista:

--  alter table libros
--  add constraint CK_libros_preciominmay
--  check (preciomay<=preciomin);

-- Por convención, cuando demos el nombre a las restricciones "check" seguiremos la misma estructura: comenzamos con "CK", seguido del nombre de la tabla, del campo y alguna palabra con la cual podamos identificar fácilmente de qué se trata la restricción, por si tenemos varias restricciones "check" para el mismo campo.

-- Un campo puede tener varias restricciones restricciones "check" y una restricción "check" puede incluir varios campos.

-- Las condiciones para restricciones "check" también pueden pueden incluir un patrón o una lista de valores. Por ejemplo establecer que cierto campo conste de 4 caracteres, 2 letras y 2 dígitos:

--  ...
--  check (CAMPO like '[A-Z][A-Z][0-9][0-9]');

-- O establecer que cierto campo asuma sólo los valores que se listan:

--  ...
--  check (CAMPO in ('lunes','miercoles','viernes'));

-- No se puede aplicar esta restricción junto con la propiedad "identity".

-- Si un campo permite valores nulos, "null" es un valor aceptado aunque no esté incluido en la condición de restricción.

-- Si intentamos establecer una restricción "check" para un campo que entra en conflicto con otra restricción "check" establecida al mismo campo, SQL Server no lo permite.

-- Pero si establecemos una restricción "check" para un campo que entra en conflicto con una restricción "default" establecida para el mismo campo, SQL Server lo permite; pero al intentar ingresar un registro, aparece un mensaje de error.


-- ********************* primer problema *********************


-- Una empresa tiene registrados datos de sus empleados en una tabla llamada "empleados".
-- 1- Elimine la tabla si existe:

if object_id('empleados') is not null
drop table empleados;


-- 2- Créela con la siguiente estructura:

 create table empleados (
  documento varchar(8),
  nombre varchar(30),
  fechanacimiento datetime,
  cantidadhijos tinyint,
  seccion varchar(20),
  sueldo decimal(6,2)
 );

-- 3- Agregue una restricción "check" para asegurarse que no se ingresen valores negativos para el 
-- sueldo:

alter table empleados
add constraint CK_empleados_sueldo_positivo
check(sueldo>0);



-- 4- Ingrese algunos registros válidos:

insert into empleados values('47856912', 'Olga', '1866/11/11', 3, 'Sistemas', 1200);

 insert into empleados values ('22222222','Alberto Lopez','1965/10/05',1,'Sistemas',1000);

 insert into empleados values ('33333333','Beatriz Garcia','1972/08/15',2,'Administracion',3000);

 insert into empleados values ('34444444','Carlos Caseres','1980/10/05',0,'Contaduría',6000);

-- 5- Intente agregar otra restricción "check" al campo sueldo para asegurar que ninguno supere el 
-- valor 5000:

-- alter table empleadosadd 
-- constraint CK_empleados_sueldo_maximo
-- check(sueldo<=5000);


-- La sentencia no se ejecuta porque hay un sueldo que no cumple la restricción.

-- 6- Elimine el registro infractor y vuelva a crear la restricción:

delete from empleados where sueldo=6000;

 alter table empleados
   add constraint CK_empleados_sueldo_maximo
   check (sueldo<=5000); 

-- 7- Establezca una restricción para controlar que la fecha de nacimiento que se ingresa no supere la 
-- fecha actual:

alter table empleados
add constraint  CK_empleados_fechanacimiento_actual
check (fechanacimiento<getdate());



-- 8- Establezca una restricción "check" para "seccion" que permita solamente los valores "Sistemas", 
-- "Administracion" y "Contaduría":


alter table empleados
add constraint CK_empleados_seccion_lista
check(seccion in('Sistemas', 'Administracion', 'Contaduría'));


-- 9- Establezca una restricción "check" para "cantidadhijos" que permita solamente valores entre 0 y 15

alter table empleados
add constraint CK_empleados_cantidadhijos_valores
check(cantidadhijos between 0 and 15);

-- 10- Vea todas las restricciones de la tabla (5 filas):
--  exec sp_helpconstraint empleados;

exec sp_helpconstraint empleados;

-- 11- Intente agregar un registro que vaya contra alguna de las restricciones al campo "sueldo".
-- Mensaje de error porque se infringe la restricción "CK_empleados_sueldo_positivo".
insert into empleados values('47856912', 'Olga', '1866/11/11', 3, 'Sistemas', 10200);

-- 12- Intente agregar un registro con fecha de nacimiento futura.
-- Mensaje de error.

insert into empleados values('47856912', 'Olga', '2025/11/11', 3, 'Sistemas', 1200);


-- 13- Intente modificar un registro colocando en "cantidadhijos" el valor "21".
-- Mensaje de error.

update empleados set cantidadhijos=21 where documento='2222222';

-- 14- Intente modificar el valor de algún registro en el campo "seccion" cambiándolo por uno que no 
-- esté incluido en la lista de permitidos.
-- Mensaje de error.

 update empleados set seccion='Recursos' where documento='22222222';

-- 15- Intente agregar una restricción al campo sección para aceptar solamente valores que comiencen 
-- con la letra "B":

-- alter table empleados
-- add constraint CK_ CK_seccion_letrainicial
-- check (seccion like '%B');


-- Note que NO se puede establecer esta restricción porque va en contra de la establecida anteriormente 
-- para el mismo campo, si lo permitiera, no podríamos ingresar ningún valor para "seccion".








-- ********************* Segundo problema *********************



-- Una playa de estacionamiento almacena los datos de los vehículos que ingresan en la tabla llamada 
-- "vehiculos".


-- 1- Elimine la tabla, si existe:

 if object_id('vehiculos') is not null
  drop table vehiculos;

-- 2- Cree la tabla:

 create table vehiculos(
  numero int identity,
  patente char(6),
  tipo char(4),
  fechahoraentrada datetime,
  fechahorasalida datetime
 );

-- 3- Ingresamos algunos registros:

insert into vehiculos values('CRG21', 'moto', '2024/12/23 8:45','2007/01/17 12:30');

 insert into vehiculos values('AIC124','auto','2007/01/17 8:05','2007/01/17 12:30');

 insert into vehiculos values('CAA258','auto','2007/01/17 8:10',null);

 insert into vehiculos values('DSE367','moto','2007/01/17 8:30','2007/01/17 18:00');


-- 4- Agregue una restricción "check" que especifique un patrón de 3 letras y 3 dígitos para "patente":


alter table vehiculos
add constraint CK_vehiculos_patente_patron
check(patente like'[A-Z][A-Z][A-Z][0-9][0-9][0-9]');



-- 5- Intente ingresar un registro con un valor inapropiado para "patente":

 insert into vehiculos values('AB1234','auto',getdate(),null);

-- No lo permite.

-- 6- Agregue una restricción "check" que especifique que el campo "tipo" acepte solamente los valores 
-- "auto" y "moto":


alter table vehiculos
add constraint CK_empleados_tipo_valores
check(tipo in('auot', 'moto'));


-- 7- Intente modificar el valor del campo "tipo" ingresando un valor inexistente en la lista de 
-- valores permitidos por la restricción establecida a dicho campo:

update vehiculos set tipo='bici' where patente='AIC124';

-- No lo permite.

-- 8- Agregue una restricción "default" para el campo "tipo" que almacene el valor "bici":

alter table vehiculos
add constraint DF_vehiculos_tipo
default 'bici'
for tipo;


-- Lo acepta. Pero, note que va en contra de la restricción "check" impuesta en el punto 6.

-- 9- Intente ingresar un registro sin valor para "tipo":
insert into vehiculos values('CRG21', default, '2024/12/23 8:45','2007/01/17 12:30');

  insert into vehiculos values('SDF134',default,null,null);

-- No lo permite porque va contra la restricción "check" del campo.

-- 10- Agregue una restricción "check" para asegurarse que la fecha de entrada a la playa no sea 
-- posterior a la fecha y hora actual:


 alter table vehiculos
   add constraint CK_vehiculos_fechahoraentrada_actual
   check (fechahoraentrada<=getdate());

-- 11- Agregue otra restricción "check" al campo "fechahoraentrada" que establezca que sus valores no 
-- sean posteriores a "fechahorasalida":
 alter table vehiculos
   add constraint CK_vehiculos_fechahoraentradasalida
   check (fechahoraentrada<=fechahorasalida);


-- 12- Intente ingresar un valor que no cumpla con la primera restricción establecida en el campo 
-- "fechahoraentrada":


 insert into vehiculos values('ABC123','auto','2007/05/05 10:10',null);
-- La inserción no se realiza.

-- 13- Intente modificar un registro para que la salida sea anterior a la entrada:

update vehiculos set fechahorasalida='2007/01/17 7:30'
where patente ='CAA258';


-- Mensaje de error.

-- 14- Vea todas las restricciones para la tabla "vehiculos":

exec sp_helpconstraint vehiculos;

-- aparecen 5 filas, 4 correspondientes a restricciones "check" y 1 a "default".

-- 15- Establezca una restricción "default" para el campo "fechahoraentrada" para que almacene la fecha 
-- actual del sistema:

alter table vehiculos
add constraint DF_vehiculos_fechahoraentrada
default getdate()
-- Remove the incomplete line of code


-- 16- Ingrese un registro sin valor para "fechahoraentrada":


 insert into vehiculos values('DFR156','moto',default,default);

-- 17- Vea todos los registros:
 select * from vehiculos;

-- 18- Vea las restricciones:
 exec sp_helpconstraint vehiculos;
-- 4 restricciones "check" y 2 "default".


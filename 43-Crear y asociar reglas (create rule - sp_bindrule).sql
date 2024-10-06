
 
 -------------------------------------------------------------------------------------------------------------------------------
--	Crear y asociar reglas (create rule - sp_bindrule)
 -------------------------------------------------------------------------------------------------------------------------------


 

-- Vimos que SQL Server ofrece varias alternativas para asegurar la integridad de datos, mediante el uso de:

--     RESTRICCIONES (constraints), que se establecen en tablas y campos y son controlados automáticamente por SQL Server. Hay 3 tipos:

--     I) DE LOS CAMPOS (hace referencia a los valores válidos para un campo determinado). Pueden ser:

--     a) DEFAULT: especifica un valor por defecto para un campo cuando no se inserta explícitamente en un comando "insert".

--     b) CHECK: especifica un rango de valores que acepta un campo, se emplea en inserciones y actualizaciones ("insert" y "update").

--     II) DE LA TABLA (asegura un identificador único para cada registro de una tabla). Hay 2 tipos:

--     a) PRIMARY KEY: identifica unívocamente cada uno de los registros; asegura que no haya valores duplicados ni valores nulos. Se crea un índice automáticamente.

--     b) UNIQUE: impide la duplicación de claves alternas (no primarias). Se permiten valores nulos. Se crea un índice automáticamente.

--     III) REFERENCIAL: lo veremos más adelante.
--     REGLAS (rules) y
--     VALORES PREDETERMINADOS (defaults).


-- Veamos las reglas.

-- Las reglas especifican los valores que se pueden ingresar en un campo, asegurando que los datos se encuentren en un intervalo de valores específico, coincidan con una lista de valores o sigan un patrón.

-- Una regla se asocia a un campo de una tabla (o a un tipo de dato definido por el usuario, tema que veremos posteriormente).

-- Un campo puede tener solamente UNA regla asociado a él.

-- Sintaxis básica es la siguiente:

--  create rule NOMBREREGLA
--  as @VARIABLE CONDICION

-- Entonces, luego de "create rule" se coloca el nombre de la regla, luego la palabra clave "as" seguido de una variable (a la cual la precede el signo arroba) y finalmente la condición.

-- Por convención, nombraremos las reglas comenzando con "RG", el nombre del campo al que se asocia y alguna palabra que haga referencia a la condición.

-- La variable puede tener cualquier nombre, pero debe estar precedido por el signo arroba (@), dicha variable será reemplazada por el valor del campo cuando se asocie.

-- La condición se refiere a los valores permitidos para inserciones y actualizaciones y puede contener cualquier expresión válida para una cláusula "where"; no puede hacer referencia a los campos de una tabla.

-- Creamos una regla para restringir los valores que se pueden ingresar en un campo "sueldo" de una tabla llamada "empleados", estableciendo un intervalo de valores:

--  create rule RG_sueldo_intervalo
--  as @sueldo between 100 and 1000

-- Luego de crear la regla, debemos asociarla a un campo ejecutando un procedimiento almacenado del sistema empleando la siguiente sintaxis básica:

--  exec sp_bindrule NOMBREREGLA, 'TABLA.CAMPO';

-- Asociamos la regla creada anteriormente al campo "sueldo" de la tabla "empleados":

--  exec sp_bindrule RG_sueldo_intervalo, 'empleados.sueldo';

-- Si intentamos agregar (o actualizar) un registro con valor para el campo "sueldo" que no esté en el intervalo de valores especificado en la regla, aparece un mensaje de error indicando que hay conflicto con la regla y la inserción (o actualización) no se realiza.

-- SQL Server NO controla los datos existentes para confirmar que cumplen con la regla como lo hace al aplicar restricciones; si no los cumple, la regla se asocia igualmente; pero al ejecutar una instrucción "insert" o "update" muestra un mensaje de error, es decir, actúa en inserciones y actualizaciones.

-- La regla debe ser compatible con el tipo de datos del campo al cual se asocia; si esto no sucede, SQL Server no lo informa al crear la regla ni al asociarla, pero al ejecutar una instrucción "insert" o "update" muestra un mensaje de error.

-- No se puede crear una regla para campos de tipo text, image, o timestamp.

-- Si asocia una nueva regla a un campo que ya tiene asociada otra regla, la nueva regla reeemplaza la asociación anterior; pero la primera regla no desaparece, solamente se deshace la asociación.

-- La sentencia "create rule" no puede combinarse con otras sentencias en un lote.

-- La función que cumple una regla es básicamente la misma que una restricción "check", las siguientes características explican algunas diferencias entre ellas:

-- - podemos definir varias restricciones "check" sobre un campo, un campo solamente puede tener una regla asociada a él;

-- - una restricción "check" se almacena con la tabla, cuando ésta se elimina, las restricciones también se borran. Las reglas son objetos diferentes e independientes de las tablas, si eliminamos una tabla, las asociaciones desaparecen, pero las reglas siguen existiendo en la base de datos;

-- - una restricción "check" puede incluir varios campos; una regla puede asociarse a distintos campos (incluso de distintas tablas);

-- - una restricción "check" puede hacer referencia a otros campos de la misma tabla, una regla no.

-- Un campo puede tener reglas asociadas a él y restricciones "check". Si hay conflicto entre ellas, SQL Server no lo informa al crearlas y/o asociarlas, pero al intentar ingresar un valor que alguna de ellas no permita, aparece un mensaje de error.

-- Con "sp_helpconstraint" podemos ver las reglas asociadas a los campos de una tabla.

-- Con "sp_help" podemos ver todos los objetos de la base de datos activa, incluyendo las reglas, en tal caso en la columna "Object_type" aparece "rule".


-- ********************* primer problema *********************


-- Una playa de estacionamiento almacena cada día los datos de los vehículos que ingresan en la tabla 
-- llamada "vehiculos".
-- 1- Elimine la tabla, si existe:

if object_id('vehiculos') is not null
drop table vehiculos;


-- 2- Elimine las siguientes reglas:

  if object_id('Rg_patente_patron') is not null
   drop rule RG_patente_patron;

 if object_id ('RG_horallegada') is not null
   drop rule RG_horallegada;

 if object_id ('RG_vehiculos_tipo') is not null
   drop rule RG_vehiculos_tipo;

 if object_id ('RG_vehiculos_tipo2') is not null
   drop rule RG_vehiculos_tipo2;

 if object_id ('RG_menor_fechaactual') is not null
   drop rule RG_menor_fechaactual;


-- 3- Cree la tabla:

 create table vehiculos(
  patente char(6) not null,
  tipo char(1),--'a'=auto, 'm'=moto
  horallegada datetime not null,
  horasalida datetime
 );

-- 4- Ingrese algunos registros:


 insert into vehiculos values ('AAA111','a','1990-02-01 08:10',null);
 insert into vehiculos values ('BCD222','m','1990-02-01 08:10','1990-02-01 10:10');
 insert into vehiculos values ('BCD222','m','1990-02-01 12:00',null);
 insert into vehiculos values ('CC1234','a','1990-02-01 12:00',null);

-- 5- Cree una regla para restringir los valores que se pueden ingresar en un campo "patente" (3 letras 
-- seguidas de 3 dígitos):

-- create rule RG_vehiculos_patente
-- as@patente like '[A-Z][A-Z][A-Z][0-9][0-9][0-9]';

-- 6- Ejecute el procedimiento almacenado del sistema "sp_help" para ver que la regla creada 
-- anteriormente existe:

exec sp_help;

-- 7- Ejecute el procedimiento almacenado del sistema "sp_helpconstraint" para ver que la regla creada 
-- anteriormente no está asociada aún a ningún campo de la tabla "vehiculos".

exec sp_helpconstraint vehiculos;


-- 8-  Asocie la regla al campo "patente":

exec sp_bindrule RG_patente_patron, 'vehiculos.patente';

-- Note que hay una patente que no cumple la regla, SQL Server NO controla los datos existentes, pero 
-- si controla las inserciones y actualizaciones:

 select * from empleados;

-- 9- Intente ingresar un registro con valor para el campo "patente" que no cumpla con la regla.
-- aparece un mensaje de error indicando que hay conflicto con la regla y la inserción no se realiza.

 insert into vehiculos values ('FGHIJK','a','1990-02-01 18:00',null);


-- 10- Cree otra regla que controle los valores para el campo "tipo" para que solamente puedan 
-- ingresarse los caracteres "a" y "m".

-- create rule RG_vehiculos_tipo
-- as @tipo in ('a', 'm');

-- 11- Asocie la regla al campo "tipo".

exec sp_bindrule RG_vehiculos_tipo, 'vehiculo.tipo';

-- 12- Intente actualizar un registro cambiando el valor de "tipo" a un valor que no cumpla con la 
-- regla anterior.
-- No lo permite.

update vehiculos set tipo='c' where patente='AAA111';

-- 13- Cree otra regla llamada "RG_vehiculos_tipo2" que controle los valores para el campo "tipo" para 
-- que solamente puedan ingresarse los caracteres "a", "c" y "m".


-- create rule RG_vehiculos_tipo2
-- as@tipo in ('a', 'c', 'm');


-- 14- Si la asociamos a un campo que ya tiene asociada otra regla, la nueva regla reeemplaza la 
-- asociación anterior. Asocie la regla creada en el punto anterior al campo "tipo".

exec sp_bindrule RG_vehiculos_tipo2, 'vehiculos.tipo2';

-- 15- Actualice el registro que no pudo actualizar en el punto 12:

 update vehiculos set tipo='c' where patente='AAA111';


-- 16- Cree una regla que permita fechas menores o iguales a la actual.

-- create rule RG_menor_fechaactual
-- as @value<=getdate();



-- 17- Asocie la regla anterior a los campos "horallegada" y "horasalida":

 exec sp_bindrule RG_menor_fechaactual, 'vehiculos.horallegada';
 exec sp_bindrule RG_menor_fechaactual, 'vehiculos.horasalida';

-- 18- Ingrese un registro en el cual la hora de entrada sea posterior a la hora de salida:

--  insert into vehiculos values ('NOP555','a','1990-02-01 10:10','1990-02-01 08:30');


 insert into vehiculos values ('NOP555','a','1990-02-01 10:10','1990-02-01 08:30');


-- 19- Intente establecer una restricción "check" que asegure que la fecha y hora de llegada a la playa 
-- no sea posterior a la fecha y hora de salida:


alter table vehiculos
add constraint CK_vehiculos_llegada_salida
check(horallegada<=horasalida);



-- No lo permite porque hay un registro que no cumple la restricción.

-- 20- Elimine dicho registro:

 delete from vehiculos where patente='NOP555';

-- 21- Establezca la restricción "check" que no pudo establecer en el punto 19:

 alter table vehiculos
 add constraint CK_vehiculos_llegada_salida
 check(horallegada<=horasalida);

-- 22- Cree una restricción "default" que almacene el valor "b" en el campo "tipo":

alter table vehiculos
add constraint DF_vehiculos_tipo
default 'b'
for tipo;


-- Note que esta restricción va contra la regla asociada al campo "tipo" que solamente permite los 
-- valores "a", "c" y "m". SQL Server no informa el conflicto hasta que no intenta ingresar el valor 
-- por defecto.

-- 23- Intente ingresar un registro con el valor por defecto para el campo "tipo":

 insert into vehiculos values ('STU456',default,'1990-02-01 10:10','1990-02-01 15:30');

--  insert into vehiculos values ('STU456',default,'1990-02-01 10:10','1990-02-01 15:30');
-- No lo permite porque va contra la regla asociada al campo "tipo".

-- 24- Vea las reglas asociadas a "empleados" y las restricciones aplicadas a la misma tabla ejecutando 
-- "sp_helpconstraint".
-- Muestra 1 restricción "check", 1 restricción "default" y 4 reglas asociadas.

 exec sp_helpconstraint vehiculos;









-- ********************* segundo problema ***************

 
 -------------------------------------------------------------------------------------------------------------------------------
--	Valores predeterminados (create default)
 -------------------------------------------------------------------------------------------------------------------------------

-- Hemos visto que para mantener la integridad declarativa se emplean restricciones, reglas (que hemos estudiado en secciones anteriores) y valores predeterminados.

-- Veamos los valores predeterminados.

-- Los valores predeterminados se asocian con uno o varios campos (o tipos de datos definidos por el usuario); se definen una sola vez y se pueden usar muchas veces.

-- Si no se coloca un valor cuando se ingresan datos, el valor predeterminado especifica el valor del campo al que está asociado.

-- Sintaxis básica:

--  create default NOMBREVALORPREDETERMINADO
--   as VALORPREDETERMINADO;

-- "VALORPREDETERMINADO" no puede hacer referencia a campos de una tabla (u otros objetos) y debe ser compatible con el tipo de datos y longitud del campo al cual se asocia; si esto no sucede, SQL Server no lo informa al crear el valor predeterminado ni al asociarlo, pero al ejecutar una instrucción "insert" muestra un mensaje de error.

-- En el siguiente ejemplo creamos un valor predeterminado llamado "VP_datodesconocido" con el valor "Desconocido":

--  create default VP_datodesconocido
--   as 'Desconocido'

-- Luego de crear un valor predeterminado, debemos asociarlo a un campo (o a un tipo de datos definido por el usuario) ejecutando el procedimiento almacenado del sistema "sp_bindefault":

--  exec sp_bindefault NOMBRE, 'NOMBRETABLA.CAMPO';

-- La siguiente sentencia asocia el valor predeterminado creado anteriormente al campo "domicilio" de la tabla "empleados":

--  exec sp_bindefault VP_datodesconocido, 'empleados.domicilio';

-- Podemos asociar un valor predeterminado a varios campos. Asociamos el valor predeterminado "VP_datodesconocido" al campo "barrio" de la tabla "empleados":

--  exec sp_bindefault VP_datodesconocido, 'empleados.barrio';

-- La función que cumple un valor predeterminado es básicamente la misma que una restricción "default", las siguientes características explican algunas semejanzas y diferencias entre ellas:

-- - un campo solamente puede tener definida UNA restricción "default", un campo solamente puede tener UN valor predeterminado asociado a él,

-- - una restricción "default" se almacena con la tabla, cuando ésta se elimina, las restricciones también. Los valores predeterminados son objetos diferentes e independientes de las tablas, si eliminamos una tabla, las asociaciones desaparecen, pero los valores predeterminados siguen existiendo en la base de datos.

-- - una restricción "default" se establece para un solo campo; un valor predeterminado puede asociarse a distintos campos (inclusive, de diferentes tablas).

-- - una restricción "default" no puede establecerse sobre un campo "identity", tampoco un valor predeterminado.

-- No se puede asociar un valor predeterminado a un campo que tiene una restricción "default".

-- Un campo con un valor predeterminado asociado puede tener reglas asociadas a él y restricciones "check". Si hay conflicto entre ellas, SQL Server no lo informa al crearlas y/o asociarlas, pero al intentar ingresar un valor que alguna de ellas no permita, aparece un mensaje de error.

-- La sentencia "create default" no puede combinarse con otra sentencia en un mismo lote.

-- Si asocia a un campo que ya tiene asociado un valor predeterminado otro valor predeterminado, la nueva asociación reemplaza a la anterior.

-- Veamos otros ejemplos.
-- Creamos un valor predeterminado que inserta el valor "0" en un campo de tipo numérico:

--  create default VP_cero
--   as 0;

-- En el siguiente creamos un valor predeterminado que inserta ceros con el formato válido para un número de teléfono:

--  create default VP_telefono
--  as '(0000)0-000000';

-- Con "sp_helpconstraint" podemos ver los valores predeterminados asociados a los campos de una tabla.

-- Con "sp_help" podemos ver todos los objetos de la base de datos activa, incluyendo los valores predeterminados, en tal caso en la columna "Object_type" aparece "default".

-- ********************* primer problema *********************


-- Una empresa registra los datos de sus clientes en una tabla llamada "clientes".
-- -- 1- Elimine la tabla si existe:
--  if object_id ('clientes') is not null
--   drop table clientes;

-- 2- Recuerde que si elimina una tabla, las asociaciones de reglas y valores predeterminados de sus 
-- campos desaparecen, pero las reglas y valores predeterminados siguen existiendo. Si intenta crear 
-- una regla o un valor predeterminado con igual nombre que uno existente, aparecerá un mensaje 
-- indicándolo, por ello, debe eliminarlos (si existen) para poder crearlos nuevamente:

--  if object_id ('VP_legajo_patron') is not null
--    drop default VP_legajo_patron;
--  if object_id ('RG_legajo_patron') is not null
--    drop rule RG_legajo_patron;
--  if object_id ('RG_legajo') is not null
--    drop rule RG_legajo;
--  if object_id ('VP_datodesconocido') is not null
--    drop default VP_datodesconocido;
-- --  if object_id ('VP_fechaactual') is not null
-- --    drop default VP_fechaactual;

-- 3- Cree la tabla:
--  create table clientes(
--   legajo char(4),
--   nombre varchar(30),
--   domicilio varchar(30),
--   ciudad varchar(15),
--   provincia varchar(20) default 'Cordoba',
--   fechaingreso datetime
--  );

-- 4- Cree una regla para establecer un patrón para los valores que se ingresen en el campo "legajo" (2 
-- letras seguido de 2 cifras) llamada "RG_legajo_patron":

-- create rule RG_legajo_patron
--  as @valor like '[A-Z][A-Z][0-9][0-9]';


-- 5- Asocie la regla al campo "legajo".
exec sp_bindrule RGlegajo_patron, 'clientes.legajo';


-- 6- Cree un valor predeterminado para el campo "legajo" ('AA00') llamado "VP_legajo_patron".

-- create default VP_legajo:RGlegajo_patron
-- as 'AA00';

-- 7- Asócielo al campo "legajo".
-- Recuerde que un campo puede tener un valor predeterminado y reglas asociados.

exec sp_bindefault VP_legajo_patron, 'clientes.legajo';


-- 8- Cree un valor predeterminado con la cadena "??" llamado "VP_datodesconocido".

-- create default VP_datodesconocido
-- as'??';



-- 10- Asócielo al campo "ciudad".
-- Recuerde que un valor predeterminado puede asociarse a varios campos.

 exec sp_bindefault VP_datodesconocido,'clientes.domicilio';


-- 9- Asócielo al campo "domicilio".
-- 11- Ingrese un registro con valores por defecto para los campos "domicilio" y "ciudad" y vea qué 
-- almacenaron.
 insert into clientes values('GF12','Ana Perez',default,default,'Cordoba','2001-10-10');
 select * from clientes;
-- 12- Intente asociar el valor predeterminado "VP_datodesconocido" al campo "provincia".
-- No se puede porque dicho campo tiene una restricción "default".


 exec sp_bindefault VP_datodesconocido,'clientes.provincia';

-- 13- Cree un valor predeterminado con la fecha actual llamado "VP_fechaactual".

--  create default VP_fechaactual
--   as getdate();
-- 14- Asócielo al campo "fechaingreso".

 exec sp_bindefault VP_fechaactual,'clientes.fechaingreso';

-- 15- Ingrese algunos registros para ver cómo se almacenan los valores para los cuales no se insertan 
-- datos.exec sp_bindefault VP_datodesconocido,'clientes.ciudad';

 insert into clientes default values;
 select * from clientes;

-- 16- Asocie el valor predeterminado "VP_datodesconocido" al campo "fechaingreso".
-- Note que se asoció un valor predeterminado de tipo caracter a un campo de tipo "datetime"; SQL 
-- Server lo permite, pero al intentar ingresar el valor aparece un mensaje de error.
 exec sp_bindefault VP_datodesconocido,'clientes.fechaingreso';

-- 17- Ingrese un registro con valores por defecto.
-- No lo permite porque son de distintos tipos.
 insert into clientes default values;

-- 18- Cree una regla que entre en conflicto con el valor predeterminado "VP_legajo_patron".

--  create rule RG_legajo
--   as @valor like 'B%';
-- 19- Asocie la regla al campo "legajo".
-- Note que la regla especifica que el campo "legajo" debe comenzar con la letra "B", pero el valor 
-- predeterminado tiene el valor "AA00"; SQL Server realiza la asociación, pero al intentar ingresar el 
-- valor predeterminado, no puede hacerlo y muestra un mensaje de error.
 exec sp_bindrule RG_legajo,'clientes.legajo';

-- 20- Intente ingresar un registro con el valor "default" para el campo "legajo".
-- No lo permite porque al intentar ingresar el valor por defecto establecido con el valor 
-- predeterminado entra en conflicto con la regla "RG_legajo".

 insert into clientes values (default,'Luis Garcia','Colon 876','Cordoba','Cordoba','2001-10-10');





-- ********************* segundo problema *********************

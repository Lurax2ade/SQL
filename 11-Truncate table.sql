
 
 -------------------------------------------------------------------------------------------------------------------------------
-- 			Truncate table
 -------------------------------------------------------------------------------------------------------------------------------

--  Aprendimos que para borrar todos los registro de una tabla se usa "delete" sin condición "where".
--  También podemos eliminar todos los registros de una tabla con "truncate table".
--  Por ejemplo, queremos vaciar la tabla "libros", usamos:
 
--   truncate table libros;
 
--  La sentencia "truncate table" vacía la tabla (elimina todos los registros) y conserva la estructura de la tabla.
 
--  La diferencia con "drop table" es que esta sentencia borra la tabla, "truncate table" la vacía.
 
--  La diferencia con "delete" es la velocidad, es más rápido "truncate table" que "delete" (se nota cuando la cantidad de registros es muy grande) ya que éste borra los registros uno a uno.
 
--  Otra diferencia es la siguiente: cuando la tabla tiene un campo "identity", si borramos todos los registros con "delete" y luego ingresamos un registro, al cargarse el valor en el campo de identidad, continúa con la secuencia teniendo en cuenta el valor mayor que se había guardado; si usamos "truncate table" para borrar todos los registros, al ingresar otra vez un registro, la secuencia del campo de identidad vuelve a iniciarse en 1.
 
--  Por ejemplo, tenemos la tabla "libros" con el campo "codigo" definido "identity", y el valor más alto de ese campo es "2", si borramos todos los registros con "delete" y luego ingresamos un registro, éste guardará el valor de código "3"; si en cambio, vaciamos la tabla con "truncate table", al ingresar un nuevo registro el valor del código se iniciará en 1 nuevamente.





--********************************** Primer problema **********************************


-- Un instituto de enseñanza almacena los datos de sus estudiantes en una tabla llamada "alumnos".

-- 1- Elimine la tabla "alumnos" si existe:

if object_id('alumnos') is not null
drop table alumnos;


-- 2- Cree la tabla con la siguiente estructura:

 create table alumnos(
  legajo int identity,
  documento varchar(8),
  nombre varchar(30),
  domicilio varchar(30)
 );

-- 3- Ingrese los siguientes registros y muéstrelos para ver la secuencia de códigos:

 insert into alumnos (documento,nombre,domicilio)
  values('22345345','Perez Mariana','Colon 234');

 insert into alumnos (documento,nombre,domicilio)
  values('23545345','Morales Marcos','Avellaneda 348');

 insert into alumnos (documento,nombre,domicilio)
  values('24356345','Gonzalez Analia','Caseros 444');

 insert into alumnos (documento,nombre,domicilio)
  values('25666777','Torres Ramiro','Dinamarca 209');

-- 4- Elimine todos los registros con "delete".

delete from alumnos;

-- 5- Ingrese los siguientes registros y selecciónelos para ver cómo SQL Server generó los códigos:

 insert into alumnos (documento,nombre,domicilio)
  values('22345345','Perez Mariana','Colon 234');

 insert into alumnos (documento,nombre,domicilio)
  values('23545345','Morales Marcos','Avellaneda 348');

 insert into alumnos (documento,nombre,domicilio)
  values('24356345','Gonzalez Analia','Caseros 444');

 insert into alumnos (documento,nombre,domicilio)
  values('25666777','Torres Ramiro','Dinamarca 209');

 select * from alumnos;

-- 6- Elimine todos los registros con "truncate table".

truncate table alumnos;

-- 7- Ingrese los siguientes registros y muestre todos los registros para ver que SQL Server reinició 
-- la secuencia del campo "identity":

 insert into alumnos (documento,nombre,domicilio)
  values('22345345','Perez Mariana','Colon 234');

 insert into alumnos (documento,nombre,domicilio)
  values('23545345','Morales Marcos','Avellaneda 348');

 insert into alumnos (documento,nombre,domicilio)
  values('24356345','Gonzalez Analia','Caseros 444');

 insert into alumnos (documento,nombre,domicilio)
  values('25666777','Torres Ramiro','Dinamarca 209');

 select * from alumnos;







-- ********************* Segundo problema *********************



-- Un comercio que vende artículos de computación registra los datos de sus artículos en una tabla con 
-- ese nombre.

-- 1- Elimine "articulos", si existe:
if object_id('articulos') is not null
drop table articulos;


-- 2- Cree la tabla, con la siguiente estructura:

 create table articulos(
  codigo integer identity,
  nombre varchar(20),
  descripcion varchar(30),
  precio float
 );

-- 3- Ingrese algunos registros:

 insert into articulos (nombre, descripcion, precio)
  values ('impresora','Epson Stylus C45',400.80);

 insert into articulos (nombre, descripcion, precio)
  values ('impresora','Epson Stylus C85',500);

-- 4- Elimine todos los registros con "truncate table".

truncate table articulos;

-- 5- Ingrese algunos registros y muéstrelos para ver que la secuencia de códigos se reinicia:

 insert into articulos (nombre, descripcion, precio)
  values ('monitor','Samsung 14',800);

 insert into articulos (nombre, descripcion, precio)
  values ('teclado','ingles Biswal',100);

 insert into articulos (nombre, descripcion, precio)
  values ('teclado','español Biswal',90);

 select * from articulos;

-- 6- Elimine todos los registros con "delete".

delete from articulos;

-- 7- Ingrese algunos registros y muéstrelos para ver que la secuencia de códigos continua:

 insert into articulos (nombre, descripcion, precio)
  values ('monitor','Samsung 14',800);

 insert into articulos (nombre, descripcion, precio)
  values ('teclado','ingles Biswal',100);

 insert into articulos (nombre, descripcion, precio)
  values ('teclado','español Biswal',90);

 select * from articulos;


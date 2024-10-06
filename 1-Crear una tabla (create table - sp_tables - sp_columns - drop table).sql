


 
 
 -------------------------------------------------------------------------------------------------------------------------------
--  Crear una tabla (create table - sp_tables - sp_columns - drop table)
 -------------------------------------------------------------------------------------------------------------------------------


--  Una base de datos almacena  información (datos) en tablas (estrutura de datos en columnas/campo/atributo y filas/registro).

-- Cada registro contiene un dato por cada columna de la tabla.

-- Cada campo (columna) debe tener un nombre y definir el tipo de dato que almacenará 

-- Las tablas forman parte de una base de datos.

-- Nosotros trabajaremos con la base de datos llamada wi121505_bd1 (este nombre se debe a que la empresa de hosting 
--es la que lo define), que ya he creado en el servidor.

-- Para ver las tablas existentes creadas por los usuarios en una base de datos usamos el procedimiento almacenado 
--"sp_tables @table_owner='dbo';":

-- exec sp_tables @table_owner='dbo';

-- El parámetro @table_owner='dbo' indica que solo muestre las tablas de usuarios y no las que crea el SQL Server para administración interna.

-- Finalizamos cada comando con un punto y coma.

-- Al crear una tabla debemos resolver qué campos (columnas) tendrá y que tipo de datos almacenarán cada uno de ellos, es decir, su estructura.

-- La sintaxis básica y general para crear una tabla es la siguiente:

--  create table NOMBRETABLA(
--   NOMBRECAMPO1 TIPODEDATO,
--   ...
--   NOMBRECAMPON TIPODEDATO
--  );

-- La tabla debe ser definida con un nombre que la identifique y con el cual accederemos a ella.

-- Creamos una tabla llamada "usuarios" y entre paréntesis definimos los campos y sus tipos:

--  create table usuarios (
--   nombre varchar(30),
--   clave varchar(10)
--  );

-- Cada campo con su tipo debe separarse con comas de los siguientes, excepto el último.

-- Cuando se crea una tabla debemos indicar su nombre y definir al menos un campo con su tipo de dato. 
--En esta tabla "usuarios" definimos 2 campos:

--     nombre: que contendrá una cadena de caracteres de 30 caracteres de longitud, que almacenará el nombre de usuario y
--     clave: otra cadena de caracteres de 10 de longitud, que guardará la clave de cada usuario.

-- Cada usuario ocupará un registro de esta tabla, con su respectivo nombre y clave.

-- Para nombres de tablas, se puede utilizar cualquier caracter permitido para nombres de directorios, el primero debe ser un caracter alfabético y no puede contener espacios. La longitud máxima es de 128 caracteres.
 






-- 1---:********************************** Primer problema **********************************

-- Necesita almacenar los datos de sus amigos en una tabla. Los datos que guardará serán: apellido, 
-- nombre, domicilio y teléfono.

-- 1- Elimine la tabla "agenda" si existe:

if object_id('agenda') is not null
drop table agenda;



-- 2- Intente crear una tabla llamada "/agenda":

create table /agenda(
apellido varchar(30),
nombre varchar (20),
domicilio varchar(30),
telefono varchar (11)
);


-- aparece un mensaje de error porque usamos un caracter inválido ("/") para el nombre.

-- 3- Cree una tabla llamada "agenda", debe tener los siguientes campos: apellido, varchar(30); nombre, 
-- varchar(20); domicilio, varchar (30) y telefono, varchar(11):

create table agenda(
apellido varchar(30),
nombre varchar (20),
domicilio varchar(30),
telefono varchar (11)
);



-- 4- Intente crearla nuevamente. Aparece mensaje de error.
create table agenda(
  apellido varchar(30),
  nombre varchar(20),
  domicilio varchar(30),
  telefono varchar(11)
 );

-- 5- Visualice las tablas existentes (exec sp_tables @table_owner='dbo').

exec sp_tables @table_owner='dbo';

-- 6- Visualice la estructura de la tabla "agenda" (sp_columns).

exec sp_columns agenda;

-- 7- Elimine la tabla.


-- 8- Intente eliminar la tabla, sin controlar si existe. Debe aparecer un mensaje de error.

 drop table agenda;
 





-- ********************* Segundo problema *********************

-- Necesita almacenar información referente a los libros de su biblioteca personal. Los datos que 
-- guardará serán: título del libro, nombre del autor y nombre de la editorial.

-- 1- Elimine la tabla "libros", si existe:

if object_id('libros') is not null
drop table libros;



-- 2- Verifique que la tabla "libros" no existe en la base de datos activa (exec sp_tables @table_owner='dbo').

exec sp_tables @table_owner='dbo';

-- 3- Cree una tabla llamada "libros". Debe definirse con los siguientes campos: titulo, varchar(20); 
-- autor, varchar(30) y editorial, varchar(15).

create table libros(
  titulo varchar(20),
  autor varchar(30),
  editorial varchar(15)
);

-- 4- Intente crearla nuevamente. Aparece mensaje de error.

create table libros(
  titulo varchar(20),
  autor varchar(30),
  editorial varchar(15)
);

-- 5- Visualice las tablas existentes.

exec sp_tables @table_owner='dbo';

-- 6- Visualice la estructura de la tabla "libros".

exec sp_columns libros;

-- 7- Elimine la tabla.

drop table libros;

-- 8- Intente eliminar la tabla nuevamente.

drop table libros;

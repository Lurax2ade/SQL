
 
 -------------------------------------------------------------------------------------------------------------------------------
-- 		Clave primaria 
 -------------------------------------------------------------------------------------------------------------------------------


-- Una clave primaria es un campo (o varios) que identifica un solo registro (fila) en una tabla.
-- Para un valor del campo clave existe solamente un registro.

-- Veamos un ejemplo, si tenemos una tabla con datos de personas, el número de documento puede establecerse como clave primaria, es un valor que no se repite; puede haber personas con igual apellido y nombre, incluso el mismo domicilio (padre e hijo por ejemplo), pero su documento será siempre distinto.

-- Si tenemos la tabla "usuarios", el nombre de cada usuario puede establecerse como clave primaria, es un valor que no se repite; puede haber usuarios con igual clave, pero su nombre de usuario será siempre diferente.

-- Podemos establecer que un campo sea clave primaria al momento de crear la tabla o luego que ha sido creada. Vamos a aprender a establecerla al crear la tabla. Hay 2 maneras de hacerlo, por ahora veremos la sintaxis más sencilla.

-- Tenemos nuestra tabla "usuarios" definida con 2 campos ("nombre" y "clave").
-- La sintaxis básica y general es la siguiente:

--  create table NOMBRETABLA(
--   CAMPO TIPO,
--   ...
--   primary key (NOMBRECAMPO)
--  );

-- En el siguiente ejemplo definimos una clave primaria, para nuestra tabla "usuarios" para asegurarnos que cada usuario tendrá un nombre diferente y único:

--  create table usuarios(
--   nombre varchar(20),
--   clave varchar(10),
--   primary key(nombre)
--  );

-- Lo que hacemos agregar luego de la definición de cada campo, "primary key" y entre paréntesis, el nombre del campo que será clave primaria.

-- Una tabla sólo puede tener una clave primaria. Cualquier campo (de cualquier tipo) puede ser clave primaria, debe cumplir como requisito, que sus valores no se repitan ni sean nulos. Por ello, al definir un campo como clave primaria, automáticamente SQL Server lo convierte a "not null".

-- Luego de haber establecido un campo como clave primaria, al ingresar los registros, SQL Server controla que los valores para el campo establecido como clave primaria no estén repetidos en la tabla; si estuviesen repetidos, muestra un mensaje y la inserción no se realiza. Es decir, si en nuestra tabla "usuarios" ya existe un usuario con nombre "juanperez" e intentamos ingresar un nuevo usuario con nombre "juanperez", aparece un mensaje y la instrucción "insert" no se ejecuta.

-- Igualmente, si realizamos una actualización, SQL Server controla que los valores para el campo establecido como clave primaria no estén repetidos en la tabla, si lo estuviese, aparece un mensaje indicando que se viola la clave primaria y la actualización no se realiza.
-- Servidor de SQL Server instalado en forma local.

-- Ingresemos el siguiente lote de comandos en el SQL Server Management Studio:

-- if object_id('usuarios') is not null
--   drop table usuarios;

-- create table usuarios(
--   nombre varchar(20),
--   clave varchar(10),
--   primary key(nombre)
-- );

-- go

-- exec sp_columns usuarios;

-- insert into usuarios (nombre, clave)
--   values ('juanperez','Boca');
-- insert into usuarios (nombre, clave)
--   values ('raulgarcia','River');

-- --  Intentamos ingresar un valor de clave primaria existente (genera error):
-- insert into usuarios (nombre, clave)
--   values ('juanperez','payaso');

-- -- Intentamos ingresar el valor "null" en el campo clave primaria (genera error):
-- insert into usuarios (nombre, clave)
--   values (null,'payaso');

-- -- Intentemos actualizar el nombre de un usuario colocando un nombre existente (genera error):
-- update usuarios set nombre='juanperez'
--   where nombre='raulgarcia';







--********************************** Primer problema **********************************



-- Trabaje con la tabla "libros" de una librería.

-- 1- Elimine la tabla si existe:
if object_id('libros') is not null
drop table libros;


-- 2- Créela con los siguientes campos, estableciendo como clave primaria el campo "codigo":

create table libros(
  codigo int not null,
  titulo varchar(40) not null,
  autor varchar(20),
  editorial varchar(15),
  primary key (codigo)
);


-- 3- Ingrese los siguientes registros:

 insert into libros (codigo,titulo,autor,editorial)
  values (1,'El aleph','Borges','Emece');

 insert into libros (codigo,titulo,autor,editorial)
  values (2,'Martin Fierro','Jose Hernandez','Planeta');

 insert into libros (codigo,titulo,autor,editorial)
  values (3,'Aprenda PHP','Mario Molina','Nuevo Siglo');

-- 4- Ingrese un registro con código repetido (aparece un mensaje de error)

 insert into libros (codigo,titulo,autor,editorial)
  values (2,'Alicia en el pais de las maravillas','Lewis Carroll','Planeta');

-- 5- Intente ingresar el valor "null" en el campo "codigo"

 insert into libros (codigo,titulo,autor,editorial)
  values (null,'Alicia en el pais de las maravillas','Lewis Carroll','Planeta');


-- 6- Intente actualizar el código del libro "Martin Fierro" a "1" (mensaje de error)

update libros set codigo=1
where titulo='Martin Fierro';








-- ********************* Segundo problema *********************



-- Un instituto de enseñanza almacena los datos de sus estudiantes en una tabla llamada "alumnos".

-- 1- Elimine la tabla "alumnos" si existe:
if object:id('alumnos') is not null
drop table alumnos;


-- 2- Cree la tabla con la siguiente estructura intentando establecer 2 campos como clave primaria, el 
-- campo "documento" y "legajo" (no lo permite):

 create table alumnos(
  legajo varchar(4) not null,
  documento varchar(8),
  nombre varchar(30),
  domicilio varchar(30),
  primary key(documento),
  primary key(legajo)
 );

-- 3- Cree la tabla estableciendo como clave primaria el campo "documento":

 create table alumnos(
  legajo varchar(4) not null,
  documento varchar(8),
  nombre varchar(30),
  domicilio varchar(30),
  primary key(documento)
 );

-- 4- Verifique que el campo "documento" no admite valores nulos:

exec sp_columns alumnos;


-- 5- Ingrese los siguientes registros:
 insert into alumnos (legajo,documento,nombre,domicilio)
  values('A233','22345345','Perez Mariana','Colon 234');

 insert into alumnos (legajo,documento,nombre,domicilio)
  values('A567','23545345','Morales Marcos','Avellaneda 348');

-- 6- Intente ingresar un alumno con número de documento existente (no lo permite)

 insert into alumnos (legajo,documento,nombre,domicilio)
  values('A642','23545345','Gonzalez Analia','Caseros 444');

-- 7- Intente ingresar un alumno con documento nulo (no lo permite)


 insert into alumnos (legajo,documento,nombre,domicilio)
  values('A685',null,'Miranda Carmen','Uspallata 999');

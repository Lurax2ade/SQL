
 
 -------------------------------------------------------------------------------------------------------------------------------
-- 		Otras características del atributo Identity
 -------------------------------------------------------------------------------------------------------------------------------

-- El atributo "identity" permite indicar el valor de inicio de la secuencia y el incremento, para ello usamos la siguiente sintaxis:

--  create table libros(
--   codigo int identity(100,2),
--   titulo varchar(20),
--   autor varchar(30),
--   precio float
--  );

-- Los valores comenzarán en "100" y se incrementarán de 2 en 2; es decir, el primer registro ingresado tendrá el valor "100", los siguientes "102", "104", "106", etc.

-- La función "ident_seed()" retorna el valor de inicio del campo "identity" de la tabla que nombramos:

--  select ident_seed('libros');

-- La función "ident_incr()" retorna el valor de incremento del campo "identity" de la tabla nombrada:

--  select ident_incr('libros');

-- Hemos visto que en un campo declarado "identity" no puede ingresarse explícitamente un valor.
-- Para permitir ingresar un valor en un campo de identidad se debe activar la opción "identity_insert":

--  set identity_insert libros on;

-- Es decir, podemos ingresar valor en un campo "identity" seteando la opción "identity_insert" en "on".

-- Cuando "identity_insert" está en ON, las instrucciones "insert" deben explicitar un valor:

--  insert into libros (codigo,titulo)
--  values (5,'Alicia en el pais de las maravillas');

-- Si no se coloca un valor para el campo de identidad, la sentencia no se ejecuta y aparece un mensaje de error:

--  insert into libros (titulo,autor, editorial)
--  values ('Matematica estas ahi','Paenza','Paidos');

-- El atributo "identity" no implica unicidad, es decir, permite repetición de valores; por ello hay que tener cuidado al explicitar un valor porque se puede ingresar un valor repetido.

-- Para desactivar la opción "identity_insert" tipeamos:

--  set identity_insert libros off;






--********************************** Primer problema **********************************

-- Una farmacia guarda información referente a sus medicamentos en una tabla llamada "medicamentos".

-- 1- Elimine la tabla,si existe:

if object_id('medicamentos') is not null
drop table medicamentos;

-- 2- Cree la tabla con un campo "codigo" que genere valores secuenciales automáticamente comenzando en 
-- 10 e incrementándose en 1:

create table medicamentos(
  codigo integer identity(10,1),
  nombre varchar(20) not null,
  laboratorio varchar(20),
  precio float,
  cantidad integer
);


-- 3- Ingrese los siguientes registros:

insert into medicamentos(nombre, laboratorio, precio, cantidad)
values('Sertal','Roche',5.2,100);

insert into medicamentos (nombre, laboratorio, precio, cantidad)
values('Buscapina','Roche',4.10,200);

insert into medicamentos (nombre, laboratorio, precio, cantidad)
values('Amoxidal 500','Bayer',15.60,100);

-- 4- Verifique que SQL Server generó valores para el campo "código" de modo automático:

select* from medicamentos;


-- 5- Intente ingresar un registro con un valor para el campo "codigo".


 insert into medicamentos (codigo,nombre, laboratorio,precio,cantidad)
 values(4,'Amoxilina 500','Bayer',15.60,100);

-- 6- Setee la opción "identity_insert" en "on"

set identity_insert medicamentos on;

-- 7- Ingrese un nuevo registro sin valor para el campo "codigo" (no lo permite):


 insert into medicamentos (nombre, laboratorio,precio,cantidad)
  values('Amoxilina 500','Bayer',15.60,100);

-- 8- Ingrese un nuevo registro con valor para el campo "codigo" repetido.


 insert into medicamentos (codigo,nombre, laboratorio,precio,cantidad)
  values(10,'Amoxilina 500','Bayer',15.60,100);

-- 9- Use la función "ident_seed()" para averiguar el valor de inicio del campo "identity" de la tabla 
-- "medicamentos"

select indent_seed('medicamentos');

-- 10- Emplee la función "ident_incr()" para saber cuál es el valor de incremento del campo "identity" 
-- de "medicamentos"

select ident_incr('medicamentos');








-- ********************* Segundo problema *********************



-- Un videoclub almacena información sobre sus películas en una tabla llamada "peliculas".
-- 1- Elimine la tabla si existe:

if object_id('peliculas') is not null
drop table peliculas;


-- 2- Créela definiendo un campo "codigo" autoincrementable que comience en 50 y se incremente en 3:


 create table peliculas(
  codigo int identity (50,3),
  titulo varchar(40),
  actor varchar(20),
  duracion int
 );


-- 3- Ingrese los siguientes registros:

 insert into peliculas (titulo,actor,duracion)
  values('Mision imposible','Tom Cruise',120);

 insert into peliculas (titulo,actor,duracion)
  values('Harry Potter y la piedra filosofal','Daniel R.',180);

 insert into peliculas (titulo,actor,duracion)
  values('Harry Potter y la camara secreta','Daniel R.',190);

-- 4- Seleccione todos los registros y verifique la carga automática de los códigos:

select *  from peliculas;

-- 5- Setee la opción "identity_insert" en "on"

set identitiy_insert peliculas on;

-- 6- Ingrese un registro con valor de código menor a 50.

insert into(codigo, titulo, actor, duracion)
values(20, 'Mision Imposible', 'Tom Cruise', 120);

-- 7- Ingrese un registro con valor de código mayor al último generado.

insert into(codigo, titulo, actor, duracion)
values(80, 'Mision Imposible 2', 'Tom Cruisee', 123);

-- 8- Averigue el valor de inicio del campo "identity" de la tabla "peliculas".

select ident_seed ('peliculas');

-- 9- Averigue el valor de incremento del campo "identity" de "peliculas".

set ident_ incr ('peliculas');

-- 10- Intente ingresar un registro sin valor para el campo código.

 insert into peliculas (titulo,actor,duracion)
  values('Elsa y Fred','China Zorrilla',90);

-- 11- Desactive la opción se inserción para el campo de identidad.

set identity_insert peliculas off;

-- 12- Ingrese un nuevo registro y muestre todos los registros para ver cómo SQL Server siguió la 
-- secuencia tomando el último valor del campo como referencia.

 insert into peliculas (titulo,actor,duracion)
  values('Elsa y Fred','China Zorrilla',90);
  
 select * from peliculas;


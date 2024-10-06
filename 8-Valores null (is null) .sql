
 
 -------------------------------------------------------------------------------------------------------------------------------
-- 		Valores null (is null) 
 -------------------------------------------------------------------------------------------------------------------------------


-- "null" significa "dato desconocido" o "valor inexistente". No es lo mismo que un valor "0", una cadena vacía o una cadena literal "null".

-- A veces, puede desconocerse o no existir el dato correspondiente a algún campo de un registro. En estos casos decimos que el campo puede contener valores nulos.

-- Por ejemplo, en nuestra tabla de libros, podemos tener valores nulos en el campo "precio" porque es posible que para algunos libros no le hayamos establecido el precio para la venta.

-- En contraposición, tenemos campos que no pueden estar vacíos jamás.

-- Veamos un ejemplo. Tenemos nuestra tabla "libros". El campo "titulo" no debería estar vacío nunca, igualmente el campo "autor". Para ello, al crear la tabla, debemos especificar que dichos campos no admitan valores nulos:

--  create table libros(
--   titulo varchar(30) not null,
--   autor varchar(20) not null,
--   editorial varchar(15) null,
--   precio float 
--  );

-- Para especificar que un campo no admita valores nulos, debemos colocar "not null" luego de la definición del campo.
-- En el ejemplo anterior, los campos "editorial" y "precio" si admiten valores nulos.
-- Cuando colocamos "null" estamos diciendo que admite valores nulos (caso del campo "editorial"); por defecto, es decir, si no lo aclaramos, los campos permiten valores nulos (caso del campo "precio").

-- Si ingresamos los datos de un libro, para el cual aún no hemos definido el precio podemos colocar "null" para mostrar que no tiene precio:

--  insert into libros (titulo,autor,editorial,precio)
--   values('El aleph','Borges','Emece',null);

-- Note que el valor "null" no es una cadena de caracteres, no se coloca entre comillas.
-- Entonces, si un campo acepta valores nulos, podemos ingresar "null" cuando no conocemos el valor.

-- También podemos colocar "null" en el campo "editorial" si desconocemos el nombre de la editorial a la cual pertenece el libro que vamos a ingresar:

--  insert into libros (titulo,autor,editorial,precio)
--   values('Alicia en el pais','Lewis Carroll',null,25);

-- Si intentamos ingresar el valor "null" en campos que no admiten valores nulos (como "titulo" o "autor"), SQL Server no lo permite, muestra un mensaje y la inserción no se realiza; por ejemplo:

--  insert into libros (titulo,autor,editorial,precio)
--   values(null,'Borges','Siglo XXI',25);

-- Para ver cuáles campos admiten valores nulos y cuáles no, podemos emplear el procedimiento almacenado "sp_columns" junto al nombre de la tabla. Nos muestra mucha información, en la columna "IS_NULLABLE" vemos que muestra "NO" en los campos que no permiten valores nulos y "YES" en los campos que si los permiten.







--********************************** Primer problema **********************************


--  Una farmacia guarda información referente a sus medicamentos en una tabla llamada "medicamentos".

-- 1- Elimine la tabla, si existe:

if object_id('medicamentos') is not null
drop table medicamentos;


-- 2- Cree la tabla con la siguiente estructura:

 create table medicamentos(
  codigo integer not null,
  nombre varchar(20) not null,
  laboratorio varchar(20),
  precio float,
  cantidad integer not null
 );

-- 3- Visualice la estructura de la tabla "medicamentos":

exec sp_columns medicamentos;

-- note que los campos "codigo", "nombre" y "cantidad", en la columna "IS_NULLABLE" aparece "NO" y en 
-- las otras "YES". 

-- 4- Ingrese algunos registros con valores "null" para los campos que lo admitan:


 insert into medicamentos (codigo,nombre,laboratorio,precio,cantidad)
  values(1,'Sertal gotas',null,null,100); 

 insert into medicamentos (codigo,nombre,laboratorio,precio,cantidad)
  values(2,'Sertal compuesto',null,8.90,150);

 insert into medicamentos (codigo,nombre,laboratorio,precio,cantidad)
  values(3,'Buscapina','Roche',null,200);

-- 5- Vea todos los registros:

select * from medicamentos;

-- 6- Ingrese un registro con valor "0" para el precio y cadena vacía para el laboratorio:

insert into medicamentos(codigo, nombre, laboratorio, precio, cantidad)
values (4, 'Bayaspirina', ' ', 0, 150);



-- 7- Ingrese un registro con valor "0" para el código y cantidad y cadena vacía para el nombre:


insert into medicamentos(codigo, nombre, laboratorio, precio, cantidad)
values(0, ' ' , 'Bayer', 15.60, 0);



-- 8- Muestre todos los registros:

select * from medicamentos;

-- 9- Intente ingresar un registro con valor nulo para un campo que no lo admite (aparece un mensaje de 
-- error):


 insert into medicamentos (codigo,nombre,laboratorio,precio,cantidad)
  values(null,'Amoxidal jarabe','Bayer',25,120);

-- 10- Recupere los registros que contengan valor "null" en el campo "laboratorio", luego los que 
-- tengan una cadena vacía en el mismo campo. Note que el resultado es diferente.

select * from medicamentos 
where laboratorio is null && laboratorio = ' ';

-- 11- Recupere los registros que contengan valor "null" en el campo "precio", luego los que tengan el 
-- valor 0 en el mismo campo. Note que el resultado es distinto.

select *  from medicamentos
where precio is null;

select *  from medicamentos
where precio= 0;

-- 12- Recupere los registros cuyo laboratorio no contenga una cadena vacía, luego los que sean 
-- distintos de "null".

select *  from medicamentos
where laboratorio <> ' ';

select *  from medicamentos
where laboratorio is not null;

-- Note que la salida de la primera sentencia no muestra los registros con cadenas vacías y tampoco los 
-- que tienen valor nulo; el resultado de la segunda sentencia muestra los registros con valor para el 
-- campo laboratorio (incluso cadena vacía).

-- 13- Recupere los registros cuyo precio sea distinto de 0, luego los que sean distintos de "null":
-- Note que la salida de la primera sentencia no muestra los registros con valor 0 y tampoco los que 
-- tienen valor nulo; el resultado de la segunda sentencia muestra los registros con valor para el 
-- campo precio (incluso el valor 0).


select * from medicamentoswhere precio <> 0;
select * from medicamentos where precio is not null;











-- ********************* Segundo problema *********************



-- Trabaje con la tabla que almacena los datos sobre películas, llamada "peliculas".

-- 1- Elimine la tabla si existe:

if object_id('peliculas') is not null
drop table peliculas;



-- 2- Créela con la siguiente estructura:

 create table peliculas(
  codigo int not null,
  titulo varchar(40) not null,
  actor varchar(20),
  duracion int
 );

-- 3- Visualice la estructura de la tabla

exec sp_ columns peliculas;

-- note que el campo "codigo" y "titulo", en la columna "IS_NULLABLE" muestra "NO" y los otros campos "YES".

-- 4- Ingrese los siguientes registros:

 insert into peliculas (codigo,titulo,actor,duracion)
  values(1,'Mision imposible','Tom Cruise',120);

 insert into peliculas (codigo,titulo,actor,duracion)
  values(2,'Harry Potter y la piedra filosofal',null,180);

 insert into peliculas (codigo,titulo,actor,duracion)
  values(3,'Harry Potter y la camara secreta','Daniel R.',null);

 insert into peliculas (codigo,titulo,actor,duracion)
  values(0,'Mision imposible 2','',150);

 insert into peliculas (codigo,titulo,actor,duracion)
  values(4,'','L. Di Caprio',220);

 insert into peliculas (codigo,titulo,actor,duracion)
  values(5,'Mujer bonita','R. Gere-J. Roberts',0);

-- 5- Recupere todos los registros para ver cómo SQL Server los almacenó:
select * from peliculas;


-- 6- Intente ingresar un registro con valor nulo para campos que no lo admiten (aparece un mensaje de 
-- error):

insert into peliculas (codigo, titulo, actor, duracion)
values (null,'Mision imposible','Tom Cruise',120);


-- 7- Muestre los registros con valor nulo en el campo "actor" y luego los que guardan una cadena vacía 
-- (note que la salida es distinta) (1 registro)

select * from peliculas where actor is null;
select * from peliculas where actor= ' ';


-- 8- Modifique los registros que tengan valor de duración desconocido (nulo) por "120" (1 registro 
-- actualizado)
update peliculas set duracion = 120 
where duracion is null;


-- 9- Coloque 'Desconocido' en el campo "actor" en los registros que tengan una cadena vacía en dicho 
-- campo (1 registro afectado)

update peliculas set actor='Desconocido'
where actor=' ' ;

-- 10- Muestre todos los registros. Note que el cambio anterior no afectó a los registros con valor 
-- nulo en el campo "actor".

select * from peliculas;

-- 11- Elimine los registros cuyo título sea una cadena vacía (1 registro)


 delete from peliculas where titulo='';


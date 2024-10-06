
 
 -------------------------------------------------------------------------------------------------------------------------------
-- 	Actualizar registros (update) 
 -------------------------------------------------------------------------------------------------------------------------------

-- Decimos que actualizamos un registro cuando modificamos alguno de sus valores.

-- Para modificar uno o varios datos de uno o varios registros utilizamos "update" (actualizar).

-- Por ejemplo, en nuestra tabla "usuarios", queremos cambiar los valores de todas las claves, por "RealMadrid":

--  update usuarios set clave='RealMadrid';

-- Utilizamos "update" junto al nombre de la tabla y "set" junto con el campo a modificar y su nuevo valor.

-- El cambio afectará a todos los registros.

-- Podemos modificar algunos registros, para ello debemos establecer condiciones de selección con "where".
-- Por ejemplo, queremos cambiar el valor correspondiente a la clave de nuestro usuario llamado "Federicolopez", queremos como nueva clave "Boca", necesitamos una condición "where" que afecte solamente a este registro:

--  update usuarios set clave='Boca'
--   where nombre='Federicolopez';

-- Si Microsoft SQL Server no encuentra registros que cumplan con la condición del "where", no se modifica ninguno.

-- Las condiciones no son obligatorias, pero si omitimos la cláusula "where", la actualización afectará a todos los registros.

-- También podemos actualizar varios campos en una sola instrucción:

--  update usuarios set nombre='Marceloduarte', clave='Marce'
--   where nombre='Marcelo';

-- Para ello colocamos "update", el nombre de la tabla, "set" junto al nombre del campo y el nuevo valor y separado por coma, el otro nombre del campo con su nuevo valor.
-- Servidor de SQL Server instalado en forma local.

-- Ingresemos el siguiente lote de comandos en el SQL Server Management Studio:

-- if object_id('usuarios') is not null
--   drop table usuarios;

-- create table usuarios(
--   nombre varchar(20),
--   clave varchar(10)
-- );

-- go

-- insert into usuarios (nombre,clave)
--   values ('Marcelo','River');
-- insert into usuarios (nombre,clave)
--   values ('Susana','chapita');
-- insert into usuarios (nombre,clave)
--   values ('Carlosfuentes','Boca');
-- insert into usuarios (nombre,clave)
--   values ('Federicolopez','Boca');

-- update usuarios set clave='RealMadrid';

-- select * from usuarios;

-- update usuarios set clave='Boca'
--   where nombre='Federicolopez';

-- select * from usuarios;

-- update usuarios set clave='payaso'
--   where nombre='JuanaJuarez';

-- select * from usuarios;

-- update usuarios set nombre='Marceloduarte', clave='Marce'
--   where nombre='Marcelo';

-- select * from usuarios;



-- 1---:********************************** Primer problema **********************************



-- Trabaje con la tabla "agenda" que almacena los datos de sus amigos.

-- 1- Elimine la tabla si existe:

if object_id('agenda')is not null
drop table agenda;


-- 2- Cree la tabla:

 create table agenda(
  apellido varchar(30),
  nombre varchar(20),
  domicilio varchar(30),
  telefono varchar(11)
 );

-- 3- Ingrese los siguientes registros (1 registro actualizado):

 insert into agenda (apellido,nombre,domicilio,telefono)
  values ('Acosta','Alberto','Colon 123','4234567');

 insert into agenda (apellido,nombre,domicilio,telefono)
  values ('Juarez','Juan','Avellaneda 135','4458787');

 insert into agenda (apellido,nombre,domicilio,telefono)
  values ('Lopez','Maria','Urquiza 333','4545454');

 insert into agenda (apellido,nombre,domicilio,telefono)
  values ('Lopez','Jose','Urquiza 333','4545454');

 insert into agenda (apellido,nombre,domicilio,telefono)
  values ('Suarez','Susana','Gral. Paz 1234','4123456');

-- 4- Modifique el registro cuyo nombre sea "Juan" por "Juan Jose" (1 registro afectado)

update agenda set nombre= 'Juan Jose'
where nombre='Juan';

-- 5- Actualice los registros cuyo número telefónico sea igual a "4545454" por "4445566" 
-- (2 registros afectados)

update agenda set telefono="4445566" 
where telefono="4545454" ;


-- 6- Actualice los registros que tengan en el campo "nombre" el valor "Juan" por "Juan Jose" (ningún 
-- registro afectado porque ninguno cumple con la condición del "where")

update agenda set nombre='Juan Jose'
  where nombre='Juan';

-- 7 - Luego de cada actualización ejecute un select que muestre todos los registros de la tabla.

 select * from agenda;






 







-- ********************* Segundo problema *********************



-- Trabaje con la tabla "libros" de una librería.

-- 1- Elimine la tabla si existe:

if object_id('libros') is not null
drop table libros;

-- 2- Créela con los siguientes campos: titulo (cadena de 30 caracteres de longitud), autor (cadena de 
-- 20), editorial (cadena de 15) y precio (float):

create tables(
  titulo varchar(30),
  autor varchar(20),
  editorial varchar(15),
  precio float

);


-- 3- Ingrese los siguientes registros:

 insert into libros (titulo, autor, editorial, precio)
  values ('El aleph','Borges','Emece',25.00);

 insert into libros (titulo, autor, editorial, precio)
  values ('Martin Fierro','Jose Hernandez','Planeta',35.50);

 insert into libros (titulo, autor, editorial, precio)
  values ('Aprenda PHP','Mario Molina','Emece',45.50);

 insert into libros (titulo, autor, editorial, precio)
  values ('Cervantes y el quijote','Borges','Emece',25);

 insert into libros (titulo, autor, editorial, precio)
  values ('Matematica estas ahi','Paenza','Siglo XXI',15);

-- 4- Muestre todos los registros (5 registros):

select * from libros;

-- 5- Modifique los registros cuyo autor sea igual  a "Paenza", por "Adrian Paenza" (1 registro 
-- afectado)

update libros set autor= 'Adrian Paenza'
where autor='Paenza';



-- 6- Nuevamente, modifique los registros cuyo autor sea igual  a "Paenza", por "Adrian Paenza" (ningún 
-- registro afectado porque ninguno cumple la condición)

update libros set autor='Adrian Paenza' where autor='Paenza;'


-- 7- Actualice el precio del libro de "Mario Molina" a 27 pesos (1 registro afectado):

update libros set precio='27' where autor='Mario Molina';

-- 8- Actualice el valor del campo "editorial" por "Emece S.A.", para todos los registros cuya 
-- editorial sea igual a "Emece" (3 registros afectados):

update libros set editorial='Emece S.A'
where editorial='Emece';


-- 9 - Luego de cada actualización ejecute un select que mustre todos los registros de la tabla.

 select * from libros;


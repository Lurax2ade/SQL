
 
 -------------------------------------------------------------------------------------------------------------------------------
-- Otros operadores relacionales (is null)
 -------------------------------------------------------------------------------------------------------------------------------


-- Ver video

-- Hemos aprendido los operadores relacionales "=" (igual), "<>" (distinto), ">" (mayor), "<" (menor), ">=" (mayor o igual) y "<=" (menor o igual). Dijimos que no eran los únicos.

-- Existen otro operador relacional "is null".

-- Se emplea el operador "is null" para recuperar los registros en los cuales esté almacenado el valor "null" en un campo específico:

--  select * from libros
--   where editorial is null;

-- Para obtener los registros que no contiene "null", se puede emplear "is not null", esto mostrará los registros con valores conocidos.

-- Siempre que sea posible, emplee condiciones de búsqueda positivas ("is null"), evite las negativas ("is not null") porque con ellas se evalúan todos los registros y esto hace más lenta la recuperación de los datos.


-- ********************* primer problema *********************



-- Trabajamos con la tabla "peliculas" de un video club que alquila películas en video.

-- 1- Elimine la tabla, si existe;

if object_id('peliculas') is not null
drop table peliculas;

-- 2- Créela con la siguiente estructura:

 create table peliculas(
  codigo int identity,
  titulo varchar(40) not null,
  actor varchar(20),
  duracion tinyint,
  primary key (codigo)
 );

-- 3- Ingrese algunos registros:

 insert into peliculas
  values('Mision imposible','Tom Cruise',120);

 insert into peliculas
  values('Harry Potter y la piedra filosofal','Daniel R.',null);

 insert into peliculas
  values('Harry Potter y la camara secreta','Daniel R.',190);

 insert into peliculas
  values('Mision imposible 2','Tom Cruise',120);

 insert into peliculas
  values('Mujer bonita',null,120);

 insert into peliculas
  values('Tootsie','D. Hoffman',90);

 insert into peliculas (titulo)
  values('Un oso rojo');

-- 4- Recupere las películas cuyo actor sea nulo (2 registros)

select * from peliculas 
where actor is null;

-- 5- Cambie la duración a 0, de las películas que tengan duración igual a "null" (2 registros)
update peliculas set duracion=0 
where duracion is null;


-- 6- Borre todas las películas donde el actor sea "null" y cuya duración sea 0 (1 registro)

delete from peliculas
where actor is null and duracion=0;



 select * from peliculas;




-- ********************* Segundo problema *********************



 
 -------------------------------------------------------------------------------------------------------------------------------
-- Operadores lógicos ( and - or - not)
 -------------------------------------------------------------------------------------------------------------------------------



-- Hasta el momento, hemos aprendido a establecer una condición con "where" utilizando operadores relacionales. Podemos establecer más de una condición con la cláusula "where", para ello aprenderemos los operadores lógicos.

-- Son los siguientes:

-- - and, significa "y",
-- - or, significa "y/o",
-- - not, significa "no", invierte el resultado
-- - (), paréntesis

-- Los operadores lógicos se usan para combinar condiciones.

-- Si queremos recuperar todos los libros cuyo autor sea igual a "Borges" y cuyo precio no supere los 20 pesos, necesitamos 2 condiciones:

--  select * from libros
--   where (autor='Borges') and
--   (precio<=20);

-- Los registros recuperados en una sentencia que une 2 condiciones con el operador "and", cumplen con las 2 condiciones.

-- Queremos ver los libros cuyo autor sea "Borges" y/o cuya editorial sea "Planeta":

--  select * from libros
--   where autor='Borges' or
--   editorial='Planeta';

-- En la sentencia anterior usamos el operador "or"; indicamos que recupere los libros en los cuales el valor del campo "autor" sea "Borges" y/o el valor del campo "editorial" sea "Planeta", es decir, seleccionará los registros que cumplan con la primera condición, con la segunda condición o con ambas condiciones.

-- Los registros recuperados con una sentencia que une 2 condiciones con el operador "or", cumplen 1 de las condiciones o ambas.

-- Queremos recuperar los libros que NO cumplan la condición dada, por ejemplo, aquellos cuya editorial NO sea "Planeta":

--  select * from libros
--   where not editorial='Planeta';

-- El operador "not" invierte el resultado de la condición a la cual antecede.

-- Los registros recuperados en una sentencia en la cual aparece el operador "not", no cumplen con la condición a la cual afecta el "NOT".

-- Los paréntesis se usan para encerrar condiciones, para que se evalúen como una sola expresión.
-- Cuando explicitamos varias condiciones con diferentes operadores lógicos (combinamos "and", "or") permite establecer el orden de prioridad de la evaluación; además permite diferenciar las expresiones más claramente.

-- Por ejemplo, las siguientes expresiones devuelven un resultado diferente:

--  select* from libros
--   where (autor='Borges') or
--   (editorial='Paidos' and precio<20);

--  select * from libros
--   where (autor='Borges' or editorial='Paidos') and
--   (precio<20);

-- Si bien los paréntesis no son obligatorios en todos los casos, se recomienda utilizarlos para evitar confusiones.

-- El orden de prioridad de los operadores lógicos es el siguiente: "not" se aplica antes que "and" y "and" antes que "or", si no se especifica un orden de evaluación mediante el uso de paréntesis.
-- El orden en el que se evalúan los operadores con igual nivel de precedencia es indefinido, por ello se recomienda usar los paréntesis.

-- Entonces, para establecer más de una condición en un "where" es necesario emplear operadores lógicos. "and" significa "y", indica que se cumplan ambas condiciones; "or" significa "y/o", indica que se cumpla una u otra condición (o ambas); "not" significa "no", indica que no se cumpla la condición especificada.




-- ********************* primer problema *********************


-- Trabaje con la tabla llamada "medicamentos" de una farmacia.

-- 1- Elimine la tabla, si existe:

if object_id('medicamentos') is not null
drop table medicamentos;


-- 2- Cree la tabla con la siguiente estructura:

 create table medicamentos(
  codigo int identity,
  nombre varchar(20),
  laboratorio varchar(20),
  precio decimal(5,2),
  cantidad tinyint,
  primary key(codigo)
 );

-- 3- Ingrese algunos registros:

 insert into medicamentos
  values('Sertal','Roche',5.2,100);
 insert into medicamentos
  values('Buscapina','Roche',4.10,200);
 insert into medicamentos
  values('Amoxidal 500','Bayer',15.60,100);
 insert into medicamentos
  values('Paracetamol 500','Bago',1.90,200);
 insert into medicamentos
  values('Bayaspirina','Bayer',2.10,150); 
 insert into medicamentos
  values('Amoxidal jarabe','Bayer',5.10,250); 

-- 4- Recupere los códigos y nombres de los medicamentos cuyo laboratorio sea 'Roche' y cuyo precio sea 
-- menor a 5 (1 registro cumple con ambas condiciones)


select codigo, nombre from medicamentos 
where laboratorio='Roche' and precio <5;

-- 5- Recupere los medicamentos cuyo laboratorio sea 'Roche' o cuyo precio sea menor a 5 (4 registros):

select * from medicamentos where laboratorio='Roche' or precio <5;


-- Note que el resultado es diferente al del punto 4, hemos cambiado el operador de la sentencia 
-- anterior.

-- 6- Muestre todos los medicamentos cuyo laboratorio NO sea "Bayer" y cuya cantidad sea=100 (1 
-- registro)

select * from medicamentos
where not laboratorio='Bayer' 
and cantidad=100;

-- 7- Muestre todos los medicamentos cuyo laboratorio sea "Bayer" y cuya cantidad NO sea=100 (2 registros):

 select * from medicamentos
  where laboratorio='Bayer' and
  not cantidad=100;

-- Analice estas 2 últimas sentencias. El operador "not" afecta a la condición a la cual antecede, no a 
-- las siguientes. Los resultados de los puntos 6 y 7 son diferentes.

-- 8- Elimine todos los registros cuyo laboratorio sea igual a "Bayer" y su precio sea mayor a 10 (1 
-- registro eliminado)

delete from medicamentos
where laboratorio='Bayer' and precio >10;

-- 9- Cambie la cantidad por 200, a todos los medicamentos de "Roche" cuyo precio sea mayor a 5 (1 
-- registro afectado)


update medicamentos set cantidad=100 where laboratorio='Roche' and precio >5;

-- 10- Borre los medicamentos cuyo laboratorio sea "Bayer" o cuyo precio sea menor a 3 (3 registros 
-- borrados)



delete from medicamentos
where laboratorio='Bayer' or precio <3;








-- ********************* Segundo problema *********************


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
  values('Harry Potter y la piedra filosofal','Daniel R.',180);

 insert into peliculas
  values('Harry Potter y la camara secreta','Daniel R.',190);

 insert into peliculas
  values('Mision imposible 2','Tom Cruise',120);

 insert into peliculas
  values('Mujer bonita','Richard Gere',120);

 insert into peliculas
  values('Tootsie','D. Hoffman',90);

 insert into peliculas
  values('Un oso rojo','Julio Chavez',100);

 insert into peliculas
  values('Elsa y Fred','China Zorrilla',110);

-- 4- Recupere los registros cuyo actor sea "Tom Cruise" or "Richard Gere" (3 registros)

select * from peliculas 
where actor='Tom Cruise' 
or actor= 'Richard Gere';

-- 5- Recupere los registros cuyo actor sea "Tom Cruise" y duración menor a 100 (ninguno cumple ambas 
-- condiciones)

select* from peliculas 

where actor= 'Tom Cruise' and duracion<100;

-- 6- Cambie la duración a 200, de las películas cuyo actor sea "Daniel R." y cuya duración sea 180 (1 
-- registro afectado)

update peliculas 
set duracion=200 
where actor='Daniel R.' 
and duracion=180;
-- 7- Borre todas las películas donde el actor NO sea "Tom Cruise" y cuya duración sea mayor o igual a 
-- 100 (2 registros eliminados)


 delete from peliculas
  where not actor='Tom Cruise' and
  duracion<=100;

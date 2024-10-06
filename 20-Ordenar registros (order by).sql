
 
 -------------------------------------------------------------------------------------------------------------------------------
-- 			Ordenar registros (order by)
 -------------------------------------------------------------------------------------------------------------------------------




-- Podemos ordenar el resultado de un "select" para que los registros se muestren ordenados por algún campo, para ello usamos la cláusula "order by".

-- La sintaxis básica es la siguiente:

--  select * from NOMBRETABLA
--   order by CAMPO; 

-- Por ejemplo, recuperamos los registros de la tabla "libros" ordenados por el título:

-- select *from libros
--  order by titulo;

-- Aparecen los registros ordenados alfabéticamente por el campo especificado.

-- También podemos colocar el número de orden del campo por el que queremos que se ordene en lugar de su nombre, es decir, referenciar a los campos por su posición en la lista de selección. Por ejemplo, queremos el resultado del "select" ordenado por "precio":

--  select titulo,autor,precio
--   from libros order by 3;

-- Por defecto, si no aclaramos en la sentencia, los ordena de manera ascendente (de menor a mayor).
-- Podemos ordenarlos de mayor a menor, para ello agregamos la palabra clave "desc":

--  select * libros
--   order by editorial desc;

-- También podemos ordenar por varios campos, por ejemplo, por "titulo" y "editorial":

--  select * from libros
--   order by titulo,editorial;

-- Incluso, podemos ordenar en distintos sentidos, por ejemplo, por "titulo" en sentido ascendente y "editorial" en sentido descendente:

--  select * from libros
--   order by titulo asc, editorial desc;

-- Debe aclararse al lado de cada campo, pues estas palabras claves afectan al campo inmediatamente anterior.

-- Es posible ordenar por un campo que no se lista en la selección.

-- Se permite ordenar por valores calculados o expresiones.

-- La cláusula "order by" no puede emplearse para campos text, ntext e image.






-- ********************* primer problema *********************


-- En una página web se guardan los siguientes datos de las visitas: número de visita, nombre, mail, 
-- pais, fecha.

-- 1- Elimine la tabla "visitas", si existe:

if object_id('visitas') is not null
drop table visitas;


-- 2- Créela con la siguiente estructura:

 create table visitas (
  numero int identity,
  nombre varchar(30) default 'Anonimo',
  mail varchar(50),
  pais varchar (20),
  fecha datetime,
  primary key(numero)
);

-- 3- Ingrese algunos registros:

insert into visitras(nombre, mail, pais, fecha)
values('Laurita', 'yameacuerdo@gmail.com', 'Rumanía', '1996-12-21 22:22');

 insert into visitas (nombre,mail,pais,fecha)
  values ('Ana Maria Lopez','AnaMaria@hotmail.com','Argentina','2006-10-10 10:10');

 insert into visitas (nombre,mail,pais,fecha)
  values ('Gustavo Gonzalez','GustavoGGonzalez@hotmail.com','Chile','2006-10-10 21:30');

 insert into visitas (nombre,mail,pais,fecha)
  values ('Juancito','JuanJosePerez@hotmail.com','Argentina','2006-10-11 15:45');

 insert into visitas (nombre,mail,pais,fecha)
  values ('Fabiola Martinez','MartinezFabiola@hotmail.com','Mexico','2006-10-12 08:15');

 insert into visitas (nombre,mail,pais,fecha)
  values ('Fabiola Martinez','MartinezFabiola@hotmail.com','Mexico','2006-09-12 20:45');

 insert into visitas (nombre,mail,pais,fecha)
  values ('Juancito','JuanJosePerez@hotmail.com','Argentina','2006-09-12 16:20');

 insert into visitas (nombre,mail,pais,fecha)
  values ('Juancito','JuanJosePerez@hotmail.com','Argentina','2006-09-15 16:25');


-- 4- Ordene los registros por fecha, en orden descendente.


select* from visitras
order by fecha desc;

-- 5- Muestre el nombre del usuario, pais y el nombre del mes, ordenado por pais (ascendente) y nombre 
-- del mes (descendente)

select nombre, pais, datename(month, fecha)
from visitas
order by pais, datename(month, fecha) desc;

-- 6- Muestre el pais, el mes, el día y la hora y ordene las visitas por nombre del mes, del día y la 
-- hora.

select nombre, mail, 
datename(day, fecha)dia, 
datename(month, fecha) mes, 
datename(hour, fecha) hora

from visitas
order by 3, 4, 5;

-- 7- Muestre los mail, país, ordenado por país, de todos los que visitaron la página en octubre (4 
-- registros)


select mail, pais
from visitas
where datename(month, fecha)='october'
order by 2;








-- ********************* Segundo problema *********************



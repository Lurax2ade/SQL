
 
 -------------------------------------------------------------------------------------------------------------------------------
-- 	Búsqueda de patrones (like - not like)
 -------------------------------------------------------------------------------------------------------------------------------


-- Ver video

-- Existe un operador relacional que se usa para realizar comparaciones exclusivamente de cadenas, "like" y "not like".

-- Hemos realizado consultas utilizando operadores relacionales para comparar cadenas. Por ejemplo, sabemos recuperar los libros cuyo autor sea igual a la cadena "Borges":

--  select *from libros
--   where autor='Borges';

-- El operador igual ("=") nos permite comparar cadenas de caracteres, pero al realizar la comparación, busca coincidencias de cadenas completas, realiza una búsqueda exacta.

-- Imaginemos que tenemos registrados estos 2 libros:

--  "El Aleph", "Borges";
--  "Antologia poetica", "J.L. Borges";

-- Si queremos recuperar todos los libros de "Borges" y especificamos la siguiente condición:

--  select * from libros
--  where autor='Borges';

-- sólo aparecerá el primer registro, ya que la cadena "Borges" no es igual a la cadena "J.L. Borges".

-- Esto sucede porque el operador "=" (igual), también el operador "<>" (distinto) comparan cadenas de caracteres completas. Para comparar porciones de cadenas utilizamos los operadores "like" y "not like".

-- Entonces, podemos comparar trozos de cadenas de caracteres para realizar consultas. Para recuperar todos los registros cuyo autor contenga la cadena "Borges" debemos tipear:

--  select * from libros
--   where autor like "%Borges%";

-- El símbolo "%" (porcentaje) reemplaza cualquier cantidad de caracteres (incluyendo ningún caracter). Es un caracter comodín. "like" y "not like" son operadores de comparación que señalan igualdad o diferencia.

-- Para seleccionar todos los libros que comiencen con "M":

--  select * from libros
--   where titulo like 'M%';

-- Note que el símbolo "%" ya no está al comienzo, con esto indicamos que el título debe tener como primera letra la "M" y luego, cualquier cantidad de caracteres.

-- Para seleccionar todos los libros que NO comiencen con "M":

--  select * from libros
--   where titulo not like 'M%';

-- Así como "%" reemplaza cualquier cantidad de caracteres, el guión bajo "_" reemplaza un caracter, es otro caracter comodín. Por ejemplo, queremos ver los libros de "Lewis Carroll" pero no recordamos si se escribe "Carroll" o "Carrolt", entonces tipeamos esta condición:

--  select * from libros
--   where autor like "%Carrol_";

-- Otro caracter comodín es [] reemplaza cualquier carácter contenido en el conjunto especificado dentro de los corchetes.

-- Para seleccionar los libros cuya editorial comienza con las letras entre la "P" y la "S" usamos la siguiente sintaxis:

--  select titulo,autor,editorial
--   from libros
--   where editorial like '[P-S]%';

-- Ejemplos:

-- ... like '[a-cf-i]%': busca cadenas que comiencen con a,b,c,f,g,h o i;
-- ... like '[-acfi]%': busca cadenas que comiencen con -,a,c,f o i;
-- ... like 'A[_]9%': busca cadenas que comiencen con 'A_9';
-- ... like 'A[nm]%': busca cadenas que comiencen con 'An' o 'Am'.

-- El cuarto caracter comodín es [^] reemplaza cualquier caracter NO presente en el conjunto especificado dentro de los corchetes.

-- Para seleccionar los libros cuya editorial NO comienza con las letras "P" ni "N" tipeamos:

--  select titulo,autor,editorial
--   from libros
--   where editorial like '[^PN]%';

-- "like" se emplea con tipos de datos char, nchar, varchar, nvarchar o datetime. Si empleamos "like" con tipos de datos que no son caracteres, SQL Server convierte (si es posible) el tipo de dato a caracter. Por ejemplo, queremos buscar todos los libros cuyo precio se encuentre entre 10.00 y 19.99:

--  select titulo,precio from libros
--   where precio like '1_.%';

-- Queremos los libros que NO incluyen centavos en sus precios:

--  select titulo,precio from libros
--   where precio like '%.00';

-- Para búsquedas de caracteres comodines como literales, debe incluirlo dentro de corchetes, por ejemplo, si busca:

-- ... like '%[%]%': busca cadenas que contengan el signo '%';
-- ... like '%[_]%': busca cadenas que contengan el signo '_';
-- ... like '%[[]%': busca cadenas que contengan el signo '[';











-- ********************* primer problema *********************


-- Una empresa almacena los datos de sus empleados en una tabla "empleados".

-- 1- Elimine la tabla, si existe:

 if object_id('empleados') is not null
  drop table empleados;

-- 2- Cree la tabla:

 create table empleados(
  nombre varchar(30),
  documento char(8),
  domicilio varchar(30),
  fechaingreso datetime,
  seccion varchar(20),
  sueldo decimal(6,2),
  primary key(documento)
 );

-- 3- Ingrese algunos registros:

insert into empleados
values('Laura', '78459612', 'Oaxaca 23', '2023-12-23', 'Gerencia', 1200);

 insert into empleados
  values('Juan Perez','22333444','Colon 123','1990-10-08','Gerencia',900.50);

 insert into empleados
  values('Ana Acosta','23444555','Caseros 987','1995-12-18','Secretaria',590.30);

 insert into empleados
  values('Lucas Duarte','25666777','Sucre 235','2005-05-15','Sistemas',790);

 insert into empleados
  values('Pamela Gonzalez','26777888','Sarmiento 873','1999-02-12','Secretaria',550);

 insert into empleados
  values('Marcos Juarez','30000111','Rivadavia 801','2002-09-22','Contaduria',630.70);

 insert into empleados
  values('Yolanda Perez','35111222','Colon 180','1990-10-08','Administracion',400);

 insert into empleados
  values('Rodolfo Perez','35555888','Coronel Olmedo 588','1990-05-28','Sistemas',800);



-- 4- Muestre todos los empleados con apellido "Perez" empleando el operador "like" (3 registros)

select * from empleados
where apellido like '%Perez%';


-- 5- Muestre todos los empleados cuyo domicilio comience con "Co" y tengan un "8" (2 registros)

select * frome empleados
where domicilio like 'co%8%';

-- 6- Seleccione todos los empleados cuyo documento finalice en 0,2,4,6 u 8 (4 registros)

select * from empleados
where documento like '%[02468]';

-- 7- Seleccione todos los empleados cuyo documento NO comience con 1 ni 3 y cuyo nombre finalice en 
-- "ez" (2 registros)

select * from empleados
where documento like '[^13]%'
and nombre like '%ez';

-- 8- Recupere todos los nombres que tengan una "y" o una "j" en su nombre o apellido (3 registros)

select * from empleados

where nombre like '%[yj]%';

-- 9- Muestre los nombres y sección de los empleados que pertenecen a secciones que comiencen con "S" o 
-- "G" y tengan 8 caracteres (3 registros)

select * from empleados
where seccion like '[SG]________';

-- 10- Muestre los nombres y sección de los empleados que pertenecen a secciones que NO comiencen con 
-- "S" o "G" (2 registros)

select nombre, seccion from empleados
where seccion not like '[SG]%';

-- 11- Muestre todos los nombres y sueldos de los empleados cuyos sueldos incluyen centavos (3 
-- registros)


 select nombre,sueldo from empleados
  where sueldo not like '%.00';

-- 12- Muestre los empleados que hayan ingresado en "1990" (3 registros)

 select * from empleados
  where fechaingreso like '%1990%';



-- ********************* Segundo problema *********************

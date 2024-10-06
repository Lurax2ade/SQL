
 
 
 -------------------------------------------------------------------------------------------------------------------------------
-- 	Tipo de dato (texto)
 -------------------------------------------------------------------------------------------------------------------------------


--  Tenemos los siguientes tipos:

-- varchar(x): define una cadena de caracteres de longitud variable en la cual determinamos el máximo de caracteres con el argumento "x" que va entre paréntesis.
-- Si se omite el argumento coloca 1 por defecto. Su rango va de 1 a 8000 caracteres.

-- char(x): define una cadena de longitud fija determinada por el argumento "x". Si se omite el argumento coloca 1 por defecto. Su rango es de 1 a 8000 caracteres.
--  Si la longitud es invariable, es conveniente utilizar el tipo char; caso contrario, el tipo varchar.
--  Ocupa tantos bytes como se definen con el argumento "x".
--  "char" viene de character, que significa caracter en inglés.

-- text: guarda datos binarios de longitud variable, puede contener hasta 2000000000 caracteres. No admite argumento para especificar su longitud.
   
-- nvarchar(x): es similar a "varchar", excepto que permite almacenar caracteres Unicode, su rango va de 0 a 4000 caracteres porque se emplean 2 bytes por cada caracter.
    
--nchar(x): es similar a "char" excpeto que acepta caracteres Unicode, su rango va de 0 a 4000 caracteres porque se emplean 2 bytes por cada caracter.

--ntext: es similar a "text" excepto que permite almacenar caracteres Unicode, puede contener hasta 1000000000 caracteres. No admite argumento para especificar su longitud.





--********************************** Primer problema **********************************

-- Una concesionaria de autos vende autos usados y almacena los datos de los autos en una tabla llamada 
-- "autos".

-- 1- Elimine la tabla "autos" si existe:

if object_id('autos') is not null
drop table autos;



-- 2- Cree la tabla eligiendo el tipo de dato adecuado para cada campo, estableciendo el campo 
-- "patente" como clave primaria:

create table autos(
  patente char(6),
  marca varchar(20),
  modelo char (4),
  precio float,
  primary key (patente)

);



-- Hemos definido el campo "patente" de tipo "char" y no "varchar" porque la cadena de caracteres 
-- siempre tendrá la misma longitud (6 caracteres). Lo mismo sucede con el campo "modelo", en el cual 
-- almacenaremos el año, necesitamos 4 caracteres fijos.

-- 3- Ingrese los siguientes registros:

 insert into autos
  values('ACD123','Fiat 128','1970',15000);

 insert into autos
  values('ACG234','Renault 11','1990',40000);

 insert into autos
  values('BCD333','Peugeot 505','1990',80000);

 insert into autos
  values('GCD123','Renault Clio','1990',70000);

 insert into autos
  values('BCC333','Renault Megane','1998',95000);

 insert into autos
  values('BVF543','Fiat 128','1975',20000);

-- 4- Seleccione todos los autos del año 1990:

select * from autos
where modelo='1990';








-- ********************* Segundo problema *********************



-- Una empresa almacena los datos de sus clientes en una tabla llamada "clientes".

-- 1- Elimine la tabla "clientes" si existe:

if object_id('pacientes') is not null
drop table pacientes;


-- 2- Créela eligiendo el tipo de dato más adecuado para cada campo:

 create table clientes(
  documento char(8),
  apellido varchar(20),
  nombre varchar(20),
  domicilio varchar(30),
  telefono varchar (11)
 );

-- 3- Analice la definición de los campos. Se utiliza char(8) para el documento porque siempre constará 
-- de 8 caracteres. Para el número telefónico se usar "varchar" y no un tipo numérico porque si bien es 
-- un número, con él no se realizarán operaciones matemáticas.

-- 4- Ingrese algunos registros:


 insert into clientes
  values('2233344','Perez','Juan','Sarmiento 980','4342345');

 insert into clientes (documento,apellido,nombre,domicilio)
  values('2333344','Perez','Ana','Colon 234');

 insert into clientes
  values('2433344','Garcia','Luis','Avellaneda 1454','4558877');
  
 insert into clientes
  values('2533344','Juarez','Ana','Urquiza 444','4789900');

-- 5- Seleccione todos los clientes de apellido "Perez" (2 registros):
--  select * from clientes
--   where apellido='Perez';

select * from pacientes
where apellido='Perez';


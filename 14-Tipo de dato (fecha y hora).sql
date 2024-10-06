
 
 -------------------------------------------------------------------------------------------------------------------------------
-- 	Tipo de dato (fecha y hora)
 -------------------------------------------------------------------------------------------------------------------------------



-- Ya explicamos que al crear una tabla debemos elegir la estructura adecuada, esto es, definir los campos y sus tipos más precisos, según el caso.

-- Para almacenar valores de tipo FECHA Y HORA SQL Server dispone de dos tipos:

-- 1) datetime: puede almacenar valores desde 01 de enero de 1753 hasta 31 de diciembre de 9999.

-- 2) smalldatetime: el rango va de 01 de enero de 1900 hasta 06 de junio de 2079.

-- Las fechas se ingresan entre comillas simples.

-- Para almacenar valores de tipo fecha se permiten como separadores "/", "-" y ".".

-- SQL Server reconoce varios formatos de entrada de datos de tipo fecha. Para establecer el orden de las partes de una fecha (dia, mes y año) empleamos "set dateformat". Estos son los formatos:

-- -mdy: 4/15/96 (mes y día con 1 ó 2 dígitos y año con 2 ó 4 dígitos),
-- -myd: 4/96/15,
-- -dmy: 15/4/1996
-- -dym: 15/96/4,
-- -ydm: 96/15/4,
-- -ydm: 1996/15/4,

-- Para ingresar una fecha con formato "día-mes-año", tipeamos:

--  set dateformat dmy;

-- El formato por defecto es "mdy".

-- Todos los valores de tipo "datetime" se muestran en formato "año-mes-día hora:minuto:segundo .milisegundos", independientemente del formato de ingreso que hayamos seteado.

-- Podemos ingresar una fecha, sin hora, en tal caso la hora se guarda como "00:00:00". Por ejemplo, si ingresamos '25-12-01' (año de 2 dígitos), lo mostrará así: '2001-12-25 00:00:00.000'.

-- Podemos ingresar una hora sin fecha, en tal caso, coloca la fecha "1900-01-01". Por ejemplo, si ingresamos '10:15', mostrará '1900-01-01 10:15.000'.

-- Podemos emplear los operadores relacionales vistos para comparar fechas.

-- Tipo		Bytes de almacenamiento
-- _______________________________________
-- datetime	8
-- smalldatetime	4






-- ********************* primer problema *********************


-- Una facultad almacena los datos de sus alumnos en una tabla denominada "alumnos".

-- 1- Elimine la tabla, si existe:

if object_id('alumnos') is not null
drop table alumnos;


-- 2- Cree la tabla eligiendo el tipo de dato adecuado para cada campo:


 create table alumnos(
  apellido varchar(30),
  nombre varchar(30),
  documento char(8),
  domicilio varchar(30),
  fechaingreso datetime,
  fechanacimiento datetime
 );

-- 3- Setee el formato para entrada de datos de tipo fecha para que acepte valores "día-mes-año": 

set dateformat 'dmy';

-- 4- Ingrese un alumno empleando distintos separadores para las fechas:

 insert into alumnos values('Gonzalez','Ana','22222222','Colon 123','10-08-1990','15/02/1972');

-- 5- Ingrese otro alumno empleando solamente un dígito para día y mes y 2 para el año:

insert into alumnos values ('Montoro', 'Guillermo', '75184692', 'Oaxaca 21', '02-03-1263', '24/12/1998');



-- 6- Ingrese un alumnos empleando 2 dígitos para el año de la fecha de ingreso y "null" en 
-- "fechanacimiento":

insert into alumnos values ('Montoro', 'Guillermo', '75184692', 'Oaxaca 21', '22-11-1263', null);

-- 7- Intente ingresar un alumno con fecha de ingreso correspondiente a "15 de marzo de 1990" pero en 
-- orden incorrecto "03-15-90":

 insert into alumnos values('Lopez','Carlos','27777777','Sarmiento 1254','03-15-1990',null);
-- aparece un mensaje de error porque lo lee con el formato día, mes y año y no reconoce el mes 15.

-- 8- Muestre todos los alumnos que ingresaron antes del '1-1-91'.
-- 1 registro.

select * from alumnos
where fechaingreso <'1-1-91';

-- 9- Muestre todos los alumnos que tienen "null" en "fechanacimiento":

select * from alumnos
where fechanacimiento is null;

-- 10- Intente ingresar una fecha de ingreso omitiendo los separadores:


 insert into alumnos values('Rosas','Romina','28888888','Avellaneda 487','03151990',null);
-- No lo acepta.


-- 11- Setee el formato de entrada de fechas para que acepte valores "mes-dia-año".

set dateformat 'mdy';

-- 12- Ingrese el registro del punto 7.


 insert into alumnos values('Lopez','Carlos','27777777','Sarmiento 1254','03-15-1990',null);
 

-- ********************* Segundo problema *********************



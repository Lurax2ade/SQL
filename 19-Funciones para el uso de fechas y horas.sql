
 -------------------------------------------------------------------------------------------------------------------------------
-- 		Funciones para el uso de fechas y horas
 -------------------------------------------------------------------------------------------------------------------------------



-- Microsoft SQL Server ofrece algunas funciones para trabajar con fechas y horas. Estas son algunas:

-- - getdate(): retorna la fecha y hora actuales. Ejemplo:

--  select getdate();

-- - datepart(partedefecha,fecha): retorna la parte específica de una fecha, el año, trimestre, día, hora, etc.

-- Los valores para "partedefecha" pueden ser: year (año), quarter (cuarto), month (mes), day (dia), week (semana), hour (hora), minute (minuto), second (segundo) y millisecond (milisegundo). Ejemplos:

--  select datepart(month,getdate());

-- retorna el número de mes actual;

--  select datepart(day,getdate());

-- retorna el día actual;

--  select datepart(hour,getdate());

-- retorna la hora actual;

-- - datename(partedefecha,fecha): retorna el nombre de una parte específica de una fecha. Los valores para "partedefecha" pueden ser los mismos que se explicaron anteriormente. Ejemplos:

--  select datename(month,getdate());

-- retorna el nombre del mes actual;

--  select datename(day,getdate());

-- - dateadd(partedelafecha,numero,fecha): agrega un intervalo a la fecha especificada, es decir, retorna una fecha adicionando a la fecha enviada como tercer argumento, el intervalo de tiempo indicado por el primer parámetro, tantas veces como lo indica el segundo parámetro. Los valores para el primer argumento pueden ser: year (año), quarter (cuarto), month (mes), day (dia), week (semana), hour (hora), minute (minuto), second (segundo) y millisecond (milisegundo). Ejemplos:

--  select dateadd(day,3,'1980/11/02');

-- retorna "1980/11/05", agrega 3 días.

--  select dateadd(month,3,'1980/11/02');

-- retorna "1981/02/02", agrega 3 meses.

--  select dateadd(hour,2,'1980/11/02');

-- retorna "1980/02/02 2:00:00", agrega 2 horas.

--  select dateadd(minute,16,'1980/11/02');

-- retorna "1980/02/02 00:16:00", agrega 16 minutos.

-- - datediff(partedelafecha,fecha1,fecha2): calcula el intervalo de tiempo (según el primer argumento) entre las 2 fechas. El resultado es un valor entero que corresponde a fecha2-fecha1. Los valores de "partedelafecha) pueden ser los mismos que se especificaron anteriormente. Ejemplos:

--  select datediff (day,'2005/10/28','2006/10/28');

-- retorna 365 (días).

--  select datediff(month,'2005/10/28','2006/11/29');

-- retorna 13 (meses).

-- - day(fecha): retorna el día de la fecha especificada. Ejemplo:

--  select day(getdate());

-- - month(fecha): retorna el mes de la fecha especificada. Ejemplo:

--  select month(getdate());

-- - year(fecha): retorna el año de la fecha especificada. Ejemplo:

--  select year(getdate());

-- Se pueden emplear estas funciones enviando como argumento el nombre de un campo de tipo datetime o smalldatetime.
-- Servidor de SQL Server instalado en forma local.



-- ********************* primer problema *********************


-- Una empresa almacena los datos de sus empleados en una tabla denominada "empleados".

-- 1- Elimine la tabla si existe:

if object_id('empleados') is not null
drop table empleados;


-- 2- Cree la tabla:

 create table empleados(
  nombre varchar(30) not null,
  apellido varchar(20) not null,
  documento char(8),
  fechanacimiento datetime,
  fechaingreso datetime,
  sueldo decimal(6,2),
  primary key(documento)
 );

-- 3- Ingrese algunos registros:

insert into empleados values ('Laura', 'Rodríguez', '45786912', '21-10-1996', '23/12/2023', 1500.23);

 insert into empleados values('Ana','Acosta','22222222','1970/10/10','1995/05/05',228.50);

 insert into empleados values('Carlos','Caseres','25555555','1978/02/06','1998/05/05',309);

 insert into empleados values('Francisco','Garcia','26666666','1978/10/15','1998/10/02',250.68);

 insert into empleados values('Gabriela','Garcia','30000000','1985/10/25','2000/12/22',300.25);

 insert into empleados values('Luis','Lopez','31111111','1987/02/10','2000/08/21',350.98);



-- 4- Muestre nombre y apellido concatenados, con el apellido en letras mayúsculas, el documento 
-- precedido por "DNI Nº " y el sueldo precedido por "$ ".



 select nombre+space(1)+upper(apellido) as nombre,
  stuff(documento,1,0,'DNI Nº ') as documento,
  stuff(sueldo,1,0,'$ ') as sueldo from empleados;

-- 5- Muestre el documento y el sueldo redondeado hacia arriba y precedido por "$ ".

select docuemtno, stuff(ceiling(sueldo), 1, 0, '$') from empleados;

-- 6- Muestre los nombres y apellidos de los empleados que cumplen años en el mes "october" (3 
-- registros)

select nombre, apellidos 
from empleados 
where datename(month, fechanacimiento)='october';

-- 7- Muestre los nombres y apellidos de los empleados que ingresaron en un determinado año (2 
-- registros).


select nombre, apellidos
from empleados
where datepart(year,fechaingreso)=2000;










-- ********************* Segundo problema *********************



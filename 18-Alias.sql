
 -------------------------------------------------------------------------------------------------------------------------------
-- 		Alias
 -------------------------------------------------------------------------------------------------------------------------------

-- https://www.tutorialesprogramacionya.com/sqlserverya/index.php?inicio=0


-- Una manera de hacer más comprensible el resultado de una consulta consiste en cambiar los encabezados de las columnas.
-- Por ejemplo, tenemos la tabla "agenda" con un campo "nombre" (entre otros) en el cual se almacena el nombre y apellido de nuestros amigos; queremos que al mostrar la información de dicha tabla aparezca como encabezado del campo "nombre" el texto "nombre y apellido", para ello colocamos un alias de la siguiente manera:

--  select nombre as NombreYApellido,
--   domicilio,telefono
--   from agenda;

-- Para reemplazar el nombre de un campo por otro, se coloca la palabra clave "as" seguido del texto del encabezado.

-- Si el alias consta de una sola cadena las comillas no son necesarias, pero si contiene más de una palabra, es necesario colocarla entre comillas simples:

--  select nombre as 'Nombre y apellido',
--   domicilio,telefono
--   from agenda;

-- Un alias puede contener hasta 128 caracteres.
-- También se puede crear un alias para columnas calculadas.

-- La palabra clave "as" es opcional en algunos casos, pero es conveniente usarla.

-- Entonces, un "alias" se usa como nombre de un campo o de una expresión. En estos casos, son opcionales, sirven para hacer más comprensible el resultado; en otros casos, que veremos más adelante, son obligatorios.




-- ********************* primer problema *********************

-- Trabaje con la tabla "libros" de una librería.

-- 1- Elimine la tabla si existe:
if object_id('libros') is not null
drop table libros;


-- 2- Cree la tabla:

 create table libros(
  codigo int identity,
  titulo varchar(40) not null,
  autor varchar(20) default 'Desconocido',
  editorial varchar(20),
  precio decimal(6,2),
  cantidad tinyint default 0,
  primary key (codigo)
 );

-- 3- Ingrese algunos registros:

 insert into libros (titulo,autor,editorial,precio)
  values('El aleph','Borges','Emece',25);

 insert into libros
  values('Java en 10 minutos','Mario Molina','Siglo XXI',50.40,100);

 insert into libros (titulo,autor,editorial,precio,cantidad)
  values('Alicia en el pais de las maravillas','Lewis Carroll','Emece',15,50);

-- 4- Muestre todos los campos de los libros y un campo extra, con el encabezado "monto total" en la 
-- que calcule el monto total en dinero de cada libro (precio por cantidad)

select titulo, autor, editorial, precio, cantidad, 
precio*cantidad as 'monto total' 
from libros;



-- 5- Muestre el título, autor y precio de todos los libros de editorial "Emece" y agregue dos columnas 
-- extra en las cuales muestre el descuento de cada libro, con el encabezado "descuento" y el precio 
-- con un 10% de descuento con el encabezado "precio final".

 select titulo,autor,precio,
  precio*0.1 as descuento,
  precio-(precio*0.1) as 'precio final'
  from libros
  where editorial='Emece';
  
  -- 6- Muestre una columna con el título y el autor concatenados con el encabezado "Título y autor"


 select titulo+'-'+autor as "Título y autor"
  from libros;








-- ********************* Segundo problema *********************



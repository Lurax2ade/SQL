
 
 -------------------------------------------------------------------------------------------------------------------------------
-- 	Columnas calculadas (operadores aritméticos y de concatenación)
 -------------------------------------------------------------------------------------------------------------------------------

-- https://www.tutorialesprogramacionya.com/sqlserverya/index.php?inicio=0

-- Aprendimos que los operadores son símbolos que permiten realizar distintos tipos de operaciones.
-- Dijimos que SQL Server tiene 4 tipos de operadores: 1) relacionales o de comparación (los vimos), 2) lógicos (lo veremos más adelante, 3) aritméticos y 4) de concatenación.

-- Los operadores aritméticos permiten realizar cálculos con valores numéricos.
-- Son: multiplicación (*), división (/) y módulo (%) (el resto de dividir números enteros), suma (+) y resta (-).

-- Es posible obtener salidas en las cuales una columna sea el resultado de un cálculo y no un campo de una tabla.

-- Si queremos ver los títulos, precio y cantidad de cada libro escribimos la siguiente sentencia:

--  select titulo,precio,cantidad
--   from libros;

-- Si queremos saber el monto total en dinero de un título podemos multiplicar el precio por la cantidad por cada título, pero también podemos hacer que SQL Server realice el cálculo y lo incluya en una columna extra en la salida:

 
--  select titulo, precio,cantidad,
--   precio*cantidad
--   from libros;

-- Si queremos saber el precio de cada libro con un 10% de descuento podemos incluir en la sentencia los siguientes cálculos:

--  select titulo,precio,
--   precio-(precio*0.1)
--   from libros;

-- También podemos actualizar los datos empleando operadores aritméticos:

--  update libros set precio=precio-(precio*0.1);

-- Todas las operaciones matemáticas retornan "null" en caso de error. Ejemplo:

--  select 5/0;

-- Los operadores de concatenación: permite concatenar cadenas, el más (+).

-- Para concatenar el título, el autor y la editorial de cada libro usamos el operador de concatenación ("+"):

--  select titulo+'-'+autor+'-'+editorial
--   from libros;

-- Note que concatenamos además unos guiones para separar los campos.




-- ********************* primer problema *********************


-- Un comercio que vende artículos de computación registra los datos de sus artículos en una tabla con 
-- ese nombre.

-- 1- Elimine la tabla si existe:
if object_id('articulos') is not null
drop table articulos;


-- 2- Cree la tabla:

 create table articulos(
  codigo int identity,
  nombre varchar(20),
  descripcion varchar(30),
  precio smallmoney,
  cantidad tinyint default 0,
  primary key (codigo)
 );

-- 3- Ingrese algunos registros:


 insert into articulos (nombre, descripcion, precio,cantidad)
  values ('impresora','Epson Stylus C45',400.80,20);

 insert into articulos (nombre, descripcion, precio)
  values ('impresora','Epson Stylus C85',500);

 insert into articulos (nombre, descripcion, precio)
  values ('monitor','Samsung 14',800);

 insert into articulos (nombre, descripcion, precio,cantidad)
  values ('teclado','ingles Biswal',100,50);

-- 4- El comercio quiere aumentar los precios de todos sus artículos en un 15%. Actualice todos los 
-- precios empleando operadores aritméticos.


update articulos set precio=precio+(precio*0.15);

-- 5- Vea el resultado:

select * from articulos;

-- 6- Muestre todos los artículos, concatenando el nombre y la descripción de cada uno de ellos 
-- separados por coma.

select nombre+',' +descripcionfrom articulos;

-- 7- Reste a la cantidad de todos los teclados, el valor 5, empleando el operador aritmético menos ("-")




 update articulos set cantidad=cantidad-5
 where nombre='teclado';

 select * from articulos;






-- ********************* Segundo problema *********************



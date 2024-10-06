
 -------------------------------------------------------------------------------------------------------------------------------
--	Unión
 -------------------------------------------------------------------------------------------------------------------------------
-- El operador "union" combina el resultado de dos o más instrucciones "select" en un único resultado.

-- Se usa cuando los datos que se quieren obtener pertenecen a distintas tablas y no se puede acceder a ellos con una sola consulta.

-- Es necesario que las tablas referenciadas tengan tipos de datos similares, la misma cantidad de campos y el mismo orden de campos en la lista de selección de cada consulta. No se incluyen las filas duplicadas en el resultado, a menos que coloque la opción "all".

-- Se deben especificar los nombres de los campos en la primera instrucción "select".

-- Puede emplear la cláusula "order by".

-- Puede dividir una consulta compleja en varias consultas "select" y luego emplear el operador "union" para combinarlas.

-- Una academia de enseñanza almacena los datos de los alumnos en una tabla llamada "alumnos" y los datos de los profesores en otra denominada "profesores".
-- La academia necesita el nombre y domicilio de profesores y alumnos para enviarles una tarjeta de invitación.

-- Para obtener los datos necesarios de ambas tablas en una sola consulta necesitamos realizar una unión:

--  select nombre, domicilio from alumnos
--   union
--    select nombre, domicilio from profesores;

-- El primer "select" devuelve el nombre y domicilio de todos los alumnos; el segundo, el nombre y domicilio de todos los profesores.

-- Los encabezados del resultado de una unión son los que se especifican en el primer "select".

 -- ********************* primer problema *********************

--  Un supermercado almacena en una tabla denominada "proveedores" los datos de las compañías que le 
--  proveen de mercaderías; en una tabla llamada "clientes", los datos de los comercios que le compran y 
--  en otra tabla "empleados" los datos de los empleados.
--  1- Elimine las tablas si existen:

  if object_id('clientes') is not null
   drop table clientes;

  if object_id('proveedores') is not null
   drop table proveedores;

  if object_id('empleados') is not null
   drop table empleados;
 
--  2- Cree las tablas:

  create table proveedores(
   codigo int identity,
   nombre varchar (30),
   domicilio varchar(30),
   primary key(codigo)
  );
  create table clientes(
   codigo int identity,
   nombre varchar (30),
   domicilio varchar(30),
   primary key(codigo)
  );
  create table empleados(
   documento char(8) not null,
   nombre varchar(20),
   apellido varchar(20),
   domicilio varchar(30),
   primary key(documento)
  );
 
--  3- Ingrese algunos registros:

  insert into proveedores values('Bebida cola','Colon 123');
  insert into proveedores values('Carnes Unica','Caseros 222');
  insert into proveedores values('Lacteos Blanca','San Martin 987');
  insert into clientes values('Supermercado Lopez','Avellaneda 34');
  insert into clientes values('Almacen Anita','Colon 987');
  insert into clientes values('Garcia Juan','Sucre 345');
  insert into empleados values('23333333','Federico','Lopez','Colon 987');
  insert into empleados values('28888888','Ana','Marquez','Sucre 333');
  insert into empleados values('30111111','Luis','Perez','Caseros 956');
 
--  4- El supermercado quiere enviar una tarjeta de salutación a todos los proveedores, clientes y 
--  empleados y necesita el nombre y domicilio de todos ellos. Emplee el operador "union" para obtener 
--  dicha información de las tres tablas.
  
  select nombre, domicilio from proveedores
   union
   select nombre, domicilio from clientes
    union
    select (apellido+' '+nombre), domicilio from empleados;
 


--  5- Agregue una columna con un literal para indicar si es un proveedor, un cliente o un empleado y 
--  ordene por dicha columna.
 
 
 


  select nombre, domicilio, 'proveedor' as categoria from proveedores
   union
   select nombre, domicilio, 'cliente' from clientes
    union
    select (apellido+' '+nombre), domicilio , 'empleado' from empleados
   order by categoria;
 


-- ********************* segundo problema *********************



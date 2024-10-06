
 
 -------------------------------------------------------------------------------------------------------------------------------
-- 	Ingresar algunos campos (insert into)
 -------------------------------------------------------------------------------------------------------------------------------


-- Hemos aprendido a ingresar registros listando todos los campos y colocando valores para todos y cada uno de ellos luego de "values".

-- Si ingresamos valores para todos los campos, podemos omitir la lista de nombres de los campos.
-- Por ejemplo, si tenemos creada la tabla "libros" con los campos "titulo", "autor" y "editorial", podemos ingresar un registro de la siguiente manera:

--  insert into libros
--   values ('Uno','Richard Bach','Planeta');

-- También es posible ingresar valores para algunos campos. Ingresamos valores solamente para los campos "titulo" y "autor":

--  insert into libros (titulo, autor)
--   values ('El aleph','Borges');

-- SQL Server almacenará el valor "null" en el campo "editorial", para el cual no hemos explicitado un valor.

-- Al ingresar registros debemos tener en cuenta:

-- - la lista de campos debe coincidir en cantidad y tipo de valores con la lista de valores luego de "values". Si se listan más (o menos) campos que los valores ingresados, aparece un mensaje de error y la sentencia no se ejecuta.

-- - si ingresamos valores para todos los campos podemos obviar la lista de campos.

-- - podemos omitir valores para los campos que NO hayan sido declarados "not null", es decir, que permitan valores nulos (se guardará "null"); si omitimos el valor para un campo "not null", la sentencia no se ejecuta.

-- - se DEBE omitir el valor para el campo"identity". Salvo que identity_insert este en on.

-- - se pueden omitir valores para campos declarados "not null" siempre que tengan definido un valor por defecto con la cláusula "default" (tema que veremos a continuación).





-- ********************* primer problema *********************

-- Un banco tiene registrados las cuentas corrientes de sus clientes en una tabla llamada "cuentas".

-- 1- Elimine la tabla "cuentas" si existe:

if object_id('cuentas') is not null
drop table cuentas;



-- 2- Cree la tabla :

 create table cuentas(
  numero int identity,
  documento char(8) not null,
  nombre varchar(30),
  saldo money
 );

-- 3- Ingrese un registro con valores para todos sus campos, inclusive el campo identity, omitiendo la 
-- lista de campos (error, no se debe ingresar para el campo identity):

insert into cuentas values(1, '25147896', 'Laura', 1500.34);

-- 4- Ingrese un registro con valores para todos sus campos omitiendo la lista de campos (excepto el 
-- campo "identity"):

insert into cuentas values('25147896', 'Laura', 1500.34);


-- 5- Ingrese un registro omitiendo algún campo que admitan valores nulos.
insert into cuentas(documento, saldo) values('25147896', 1500.34);



-- 6- Intente ingresar un registro con valor para el campo "numero" (error):

 insert into cuentas (numero,documento,nombre,saldo)
  values (5,'28999777','Luis Lopez',34000);

-- 7- Intente ingresar un registro listando 3 campos y colocando 4 valores (error)

 insert into cuentas (numero,documento,nombre)
  values (3344,'28999777','Luis Lopez',34000);


-- 8- Intente ingresar un registro sin valor para el campo "documento" (error)
 insert into cuentas (nombre, saldo)
  values ('Luis Lopez',34000);


-- 9- Vea los registros ingresados:
 select * from libros;














-- ********************* Segundo problema *********************



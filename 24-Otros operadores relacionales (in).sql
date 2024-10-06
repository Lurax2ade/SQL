
 
 
 -------------------------------------------------------------------------------------------------------------------------------
-- Otros operadores relacionales (in)
 -------------------------------------------------------------------------------------------------------------------------------


-- Se utiliza "in" para averiguar si el valor de un campo está incluido en una lista de valores especificada.

-- En la siguiente sentencia usamos "in" para averiguar si el valor del campo autor está incluido en la lista de valores especificada (en este caso, 2 cadenas).

-- Hasta ahora, para recuperar los libros cuyo autor sea 'Paenza' o 'Borges' usábamos 2 condiciones:

--  select *from libros
--   where autor='Borges' or autor='Paenza';

-- Podemos usar "in" y simplificar la consulta:

--  select * from libros
--   where autor in('Borges','Paenza');

-- Para recuperar los libros cuyo autor no sea 'Paenza' ni 'Borges' usábamos:

--  select * from libros
--   where autor<>'Borges' and
--   autor<>'Paenza';

-- También podemos usar "in" anteponiendo "not":

--  select * from libros
--   where autor not in ('Borges','Paenza');

-- Empleando "in" averiguamos si el valor del campo está incluido en la lista de valores especificada; con "not" antecediendo la condición, invertimos el resultado, es decir, recuperamos los valores que no se encuentran (coindicen) con la lista de valores.

-- Los valores "null" no se consideran.

-- Recuerde: siempre que sea posible, emplee condiciones de búsqueda positivas ("in"), evite las negativas ("not in") porque con ellas se evalún todos los registros y esto hace más lenta la recuperación de los datos.



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
  precio decimal(6,2),
  cantidad tinyint,
  fechavencimiento datetime not null,
  primary key(codigo)
 );

-- 3- Ingrese algunos registros:

 insert into medicamentos
  values('Sertal','Roche',5.2,1,'2015-02-01');

 insert into medicamentos 
  values('Buscapina','Roche',4.10,3,'2016-03-01');

 insert into medicamentos 
  values('Amoxidal 500','Bayer',15.60,100,'2017-05-01');

 insert into medicamentos
  values('Paracetamol 500','Bago',1.90,20,'2018-02-01');

 insert into medicamentos 
  values('Bayaspirina','Bayer',2.10,150,'2019-12-01'); 

 insert into medicamentos 
  values('Amoxidal jarabe','Bayer',5.10,250,'2020-10-01'); 

-- 4- Recupere los nombres y precios de los medicamentos cuyo laboratorio sea "Bayer" o "Bago" 
-- empleando el operador "in" (4 registros)


select nombre, precio from medicamentos 

where laboratorio in ('Bayer', 'Bago');

-- 5- Seleccione los remedios cuya cantidad se encuentre entre 1 y 5 empleando el operador "between" y 
-- luego el operador "in" (2 registros):



-- Note que es más conveniente emplear, en este caso, el operador ""between"".

 select * from medicamentos
  where cantidad in (1,2,3,4,5);




-- ********************* Segundo problema *********************


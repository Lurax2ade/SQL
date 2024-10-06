
 
 -------------------------------------------------------------------------------------------------------------------------------
--	Eliminar y dasasociar reglas (sp_unbindrule - drop rule)
 -------------------------------------------------------------------------------------------------------------------------------

--  Para eliminar una regla, primero se debe deshacer la asociación, ejecutando el procedimiento almacenado del sistema "sp_unbindrule":

--  exec sp_unbindrule 'TABLA.CAMPO';

-- No es posible eliminar una regla si está asociada a un campo. Si intentamos hacerlo, aparece un mensaje de error y la eliminación no se realiza.

-- Con la instrucción "drop rule" eliminamos la regla:

--  drop rule NOMBREREGLA;

-- Quitamos la asociación de la regla "RG_sueldo_intervalo" con el campo "sueldo" de la tabla "empleados" tipeando:

--  exec sp_unbindrule 'empleados.sueldo';

-- Luego de quitar la asociación la eliminamos:

--  drop rule RG_sueldo_100a1000;

-- Si eliminamos una tabla, las asociaciones de reglas de sus campos desaparecen, pero las reglas siguen existiendo. 

-- ********************* primer problema *********************

-- Una playa de estacionamiento almacena cada día los datos de los vehículos que ingresan en la tabla 
-- llamada "vehiculos".
-- 1- Elimine la tabla, si existe:


--  if object_id('vehiculos') is not null
--   drop table vehiculos;

-- 2- Elimine las siguientes reglas, si existen:

 if object_id ('RG_patente_patron') is not null
   drop rule RG_patente_patron;

 if object_id ('RG_vehiculos_tipo') is not null
   drop rule RG_vehiculos_tipo;

 if object_id ('RG_vehiculos_tipo2') is not null
   drop rule RG_vehiculos_tipo2;

-- 3- Cree la tabla:

 create table vehiculos(
  patente char(6) not null,
  tipo char(1),--'a'=auto, 'm'=moto
  horallegada datetime not null,
  horasalida datetime
 );

-- 4- Cree una regla para restringir los valores que se pueden ingresar en un campo "patente" (3 letras 
-- seguidas de 3 dígitos):

-- create rule RG_vehiculos_patente
-- as @patente like'[A-Z][A-Z][A-Z][0-9][0-9][0-9]';


-- 5-Asocie la regla al campo "patente":

exec sp_bindrule RG_patente_patron, 'vehiculos.patente';



-- 6- Intente ingresar un registro con valor para el campo "patente" que no cumpla con la regla:


 insert into vehiculos values ('FGHIJK','a','1990-02-01 18:00',null);

-- aparece un mensaje de error indicando que hay conflicto con la regla y la inserción no se realiza.



-- 7- Cree otra regla que controle los valores para el campo "tipo" para que solamente puedan 
-- ingresarse los caracteres "a" y "m":

-- create rule RG_vehiculos_tipo
-- as@tipo in ('a', 'm');



-- 8- Asocie la regla al campo "tipo":

exec sp_bindrule RG_vehiculos_tipo, 'vehiculos.tipo';


-- 9- Intente ingresar un registro con el valor 'c' para "tipo":

 insert into vehiculos values('AAA111','c','2001-10-10 10:10',NULL);
-- No lo permite.

-- 10- Cree otra regla llamada "RG_vehiculos_tipo2" que controle los valores para el campo "tipo" para 
-- que solamente puedan ingresarse los caracteres "a", "c" y "m":



--  create rule RG_vehiculos_tipo2
--  as @tipo in ('a','c','m');

-- 11- Si la asociamos a un campo que ya tiene asociada otra regla, la nueva regla reeemplaza la 
-- asociación anterior. Asocie la regla creada en el punto anterior al campo "tipo".

    exec sp_bindrule RG_vehiculos_tipo2, 'vehiculos.tipo';

-- 12- Ingrese el registro que no pudo ingresar en el punto 9.

 insert into vehiculos values('AAA111','c','2001-10-10 10:10',NULL);


-- 13- Intente eliminar la regla "RG_vehiculos_tipo2".
-- No es posible porque está asociada a un campo de "vehiculos".


 drop rule RG_vehiculos_tipo2;


-- 14- Elimine la regla "RG_vehiculos_tipo".
-- Es posible porque no está asociada a ningún campo.

 drop rule RG_vehiculos_tipo;


-- 15- Intente eliminar la regla "RG_patente_patron".
-- No es posible porque está asociada.
 drop rule RG_patente_patron;



-- 16- Quite la asociación de la regla con el campo "patente" de "vehiculos".


exec sp_unbindrule 'vehiculos.patente';

-- 17- Vea si la regla "RG_patente_patron" está asociada a algún campo de "vehiculos".
-- No lo está.
 exec sp_helpconstraint vehiculos;



-- 18- Verifique que la regla aún existe en la base de datos activa:
 exec sp_help;
-- aparece la regla.



-- 19- Elimine la regla que no pudo eliminar en el punto 15.

 drop rule RG_patente_patron;


-- 20- Verifique que la regla ya no existe en la base de datos activa.
-- No aparece la regla "RG_patente_patron".


 exec sp_help;




-- ********************* segundo problema *********************

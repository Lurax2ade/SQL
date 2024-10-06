
-- -- --  -------------------------------------------------------------------------------------------------------------------------------
-- -- -- --	Restricciones foreign key deshabilitar y eliminar (with check - nocheck)
-- -- --  -------------------------------------------------------------------------------------------------------------------------------

-- -- Sabemos que si agregamos una restricción a una tabla que contiene datos, SQL Server los controla para asegurarse que cumplen con la restricción; 
-- --es posible deshabilitar esta comprobación.

-- -- Podemos hacerlo al momento de agregar la restricción a una tabla con datos, incluyendo la opción "with nocheck" en la instrucción "alter table"; 
-- --si se emplea esta opción, los datos no van a cumplir la restricción.

-- -- Se pueden deshabilitar las restricciones "check" y "foreign key", a las demás se las debe eliminar.

-- -- La sintaxis básica al agregar la restriccción "foreign key" es la siguiente:

-- --  alter table NOMBRETABLA1
-- --   with OPCIONDECHEQUEO
-- --   add constraint NOMBRECONSTRAINT
-- --   foreign key (CAMPOCLAVEFORANEA)
-- --   references NOMBRETABLA2 (CAMPOCLAVEPRIMARIA)
-- --   on update OPCION
-- --   on delete OPCION;

-- -- La opción "with OPCIONDECHEQUEO" especifica si se controlan los datos existentes o no con "check" y "nocheck" respectivamente. Por defecto, si no se especifica, la opción es "check".

-- -- En el siguiente ejemplo agregamos una restricción "foreign key" que controla que todos los códigos de editorial tengan un código válido, es decir, dicho código exista en "editoriales". La restricción no se aplica en los datos existentes pero si en los siguientes ingresos, modificaciones y actualizaciones:

-- --  alter table libros
-- --  with nocheck
-- --  add constraint FK_libros_codigoeditorial
-- --  foreing key (codigoeditorial)
-- --  references editoriales(codigo);

-- -- La comprobación de restricciones se puede deshabilitar para modificar, eliminar o agregar datos a una tabla sin comprobar la restricción. La sintaxis general es:

-- --  alter table NOMBRETABLA
-- --  OPCIONDECHEQUEO constraint NOMBRERESTRICCION;

-- -- En el siguiente ejemplo deshabilitamos la restricción creada anteriormente:

-- --  alter table libros
-- --  nocheck constraint FK_libros_codigoeditorial;

-- -- Para habilitar una restricción deshabilitada se ejecuta la misma instrucción pero con la cláusula "check" o "check all":

-- --  alter table libros
-- --   check constraint FK_libros_codigoeditorial;

-- -- Si se emplea "check constraint all" no se coloca nombre de restricciones, habilita todas las restricciones que tiene la tabla nombrada ("check" y "foreign key").

-- -- Para saber si una restricción está habilitada o no, podemos ejecutar el procedimiento almacenado "sp_helpconstraint" y entenderemos lo que informa la columna "status_enabled".

-- -- Entonces, las cláusulas "check" y "nocheck" permiten habilitar o deshabilitar restricciones "foreign key" (y "check"). Pueden emplearse para evitar la comprobación de datos existentes al crear la restricción o para deshabilitar la comprobación de datos al ingresar, actualizar y eliminar algún registro que infrinja la restricción.

-- -- Podemos eliminar una restricción "foreign key" con "alter table". La sintaxis básica es la misma que para cualquier otra restricción:

-- --  alter table TABLA
-- --   drop constraint NOMBRERESTRICCION;

-- -- Eliminamos la restricción de "libros":

-- --  alter table libros
-- --   drop constraint FK_libros_codigoeditorial;

-- -- No se puede eliminar una tabla si una restricción "foreign key" hace referencia a ella.

-- -- Cuando eliminamos una tabla que tiene una restricción "foreign key", la restricción también se elimina.

-- -- -- -- ********************* primer problema *********************

-- -- -- Una empresa tiene registrados sus clientes en una tabla llamada "clientes", también tiene una tabla 
-- -- -- "provincias" donde registra los nombres de las provincias.


-- -- -- 1- Elimine las tablas "clientes" y "provincias", si existen:

-- if object_id('clientes') is not null
-- drop tabel clientes;


-- if object_id('provincias') is not null
-- drop tabel previncias;



-- -- -- 2- Créelas con las siguientes estructuras:

--  create table clientes (
--   codigo int identity,
--   nombre varchar(30),
--   domicilio varchar(30),
--   ciudad varchar(20),
--   codigoprovincia tinyint,
--   primary key(codigo)
--  );
--  create table provincias(
--   codigo tinyint,
--   nombre varchar(20),
--   primary key (codigo)
--  );

-- -- -- 3- Ingrese algunos registros para ambas tablas:

--  insert into provincias values(1,'Cordoba');
--  insert into provincias values(2,'Santa Fe');
--  insert into provincias values(3,'Misiones');
--  insert into provincias values(4,'Rio Negro');

--  insert into clientes values('Perez Juan','San Martin 123','Carlos Paz',1);
--  insert into clientes values('Moreno Marcos','Colon 234','Rosario',2);
--  insert into clientes values('Garcia Juan','Sucre 345','Cordoba',1);
--  insert into clientes values('Lopez Susana','Caseros 998','Posadas',3);
--  insert into clientes values('Marcelo Moreno','Peru 876','Viedma',4);
--  insert into clientes values('Lopez Sergio','Avellaneda 333','La Plata',5);

-- -- -- 4- Intente agregar una restricción "foreign key" para que los códigos de provincia de "clientes" 
-- -- -- existan en "provincias" con acción en cascada para actualizaciones y eliminaciones, sin especificar 
-- -- -- la opción de comprobación de datos:

-- alter table clientes
-- add constraint FK_clientes_codigoprovincia
-- foreing key(codigoprovincia)
-- references provincias(codigo)
-- on update cascade
-- on delete cascade;


-- -- -- No se puede porque al no especificar opción para la comprobación de datos, por defecto es "check" y 
-- -- -- hay un registro que no cumple con la restricción.

-- -- -- 5- Agregue la restricción anterior pero deshabilitando la comprobación de datos existentes:

-- alter table clientes
-- with nocheck
-- add constraint FK_clientes_codigoprovincia
-- foreing key(codigoprovincia)
-- references provincias(codigo)
-- on update cascade
-- on delete cascade;



-- -- -- 6- Vea las restricciones de "clientes":

-- exec sp_helpconstraint clientes;

-- -- Aparece la restricción "primary key" y "foreign key", las columnas "delete_action" y "update_action" 
-- -- contienen "cascade" y la columna "status_enabled" contiene "Enabled".

-- -- 7- Vea las restricciones de "provincias":

--  exec sp_helpconstraint provincias;

-- -- Aparece la restricción "primary key" y la referencia a esta tabla de la restricción "foreign key" de 
-- -- la tabla "clientes".

-- -- 8- Deshabilite la restricción "foreign key" de "clientes":


--  alter table clientes
--   nocheck constraint FK_clientes_codigoprovincia;


-- -- 9- Vea las restricciones de "clientes":

--  exec sp_helpconstraint clientes;
-- -- la restricción "foreign key" aparece inhabilitada.

-- -- 10- Vea las restricciones de "provincias":
--  exec sp_helpconstraint provincias;
-- -- informa que la restricción "foreign key" de "clientes" hace referencia a ella, aún cuando está 
-- -- deshabilitada.

-- -- 11- Agregue un registro que no cumpla la restricción "foreign key":
--  insert into clientes values('Garcia Omar','San Martin 100','La Pampa',6);
-- -- Se permite porque la restricción está deshabilitada.

-- -- 12- Elimine una provincia de las cuales haya clientes:
--  delete from provincias where codigo=2;

-- -- 13- Corrobore que el registro se eliminó de "provincias" pero no se extendió a "clientes":
--  select * from clientes;
--  select * from provincias;

-- -- 14- Modifique un código de provincia de la cual haya clientes:
--  update provincias set codigo=9 where codigo=3;

-- -- 15- Verifique que el cambio se realizó en "provincias" pero no se extendió a "clientes":
--  select * from clientes;
--  select * from provincias;

-- -- 16- Intente eliminar la tabla "provincias":
--  drop table provincias;
-- -- No se puede porque la restricción "FK_clientes_codigoprovincia" la referencia, aunque esté deshabilitada.

-- -- 17- Habilite la restricción "foreign key":

-- alter table clientes
-- check FK_clientes_codigoprovincia;

-- -- 18- Intente agregar un cliente con código de provincia inexistente en "provincias":
--  insert into clientes values('Hector Ludueña','Paso 123','La Plata',8);
-- -- No se puede.

-- -- 19- Modifique un código de provincia al cual se haga referencia en "clientes":
--  update provincias set codigo=20 where codigo=4;
-- -- Actualización en cascada.

-- -- 20- Vea que se modificaron en ambas tablas:
--  select * from clientes;
--  select * from provincias;

-- -- 21- Elimine una provincia de la cual haya referencia en "clientes":
--  delete from provincias where codigo=1;
-- -- Acción en cascada.

-- -- 22- Vea que los registros de ambas tablas se eliminaron:
--  select * from clientes;
--  select * from provincias;

-- -- 23- Elimine la restriccion "foreign key":

-- alter table clientes
-- drop constraint FK_clientes_codigoprovincia;

-- -- 24- Vea las restriciones de la tabla "provincias":
--  exec sp_helpconstraint provincias;
-- -- Solamente aparece la restricción "primary key", ya no hay una "foreign key" que la referencie.

-- -- 25- Elimine la tabla "provincias":
--  drop table provincias;
-- -- Puede eliminarse porque no hay restricción "foreign key" que la referencie.






-- -- -- -- ********************* segundo problema *********************

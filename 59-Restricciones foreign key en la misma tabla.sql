
 
--  -------------------------------------------------------------------------------------------------------------------------------
-- --	Restricciones foreign key en la misma tabla
--  -------------------------------------------------------------------------------------------------------------------------------
-- -- La restricción "foreign key", que define una referencia a un campo con una restricción "primary key" o "unique" se puede definir entre distintas tablas (como hemos aprendido) o dentro de la misma tabla.

-- -- Veamos un ejemplo en el cual definimos esta restricción dentro de la misma tabla.

-- -- Una mutual almacena los datos de sus afiliados en una tabla llamada "afiliados". Algunos afiliados inscriben a sus familiares. La tabla contiene un campo que hace referencia al afiliado que lo incorporó a la mutual, del cual dependen.

-- -- La estructura de la tabla es la siguiente:

-- --  create table afiliados(
-- --   numero int identity not null,
-- --   documento char(8) not null,
-- --   nombre varchar(30),
-- --   afiliadotitular int,
-- --   primary key (documento),
-- --   unique (numero)
-- --  );

-- -- En caso que un afiliado no haya sido incorporado a la mutual por otro afiliado, el campo "afiliadotitular" almacenará "null".

-- -- Establecemos una restricción "foreign key" para asegurarnos que el número de afiliado que se ingrese en el campo "afiliadotitular" exista en la tabla "afiliados":

-- --  alter table afiliados
-- --   add constraint FK_afiliados_afiliadotitular
-- --   foreign key (afiliadotitular)
-- --   references afiliados (numero);

-- -- La sintaxis es la misma, excepto que la tabla se autoreferencia.

-- -- Luego de aplicar esta restricción, cada vez que se ingrese un valor en el campo "afiliadotitular", SQL Server controlará que dicho número exista en la tabla, si no existe, mostrará un mensaje de error.

-- -- Si intentamos eliminar un afiliado que es titular de otros afiliados, no se podrá hacer, a menos que se haya especificado la acción en cascada (próximo tema).


-- -- ********************* primer problema *********************

-- -- Una empresa registra los datos de sus clientes en una tabla llamada "clientes". Dicha tabla contiene 
-- -- un campo que hace referencia al cliente que lo recomendó denominado "referenciadopor". Si un cliente 
-- -- no ha sido referenciado por ningún otro cliente, tal campo almacena "null".
-- -- 1- Elimine la tabla si existe y créela:

-- if object_ id('clientes') is not null
-- drop table clientes;


--  create table clientes(
--   codigo int not null,
--   nombre varchar(30),
--   domicilio varchar(30),
--   ciudad varchar(20),
--   referenciadopor int,
--   primary key(codigo)
--  );

-- -- 2- Ingresamos algunos registros:

--  insert into clientes values (50,'Juan Perez','Sucre 123','Cordoba',null);
--  insert into clientes values(90,'Marta Juarez','Colon 345','Carlos Paz',null);
--  insert into clientes values(110,'Fabian Torres','San Martin 987','Cordoba',50);
--  insert into clientes values(125,'Susana Garcia','Colon 122','Carlos Paz',90);
--  insert into clientes values(140,'Ana Herrero','Colon 890','Carlos Paz',9);

-- -- 3- Intente agregar una restricción "foreign key" para evitar que en el campo "referenciadopor" se 
-- -- ingrese un valor de código de cliente que no exista.
-- -- No se permite porque existe un registro que no cumple con la restricción que se intenta establecer.

-- alter table clientes
-- add constraint FK_clientes_referenciadopor
-- foreing kay(referenciadopor)
-- references clientes(codigo);

-- -- 4- Cambie el valor inválido de "referenciadopor" del registro que viola la restricción por uno 
-- -- válido.

-- update clientes set referenciadopor=90 where referenciadopor = 9;


-- -- 5- Agregue la restricción "foreign key" que intentó agregar en el punto 3.

-- alter table clientes
-- add constraint FK_clientes_referenciadopor
-- foreing key (referenciadopor)
-- references clientes (codigo);

-- -- 6- Vea la información referente a las restricciones de la tabla "clientes".
-- exec sp_helpconstraint clientes;

-- -- 7- Intente agregar un registro que infrinja la restricción.
-- -- No lo permite.

--  insert into clientes values(150,'Karina Gomez','Caseros 444','Cruz del Eje',8);

-- -- 8- Intente modificar el código de un cliente que está referenciado en "referenciadopor".
-- -- No se puede.

-- update clientes set coigo=180 where codigo=90;

-- -- 9- Intente eliminar un cliente que sea referenciado por otro en "referenciadopor".
-- -- No se puede.

-- delete from clientes where nombre='Marta Juarez';

-- -- 10- Cambie el valor de código de un cliente que no referenció a nadie.

--  update clientes set codigo=180 where codigo=125;
 
-- -- 11- Elimine un cliente que no haya referenciado a otros.


--  delete from clientes where codigo=110;



-- -- ********************* segundo problema *********************

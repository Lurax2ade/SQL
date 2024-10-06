
--  -------------------------------------------------------------------------------------------------------------------------------
-- --	Restricciones (foreign key)
--  -------------------------------------------------------------------------------------------------------------------------------

-- -- Hemos visto que una de las alternativas que SQL Server ofrece para asegurar la integridad de datos es el uso de restricciones (constraints). Aprendimos que las restricciones se establecen en tablas y campos asegurando que los datos sean válidos y que las relaciones entre las tablas se mantengan; vimos que existen distintos tipos de restricciones:

-- -- 1) de los campos: default y check
-- -- 2) de la tabla: primary key y unique.
-- -- 3) referencial: foreign key, la analizaremos ahora.

-- -- Con la restricción "foreign key" se define un campo (o varios) cuyos valores coinciden con la clave primaria de la misma tabla o de otra, es decir, se define una referencia a un campo con una restricción "primary key" o "unique" de la misma tabla o de otra.

-- -- La integridad referencial asegura que se mantengan las referencias entre las claves primarias y las externas. Por ejemplo, controla que si se agrega un código de editorial en la tabla "libros", tal código exista en la tabla "editoriales".

-- -- También controla que no pueda eliminarse un registro de una tabla ni modificar la clave primaria si una clave externa hace referencia al registro. Por ejemplo, que no se pueda eliminar o modificar un código de "editoriales" si existen libros con dicho código.

-- -- La siguiente es la sintaxis parcial general para agregar una restricción "foreign key":

-- --  alter table NOMBRETABLA1
-- --   add constraint NOMBRERESTRICCION
-- --   foreign key (CAMPOCLAVEFORANEA)
-- --   references NOMBRETABLA2 (CAMPOCLAVEPRIMARIA);

-- -- Analicémosla:

-- -- - NOMBRETABLA1 referencia el nombre de la tabla a la cual le aplicamos la restricción,

-- -- - NOMBRERESTRICCION es el nombre que le damos a la misma,

-- -- - luego de "foreign key", entre paréntesis se coloca el campo de la tabla a la que le aplicamos la restricción que será establecida como clave foránea,

-- -- - luego de "references" indicamos el nombre de la tabla referenciada y el campo que es clave primaria en la misma, a la cual hace referencia la clave foránea. La tabla referenciada debe tener definida una restricción "primary key" o "unique"; si no la tiene, aparece un mensaje de error.

-- -- Para agregar una restricción "foreign key" al campo "codigoeditorial" de "libros", tipeamos:

-- --  alter table libros
-- --  add constraint FK_libros_codigoeditorial
-- --   foreign key (codigoeditorial)
-- --   references editoriales(codigo);

-- -- En el ejemplo implementamos una restricción "foreign key" para asegurarnos que el código de la editorial de la tabla "libros" ("codigoeditorial") esté asociada con un código válido en la tabla "editoriales" ("codigo").

-- -- Cuando agregamos cualquier restricción a una tabla que contiene información, SQL Server controla los datos existentes para confirmar que cumplen con la restricción, si no los cumple, la restricción no se aplica y aparece un mensaje de error. Por ejemplo, si intentamos agregar una restricción "foreign key" a la tabla "libros" y existe un libro con un valor de código para editorial que no existe en la tabla "editoriales", la restricción no se agrega.

-- -- Actúa en inserciones. Si intentamos ingresar un registro (un libro) con un valor de clave foránea (codigoeditorial) que no existe en la tabla referenciada (editoriales), SQL server muestra un mensaje de error. Si al ingresar un registro (un libro), no colocamos el valor para el campo clave foránea (codigoeditorial), almacenará "null", porque esta restricción permite valores nulos (a menos que se haya especificado lo contrario al definir el campo).

-- -- Actúa en eliminaciones y actualizaciones. Si intentamos eliminar un registro o modificar un valor de clave primaria de una tabla si una clave foránea hace referencia a dicho registro, SQL Server no lo permite (excepto si se permite la acción en cascada, tema que veremos posteriormente). Por ejemplo, si intentamos eliminar una editorial a la que se hace referencia en "libros", aparece un mensaje de error.

-- -- Esta restricción (a diferencia de "primary key" y "unique") no crea índice automaticamente.

-- -- La cantidad y tipo de datos de los campos especificados luego de "foreign key" DEBEN coincidir con la cantidad y tipo de datos de los campos de la cláusula "references".

-- -- Esta restricción se puede definir dentro de la misma tabla (lo veremos más adelante) o entre distintas tablas.

-- -- Una tabla puede tener varias restricciones "foreign key".

-- -- No se puede eliminar una tabla referenciada en una restricción "foreign key", aparece un mensaje de error.

-- -- Una restriccion "foreign key" no puede modificarse, debe eliminarse y volverse a crear.

-- -- Para ver información acerca de esta restricción podemos ejecutar el procedimiento almacenado "sp_helpconstraint" junto al nombre de la tabla. Nos muestra el tipo, nombre, la opción para eliminaciones y actualizaciones, el estado (temas que veremos más adelante), el nombre del campo y la tabla y campo que referencia.

-- -- También informa si la tabla es referenciada por una clave foránea.

-- -- ********************* primer problema *********************


-- -- Una empresa tiene registrados sus clientes en una tabla llamada "clientes", también tiene una tabla 
-- -- "provincias" donde registra los nombres de las provincias.

-- -- 1- Elimine las tablas "clientes" y "provincias", si existen y créelas:

-- if object_id ('clientes') is not null
-- drop table clientes;

-- if object_id ('provincias') is not null
-- drop table provincias;



--  create table clientes (
--   codigo int identity,
--   nombre varchar(30),
--   domicilio varchar(30),
--   ciudad varchar(20),
--   codigoprovincia tinyint
--  );

--  create table provincias(
--   codigo tinyint not null,
--   nombre varchar(20)
--  );

-- -- En este ejemplo, el campo "codigoprovincia" de "clientes" es una clave foránea, se emplea para 
-- -- enlazar la tabla "clientes" con "provincias".

-- -- 2- Intente agregar una restricción "foreign key" a la tabla "clientes" que haga referencia al campo 
-- -- "codigo" de "provincias":

-- alter table clientes
-- add constraint FK_clientes_codigoprovincia
-- foreing key(codigoprovincia)
-- references provincias(codigo);

-- -- No se puede porque "provincias" no tiene restricción "primary key" ni "unique".

-- -- 3- Establezca una restricción "primary key" al campo "codigo" de "provincias":

-- alter table provincias
-- add constraint PK_provincias_codigo
-- primary key(codigo);


-- -- 4- Ingrese algunos registros para ambas tablas:

--  insert into provincias values(1,'Cordoba');
--  insert into provincias values(2,'Santa Fe');
--  insert into provincias values(3,'Misiones');
--  insert into provincias values(4,'Rio Negro');

--  insert into clientes values('Perez Juan','San Martin 123','Carlos Paz',1);
--  insert into clientes values('Moreno Marcos','Colon 234','Rosario',2);
--  insert into clientes values('Acosta Ana','Avellaneda 333','Posadas',3);
--  insert into clientes values('Luisa Lopez','Juarez 555','La Plata',6);

-- -- 5- Intente agregar la restricción "foreign key" del punto 2 a la tabla "clientes":
-- alter table clientes
-- add constraint FK_clientes_codigoprovincia
-- foreing key(codigoprovincia)
-- references provincias (codigo);


-- -- No se puede porque hay un registro en "clientes" cuyo valor de "codigoprovincia" no existe en 
-- -- "provincias".

-- -- 6- Elimine el registro de "clientes" que no cumple con la restricción y establezca la restricción 
-- -- nuevamente:


-- delete from clientes where codigoprovincia=6;

-- alter table clientes
-- add constraint FK_clientes_codigoprovincia
-- foreing key(codigoprovincia)
-- references provincias (codigo);





-- -- 7- Intente agregar un cliente con un código de provincia inexistente en "provincias".
-- -- No se puede.
--  insert into clientes values('Garcia Marcos','Colon 877','Lules',9);

-- -- 8- Intente eliminar el registro con código 3, de "provincias".
-- -- No se puede porque hay registros en "clientes" al cual hace referencia.

-- delete from provincias where codigo=3;

-- -- 9- Elimine el registro con código "4" de "provincias".
-- -- Se permite porque en "clientes" ningún registro hace referencia a él.
-- delete from provincias where codigo=4;

-- -- 10- Intente modificar el registro con código 1, de "provincias".
-- -- No se puede porque hay registros en "clientes" al cual hace referencia.

-- update provincias set codigo=7 where codigo=!;

-- -- 11- Vea las restricciones de "clientes".
-- -- aparece la restricción "foreign key".


-- exec sp_helpconstraint clientes;

-- -- 12- Vea las restricciones de "provincias".
-- -- aparece la restricción "primary key" y nos informa que la tabla es rerenciada por una "foreign key" 
-- -- de la tabla "clientes" llamada "FK_clientes_codigoprovincia".
--  exec sp_helpconstraint provincias;





-- -- ********************* segundo problema *********************

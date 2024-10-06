
 -------------------------------------------------------------------------------------------------------------------------------
-- 	Restricción unique
 -------------------------------------------------------------------------------------------------------------------------------


-- Hemos visto que las restricciones aplicadas a tablas aseguran valores únicos para cada registro.
-- Anteriormente aprendimos la restricción "primary key", otra restricción para las tablas es "unique".

-- La restricción "unique" impide la duplicación de claves alternas (no primarias), es decir, especifica que dos registros no puedan tener el mismo valor en un campo. Se permiten valores nulos. Se pueden aplicar varias restricciones de este tipo a una misma tabla, y pueden aplicarse a uno o varios campos que no sean clave primaria.

-- Se emplea cuando ya se estableció una clave primaria (como un número de legajo) pero se necesita asegurar que otros datos también sean únicos y no se repitan (como número de documento).

-- La sintaxis general es la siguiente:

--  alter table NOMBRETABLA
--  add constraint NOMBRERESTRICCION
--  unique (CAMPO);

-- Ejemplo:

--  alter table alumnos
--   add constraint UQ_alumnos_documento
--   unique (documento);

-- En el ejemplo anterior se agrega una restricción "unique" sobre el campo "documento" de la tabla "alumnos", esto asegura que no se pueda ingresar un documento si ya existe. Esta restricción permite valores nulos, asi que si se ingresa el valor "null" para el campo "documento", se acepta.

-- Por convención, cuando demos el nombre a las restricciones "unique" seguiremos la misma estructura: "UQ_NOMBRETABLA_NOMBRECAMPO". Quizá parezca innecesario colocar el nombre de la tabla, pero cuando empleemos varias tablas verá que es útil identificar las restricciones por tipo, tabla y campo.

-- Recuerde que cuando agregamos una restricción a una tabla que contiene información, SQL Server controla los datos existentes para confirmar que cumplen la condición de la restricción, si no los cumple, la restricción no se aplica y aparece un mensaje de error. En el caso del ejemplo anterior, si la tabla contiene números de documento duplicados, la restricción no podrá establecerse; si podrá establecerse si tiene valores nulos.

-- SQL Server controla la entrada de datos en inserciones y actualizaciones evitando que se ingresen valores duplicados.



-- ********************* primer problema *********************

-- Una empresa de remises tiene registrada la información de sus vehículos en una tabla llamada 
-- "remis".

-- 1- Elimine la tabla si existe:

if object_id('remis') is not null
drop table remis;

-- 2- Cree la tabla con la siguiente estructura:

 create table remis(
  numero tinyint identity,
  patente char(6),
  marca varchar(15),
  modelo char(4)
 );

-- 3- Ingrese algunos registros, 2 de ellos con patente repetida y alguno con patente nula:

insert into remis values('ADF124', 'cITROEN 78', '2016');

 insert into remis values('ABC123','Renault clio','1990');

 insert into remis values('DEF456','Peugeot 504','1995');

 insert into remis values('DEF456','Fiat Duna','1998');

 insert into remis values('GHI789','Fiat Duna','1995');

 insert into remis values(null,'Fiat Duna','1995');


-- 4- Intente agregar una restricción "unique" para asegurarse que la patente del remis no tomará 
-- valores repetidos.
-- No se puede porque hay valores duplicados.

alter table remis
add constraint UQ_remis_patente
unique(Patente);

-- 5- Elimine el registro con patente duplicada y establezca la restricción.
-- Note que hay 1 registro con valor nulo en "patente".

delete from remis where numero=3;

alter table remis
add constraint UQ_remis_patente
 unique(patente); 

-- 6- Intente ingresar un registro con patente repetida (no lo permite)

 insert into remis values('ABC123','Renault 11','1995');

-- 7- Intente ingresar un registro con valor nulo para el campo "patente".
-- No lo permite porque la clave estaría duplicada.

 insert into remis values(null,'Renault 11','1995');


-- 8- Muestre la información de las restricciones:
exec sp_helpconstraint remis;






-- ********************* Segundo problema *********************



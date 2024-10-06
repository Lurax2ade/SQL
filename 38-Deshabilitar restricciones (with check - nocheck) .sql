
  
 -------------------------------------------------------------------------------------------------------------------------------
-- 	Deshabilitar restricciones (with check - nocheck) 
 -------------------------------------------------------------------------------------------------------------------------------


-- Sabemos que si agregamos una restricción a una tabla que contiene datos, SQL Server los controla para asegurarse que cumplen con la condición de la restricción, si algún registro no la cumple, la restricción no se establecece.

-- Es posible deshabilitar esta comprobación en caso de restricciones "check".

-- Podemos hacerlo cuando agregamos la restricción "check" a una tabla para que SQL Server acepte los valores ya almacenados que infringen la restricción. Para ello debemos incluir la opción "with nocheck" en la instrucción "alter table":

--  alter table libros
--   with nocheck
--   add constraint CK_libros_precio
--   check (precio>=0);

-- La restricción no se aplica en los datos existentes, pero si intentamos ingresar un nuevo valor que no cumpla la restricción, SQL Server no lo permite.

-- Entonces, para evitar la comprobación de datos existentes al crear la restricción, la sintaxis básica es la siguiente:

--  alter table TABLA
--   with nocheck
--   add constraint NOMBRERESTRICCION
--   check (CONDICION);

-- Por defecto, si no especificamos, la opción es "with check".

-- También podemos deshabilitar las restricciones para agregar o actualizar datos sin comprobarla:

--  alter table libros
--   nocheck constraint CK_libros_precio;

-- En el ejemplo anterior deshabilitamos la restricción "CK_libros_precio" para poder ingresar un valor negativo para "precio".

-- Para habilitar una restricción deshabilitada se ejecuta la misma instrucción pero con la cláusula "check" o "check all":

--  alter table libros
--   check constraint CK_libros_precio;

-- Si se emplea "check constraint all" no se coloca nombre de restricciones, habilita todas las restricciones que tiene la tabla nombrada.

-- Para habilitar o deshabilitar restricciones la comprobación de datos en inserciones o actualizaciones, la sintaxis básica es:

--  alter table NOMBRETABLA
--   OPCIONdeRESTRICCION constraint NOMBRERESTRICCION;

-- Para saber si una restricción está habilitada o no, podemos ejecutar el procedimiento almacenado "sp_helpconstraint" y fijarnos lo que informa la columna "status_enabled".

-- Entonces, las cláusulas "check" y "nocheck" permiten habilitar o deshabilitar restricciones "check" (también las restricciones "foreign key" que veremos más adelante), a las demás se las debe eliminar ("default" y las que veremos posteriormente).



-- ********************* primer problema *********************


-- Una empresa tiene registrados datos de sus empleados en una tabla llamada "empleados".
-- 1- Elimine la tabla (si existe):

if object_id('empleados') is not null
drop table empleados;


-- 2- Créela con la siguiente estructura e ingrese los registros siguientes:

 create table empleados (
  documento varchar(8),
  nombre varchar(30),
  seccion varchar(20),
  sueldo decimal(6,2)
 );

 insert into empleados
  values ('22222222','Alberto Acosta','Sistemas',-10);

 insert into empleados
  values ('33333333','Beatriz Benitez','Recursos',3000);

 insert into empleados
  values ('34444444','Carlos Caseres','Contaduria',4000);

-- 3- Intente agregar una restricción "check" para asegurarse que no se ingresen valores negativos para 
-- el sueldo:

alter table empleados
add constraint CK_empleados_sueldo_negativo
check(sueldo>=0);


-- No se permite porque hay un valor negativo almacenado.

-- 5- Vuelva a intentarlo agregando la opción "with nocheck":

alter table empleados
with nocheck
add constraint CK_empleados_sueldo_positivo
check(sueldo>=0);


-- 6- Intente ingresar un valor negativo para sueldo:

insert into empleados values ('35555555','Daniel Duarte','Administracion',-2000);
-- No es posible a causa de la restricción.

-- 7- Deshabilite la restricción e ingrese el registro anterior:

alter table empleados
nocheck constraint Ck_empleados_sueldo_positivo;

insert into empleados values ('35555555','Daniel Duarte','Administracion',-2000);


-- 8- Establezca una restricción "check" para "seccion" que permita solamente los valores "Sistemas", 
-- "Administracion" y "Contaduría":

alter table empleados
add constraint CK_empleados_seccion_lista
check (Seccion in ('Sistemas', 'Administracion', 'Contaduría'))


-- No lo permite porque existe un valor fuera de la lista.

-- 9- Establezca la restricción anterior evitando que se controlen los datos existentes.

alter table empleados
with nocheck
add constraint CK_empleados_seccion_lista
 check (seccion in ('Sistemas','Administracion','Contaduria'));

-- 10- Vea si las restricciones de la tabla están o no habilitadas:

exec sp_helpconstraint empleados;

-- Muestra 2 filas, una por cada restricción.

-- 11- Habilite la restricción deshabilitada.

alter table empleados
check constraint CK_empleados_sueldo_positivo;


-- 12- Intente modificar la sección del empleado "Carlos Caseres" a "Recursos".
-- No lo permite.
update empleados set seccion='Recursos' where nombre='Carlos Caseres';


-- 13- Deshabilite la restricción para poder realizar la actualización del punto precedente.

alter table empleados
nocheck constraint CK_empleados_seccion_lista;


update empleados set seccion='Recursos' where nombre='Carlos Caseres';






-- ********************* Segundo problema *********************



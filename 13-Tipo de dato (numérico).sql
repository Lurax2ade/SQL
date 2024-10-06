
 
 -------------------------------------------------------------------------------------------------------------------------------
-- 	Tipo de dato (numérico)
 -------------------------------------------------------------------------------------------------------------------------------

-- Ya explicamos que al crear una tabla debemos elegir la estructura adecuada, esto es, definir los campos y sus tipos más precisos, según el caso.

-- Para almacenar valores NUMERICOS SQL Server dispone de varios tipos.

-- Para almacenar valores ENTEROS, por ejemplo, en campos que hacen referencia a cantidades, usamos:

-- 1) integer o int: su rango es de -2000000000 a 2000000000 aprox. El tipo "integer" tiene subtipos:
-- - smallint: Puede contener hasta 5 digitos. Su rango va desde –32000 hasta 32000 aprox.
-- - tinyint: Puede almacenar valores entre 0 y 255.
-- - bigint: De –9000000000000000000 hasta 9000000000000000000 aprox.

-- Para almacenar valores numéricos EXACTOS con decimales, especificando la cantidad de cifras a la izquierda y derecha del separador decimal, utilizamos:

-- 2) decimal o numeric (t,d): Pueden tener hasta 38 digitos, guarda un valor exacto. El primer argumento indica el total de dígitos y el segundo, la cantidad de decimales.
-- Por ejemplo, si queremos almacenar valores entre -99.99 y 99.99 debemos definir el campo como tipo "decimal(4,2)". Si no se indica el valor del segundo argumento, por defecto es "0". Por ejemplo, si definimos "decimal(4)" se pueden guardar valores entre -9999 y 9999.

-- El rango depende de los argumentos, también los bytes que ocupa.
-- Se utiliza el punto como separador de decimales.

-- Si ingresamos un valor con más decimales que los permitidos, redondea al más cercano; por ejemplo, si definimos "decimal(4,2)" e ingresamos el valor "12.686", guardará "12.69", redondeando hacia arriba; si ingresamos el valor "12.682", guardará "12.67", redondeando hacia abajo.

-- Para almacenar valores numéricos APROXIMADOS con decimales utilizamos:

-- 3) float y real: De 1.79E+308 hasta 1.79E+38. Guarda valores aproximados.
-- 4) real: Desde 3.40E+308 hasta 3.40E+38. Guarda valores aproximados.

-- Para almacenar valores MONETARIOS empleamos:

-- 5) money: Puede tener hasta 19 digitos y sólo 4 de ellos puede ir luego del separador decimal; entre –900000000000000.5808 aprox y 900000000000000.5807.

-- 6) smallmoney: Entre –200000.3648 y 200000.3647 aprox.

-- Para todos los tipos numéricos:
-- - si intentamos ingresar un valor fuera de rango, no lo permite.
-- - si ingresamos una cadena, SQL Server intenta convertirla a valor numérico, si dicha cadena consta solamente de dígitos, la conversión se realiza, luego verifica si está dentro del rango, si es así, la ingresa, sino, muestra un mensaje de error y no ejecuta la sentencia. Si la cadena contiene caracteres que SQL Server no puede convertir a valor numérico, muestra un mensaje de error y la sentencia no se ejecuta.
-- Por ejemplo, definimos un campo de tipo decimal(5,2), si ingresamos la cadena '12.22', la convierte al valor numérico 12.22 y la ingresa; si intentamos ingresar la cadena '1234.56', la convierte al valor numérico 1234.56, pero como el máximo valor permitido es 999.99, muestra un mensaje indicando que está fuera de rango. Si intentamos ingresar el valor '12y.25', SQL Server no puede realizar la conversión y muestra un mensaje de error.

-- Es importante elegir el tipo de dato adecuado según el caso, el más preciso. Por ejemplo, si un campo numérico almacenará valores positivos menores a 255, el tipo "int" no es el más adecuado, conviene el tipo "tinyint", de esta manera usamos el menor espacio de almacenamiento posible.
-- Si vamos a guardar valores monetarios menores a 200000 conviene emplear "smallmoney" en lugar de "money".

--********************************** Primer problema **********************************



-- Un banco tiene registrados las cuentas corrientes de sus clientes en una tabla llamada "cuentas".
-- La tabla contiene estos datos:
-- 	Número de Cuenta        Documento       Nombre          Saldo
-- 	______________________________________________________________
--         1234                          25666777        Pedro Perez     500000.60
--         2234                          27888999        Juan Lopez      -250000
--         3344                          27888999        Juan Lopez      4000.50
--         3346                          32111222        Susana Molina   1000

-- 1- Elimine la tabla "cuentas" si existe:

if object_id('cuentas') is not null
drop table cuentas;



-- 2- Cree la tabla eligiendo el tipo de dato adecuado para almacenar los datos descriptos arriba:


create table cuentas(
  numero int not null,
  documento char(8),
  nombre varchar(30),
  saldo float


);

--  - Documento del propietario de la cuenta: cadena de caracteres de 8 de longitud (siempre 8), no nulo;
--  - Nombre del propietario de la cuenta: cadena de caracteres de 30 de longitud,
--  - Saldo de la cuenta: valores altos con decimales.

-- 3- Ingrese los siguientes registros:

 insert into cuentas(numero,documento,nombre,saldo)
  values('1234','25666777','Pedro Perez',500000.60);

 insert into cuentas(numero,documento,nombre,saldo)
  values('2234','27888999','Juan Lopez',-250000);

 insert into cuentas(numero,documento,nombre,saldo)
  values('3344','27888999','Juan Lopez',4000.50);

 insert into cuentas(numero,documento,nombre,saldo)
  values('3346','32111222','Susana Molina',1000);

-- Note que hay dos cuentas, con distinto número de cuenta, de la misma persona.

-- 4- Seleccione todos los registros cuyo saldo sea mayor a "4000" (2 registros)

select * from cuentas
where saldo > 4000;

-- 5- Muestre el número de cuenta y saldo de todas las cuentas cuyo propietario sea "Juan Lopez" (2 
-- registros)

select numero, saldo from cuentas
where nombre = 'Juan Lopez';


-- 6- Muestre las cuentas con saldo negativo (1 registro)
select * from cuentas
where saldo <0;


-- 7- Muestre todas las cuentas cuyo número es igual o mayor a "3000" (2 registros):


select * from cuentas
where numero >= 3000;



-- ********************* Segundo problema *********************


-- Una empresa almacena los datos de sus empleados en una tabla "empleados" que guarda los siguientes 
-- datos: nombre, documento, sexo, domicilio, sueldobasico.

-- 1- Elimine la tabla, si existe:
if object_id('empleados') is not null
drop table empleados;



-- 2- Cree la tabla eligiendo el tipo de dato adecuado para cada campo:


 create table empleados(
  nombre varchar(30),
  documento char(8),
  sexo char(1),
  domicilio varchar(30),
  sueldobasico decimal(7,2),--máximo estimado 99999.99
cantidadhijos tinyint--no superará los 255
);

-- 3- Ingrese algunos registros:

 insert into empleados (nombre,documento,sexo,domicilio,sueldobasico,cantidadhijos)
  values ('Juan Perez','22333444','m','Sarmiento 123',500,2);

 insert into empleados (nombre,documento,sexo,domicilio,sueldobasico,cantidadhijos)
  values ('Ana Acosta','24555666','f','Colon 134',850,0);

 insert into empleados (nombre,documento,sexo,domicilio,sueldobasico,cantidadhijos)
  values ('Bartolome Barrios','27888999','m','Urquiza 479',10000.80,4);

-- 4- Ingrese un valor de "sueldobasico" con más decimales que los definidos (redondea los decimales al 
-- valor más cercano 800.89):

 insert into empleados (nombre,documento,sexo,domicilio,sueldobasico,cantidadhijos)
  values ('Susana Molina','29000555','f','Salta 876',800.888,3);

-- 5- Intente ingresar un sueldo que supere los 7 dígitos (no lo permite)

insert into (nombre,documento,sexo,domicilio,sueldobasico,cantidadhijos)
values('Susana García','29080555','f','Salta 876',80023648.888,3)

-- 6- Muestre todos los empleados cuyo sueldo no supere los 900 pesos (1 registro):

select * from empleados
where sueldo <=900;

-- 7- Seleccione los nombres de los empleados que tengan hijos (3 registros):

 select * from empleados
  where cantidadhijos>0;

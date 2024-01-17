USE Neptuno;

-- 1 - Utilizando la tabla CLIENTES, obtén un listado de todos los clientes residentes en Argentina.
SELECT * FROM Clientes WHERE País = 'Argentina';


--2 - Utilizando la tabla PRODUCTOS, obtén una lista de todos los productos cuyo precio supere los 100 dólares.
SELECT * FROM Productos WHERE PrecioUnidad >100


--3 - Utilizando la tabla EMPLEADOS, obtén una lista de todos los empleados que hayan nacido entre el 01/01/1951 y el 31/12/1959.
SELECT * FROM Empleados WHERE FechaNacimiento BETWEEN '1951-01-01' AND '1959-12-31';


/*4 - Utilizando la tabla CLIENTES, obtén una lista de todos los clientes sudamericanos (tenen cuenta que los únicos países latinoamericanos en los que figuran clientes
registrados son Argentina, Brasil y Venezuela)*/
SELECT *
FROM Clientes
WHERE País IN ('Argentina', 'Brasil', 'Venezuela');


/*5 - Modifica la consulta anterior para mostrar los clientes de todo el mundo, excepto los clientes sudamericanos. 
Ordena el resultado de la consulta alfabéticamente por los nombres de los países resultantes*/
SELECT *	
FROM Clientes
WHERE País NOT IN ('Argentina', 'Brasil', 'Venezuela')
ORDER BY País ASC;


--6 - Modifica la consulta anterior para que los clientes de ESTADOS UNIDOS figuren como U.S.A.
SELECT 
	IdCliente,
	NombreCompañía,
	NombreContacto,
	CargoContacto,
	Dirección,
	Ciudad, 
	Región,
	CódPostal,
	CASE
		WHEN País = 'Estados Unidos' THEN 'U.S.A'
		ELSE País
	END AS Pais,
	Teléfono,
	Fax
FROM Clientes
WHERE País NOT IN ('Argentina', 'Brasil', 'Venezuela')
ORDER BY País ASC;
    

/*7 - Modifica la consulta anterior, manteniendo el reemplazo de ESTADOS UNIDOS por U.S.A. y agregando otro reemplazo por el que todos 
los clientes registrados en el REINO UNIDO figuren como U.K.*/ 
SELECT 
	IdCliente,
	NombreCompañía,
	NombreContacto,
	CargoContacto,
	Dirección,
	Ciudad, 
	Región,
	CódPostal,
	CASE
		WHEN País = 'Estados Unidos' THEN 'U.S.A'
		WHEN País = 'Reino Unido' THEN 'U.K'
		ELSE País
	END AS Pais,
	Teléfono,
	Fax
FROM Clientes
WHERE País NOT IN ('Argentina', 'Brasil', 'Venezuela')
ORDER BY País ASC;
    

--8 - Utilizando la tabla PRODUCTOS, obtén un listado de todos los productos cuyo nombre comience con la letra C, ordenados alfabéticamente por su nombre
SELECT *
FROM Productos
WHERE NombreProducto LIKE '[Cc]%'


--9 - Utilizando la tabla CLIENTES, obtén un listado de todos los clientes que residan en una ciudad que comience con B y tenga 5 caracteres en total.
SELECT *
FROM Clientes
WHERE Ciudad LIKE '[Bb]____'


--10 - Utilizando la tabla EMPLEADOS, calcula la edad de cada uno de los empleados.
SELECT *,
	DATEDIFF(YEAR, FechaNacimiento, GETDATE()) AS EDAD
FROM Empleados;


--11 - 
SELECT
	IdEmpleado,
	CONCAT(Apellidos,', ',Nombre) AS Empleado,
	Cargo,
	DATEDIFF(YEAR, FechaNacimiento, GETDATE()) AS Edad
FROM Empleados;


--12 - Modifica la consulta anterior para mostrar únicamente los empleados que tengan menos de 60 años.
SELECT
	IdEmpleado,
	CONCAT(Apellidos,', ',Nombre) AS Empleado,
	Cargo,
	DATEDIFF(YEAR, FechaNacimiento, GETDATE()) AS Edad
FROM Empleados
WHERE DATEDIFF(YEAR, FechaNacimiento, GETDATE()) < 60;


/*13 - Utilizando la tabla PRODUCTOS, obtén un listado de todos los productos que figuran en la tabla. 
Agrega una columna que calcule el precio de cada producto con su correspondiente IVA (21% sobre el precio del producto).
Esta columna debe mostrar 2 decimales.*/
SELECT *,
	CAST(PrecioUnidad * 1.21 AS DECIMAL(8,2)) AS PrecioConIva
FROM Productos;


--14 - Utilizando la tabla PRODUCTOS, obtén una lista de todos los productos cuyo precio supere los 10 dólares y queden 4 unidades en stock.
SELECT *
FROM Productos
WHERE PrecioUnidad > 10 AND UnidadesEnExistencia = 4;
    
    
--15 - Utilizando la tabla PEDIDOS, obtén una lista de los pedidos cuyos ID son los números 10278 y 10390.
SELECT *
FROM Pedidos
WHERE IdPedido BETWEEN 10278 AND 10390;


/*16 - Utilizando la tabla PEDIDOS, obtén una lista de todos aquellos pedidos cuyo cargo (importe) oscile entre 10 y 20 dólares inclusive. 
Ordena el resultado de mayor a menor según los cargos de estos pedidos.*/
SELECT *
FROM Pedidos
WHERE Cargo BETWEEN 10 AND 20
ORDER BY Cargo DESC;


--17 - Utilizando la tabla PEDIDOS, obtén una lista de todos aquellos pedidos que fueron entregados durante la primera quincena de enero del año 1997.
SELECT *
FROM Pedidos
WHERE FechaEntrega BETWEEN '1997-01-01' AND '1997-01-15'
ORDER BY Cargo DESC;


--18 - Utilizando la tabla CLIENTES, obtén una lista de todos aquellos clientes que no tengan cargado su número de fax.
SELECT *
FROM Clientes
WHERE Fax IS NULL;


--19 - Modifica la consulta anterior para obtener los clientes que no tienen ni la región ni el número de fax cargados.
SELECT *
FROM Clientes
WHERE 
	Fax IS NULL AND
	Región IS NULL;


--20 - Utilizando la tabla EMPLEADOS, genera una consulta que permita calcular la cantidad de empleados según su cargo.
SELECT
	Cargo,
	COUNT(*) AS Cantidad
FROM Empleados
GROUP BY Cargo;


--21 - Utilizando la tabla CLIENTES, calcula la cantidad de clientes registrados en cada país.
SELECT
	País,
	COUNT(*) AS [Cantidadad de clientes]
FROM Clientes
GROUP BY País;


--22 - Utilizando la tabla PEDIDOS, calcula la cantidad de pedidos por año.
SELECT
	YEAR(FechaPedido) AS Año,
	COUNT(*) AS Pedidos
FROM Pedidos
GROUP BY YEAR(FechaPedido);


--23 - Modifica la consulta anterior para calcular el total facturado por la empresa, anualmente
SELECT
	YEAR(FechaPedido) AS Año,
	COUNT(*) AS Pedidos,
	SUM(Cargo) AS [Total facturado]
FROM Pedidos
GROUP BY YEAR(FechaPedido);


--24 - Modifica la consulta anterior para calcular el promedio de facturación anual
SELECT
	YEAR(FechaPedido) AS Año,
	COUNT(*) AS Pedidos,
	SUM(Cargo) AS [Total facturado],
	AVG(Cargo) AS [Factura Promedio]
FROM Pedidos
GROUP BY YEAR(FechaPedido);


--25 - Modifica la consulta anterior para obtener la mejor venta de cada año.
SELECT
	YEAR(FechaPedido) AS Año,
	COUNT(*) AS Pedidos,
	SUM(Cargo) AS [Total facturado],
	AVG(Cargo) AS [Factura Promedio],
	MAX(Cargo) AS [Mejor Venta]
FROM Pedidos
GROUP BY YEAR(FechaPedido);


--26 - Modifica la consulta anterior para obtener la peor venta de cada año
SELECT
	YEAR(FechaPedido) AS Año,
	COUNT(*) AS Pedidos,
	SUM(Cargo) AS [Total facturado],
	AVG(Cargo) AS [Factura Promedio],
	MAX(Cargo) AS [Mejor Venta],
	MIN(Cargo) AS [Peor Venta]
FROM Pedidos
GROUP BY YEAR(FechaPedido);


--27 - Utilizando las tablas CATEGORIAS y PRODUCTOS, calcula la cantidad de productos pertenecientes a cada categoría
SELECT 
	C.NombreCategoría,
	COUNT(*) AS Cantidad
FROM Productos AS P
JOIN Categorías AS C
	ON P.IdCategoría = C.IdCategoría
GROUP BY C.NombreCategoría;

--28 - Utilizando las tablas COMPAÑÍAS DE ENVÍOS y PEDIDOS, calcula la cantidad de entregas efectuadas por cada compañía.
SELECT
	CE.NombreCompañía,
	COUNT(*) AS Entregas
FROM [Compañías de envíos] AS CE
JOIN Pedidos AS P
	ON CE.IdCompañíaEnvíos = P.FormaEnvío
GROUP BY CE.NombreCompañía;


--29 - Genera un SELECT para obtener un listado de todos los productos que figuran en la tabla PRODUCTOS.
SELECT * FROM Productos;


/*30 - Habiendo ejecutado la consulta anterior, observarás que en la tabla PRODUCTOS hay un campo con el nombre SUSPENDIDO, el cual es de tipo INT.
Con un ALTER TABLE, modifica el campo para que pase a ser de tipo VARCHAR(2) y de carga obligatoria.*/
ALTER TABLE Productos
ALTER COLUMN Suspendido
	VARCHAR(2) NOT NULL;


/*31 - Ejecuta un UPDATE sobre la tabla PRODUCTOS de manera que: Todos los productos que figuren con el número 0 en el campo SUSPENDIDO, se actualicen por la palabra NO.
Todos los productos que figuren con el número 1 en el campo SUSPENDIDO, se actualicen por la palabra SI.*/

UPDATE Productos
SET Suspendido = 
	CASE
		WHEN Suspendido = '0' THEN 'NO'
		WHEN Suspendido = '1' THEN 'SI'
	END;


--32 - Utilizando las tablas EMPLEADOS y PEDIDOS, calcula el total facturado por empleado.
SELECT
	CONCAT(E.Apellidos, ', ', Nombre) AS Empleado,
	SUM(P.Cargo) AS [Total facturado]
FROM Empleados AS E
JOIN Pedidos AS P
	ON E.IdEmpleado = P.IdEmpleado
GROUP BY CONCAT(E.Apellidos, ', ', Nombre);

    
--33 - Utilizando las tablas CLIENTES y PEDIDOS, obtén una lista en la que se muestren los nombres de las compañías y la cantidad de pedidos efectuadas por cada una de ellas
SELECT
	C.NombreCompañía,
	COUNT(*) AS [Cantidad de pedidos]
FROM Clientes AS C
JOIN Pedidos AS P
	ON C.IdCliente = P.IdCliente
GROUP BY C.NombreCompañía;


--34 - Modifica la consulta anterior para mostrar únicamente el cliente que haya efectuado la mayor cantidad de pedidos.
SELECT TOP 1
	C.NombreCompañía,
	COUNT(*) AS [Cantidad de pedidos]
FROM Clientes AS C
JOIN Pedidos AS P
	ON C.IdCliente = P.IdCliente
GROUP BY C.NombreCompañía
ORDER BY COUNT(*) DESC;

--35 - Utilizando la tabla PRODUCTOS, obtén un listado de los 5 productos más caros comercializados por la empresa.
SELECT TOP 5 *
FROM Productos
ORDER BY PrecioUnidad DESC;


--36 - Utilizando la tabla CLIENTES, obtén un listado de todos los países en los que hay clientes registrados (los países no deben repetirse).	
SELECT DISTINCT País FROM Clientes;


--37 - Utilizando las tablas CLIENTES y PEDIDOS, obtén un listado de todos los clientes que no hayan efectuado ningún pedido.
SELECT NombreCompañía
FROM Clientes
WHERE IdCliente NOT IN (SELECT DISTINCT P.IdCliente FROM Pedidos AS P)

-- O tambien:
SELECT NombreCompañía
FROM Clientes AS C
WHERE NOT EXISTS(SELECT P.IdCliente FROM Pedidos AS P WHERE C.IdCliente = P.IdCliente);


--38 - Utilizando las tablas PROVEEDORES y PRODUCTOS, obtén un listado de todos los proveedores que, en este momento, no le estén vendiendo ningún producto a nuestra empresa
SELECT NombreCompañía
FROM Proveedores
WHERE IdProveedor NOT IN (SELECT DISTINCT P.IdProducto FROM Productos AS P);

--39 - Observa el contenido de la tabla DETALLES DE PEDIDOS a través de un SELECT.
SELECT * FROM [Detalles de pedidos];


/*40 - Si observas la tabla, verás 3 campos:
PRECIOUNIDAD (el precio del producto vendido),
CANTIDAD (la cantidad de unidades vendidas de ese producto) y 
DESCUENTO (el descuento aplicado al cliente por la compra realizada).
Agrega un campo a la consulta que calcule el total abonado por cada compra. Muestra el resultado con 2 decimales.
la consulta debe arrojar un total de 2155 filas*/
SELECT
	IdPedido,
	IdProducto,
	PrecioUnidad,
	Cantidad,
	CAST(PrecioUnidad * Cantidad AS DECIMAL(8,2))AS [Total compra],
	CAST(Descuento * 100 AS DECIMAL(8,2)) AS [Descuento %],
	CAST((PrecioUnidad * Cantidad) - (PrecioUnidad * Cantidad * Descuento) AS DECIMAL(8,2)) AS [Total a pagar]
FROM [Detalles de pedidos];


/*41 -  Modifica la consulta anterior para mostrar el nombre del producto en lugar de su ID (esta información sale de la tabla PRODUCTOS),
el empleado que atendió cada una de estas ventas (esta información la obtienes de la tabla EMPLEADOS) y
el nombre de la compañía del cliente que efectuó cada uno de estos pedidos (esta información la obtienes de la tabla CLIENTES).
La consulta debe arrojar un total de 2155 filas*/
SELECT
	DP.IdPedido,
	C.NombreCompañía AS [Comprado por],
	CONCAT(E.Apellidos,', ', E.Nombre) AS [Vendido por],
	Prod.NombreProducto AS Producto,
	DP.PrecioUnidad,
	DP.Cantidad,
	CAST(DP.PrecioUnidad * DP.Cantidad AS DECIMAL(8,2))AS [Total compra],
	CAST(DP.Descuento * 100 AS DECIMAL(8,2)) AS [Descuento %],
	CAST((DP.PrecioUnidad * DP.Cantidad) - (DP.PrecioUnidad * DP.Cantidad * DP.Descuento) AS DECIMAL(8,2)) AS [Total a pagar]
FROM [Detalles de pedidos] AS DP
JOIN Productos AS Prod
	ON Prod.IdProducto = DP.IdProducto
JOIN Pedidos AS Ped
	ON Ped.IdPedido = DP.IdPedido
JOIN Empleados AS E
	ON E.IdEmpleado = Ped.IdEmpleado
JOIN Clientes AS C
	ON C.IdCliente = Ped.IdCliente;
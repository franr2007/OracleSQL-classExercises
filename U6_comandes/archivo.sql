SELECT DISTINCT c.ID,c.NOMBRE,c.APELLIDO1||' '||c.APELLIDO2 AS APELLIDOS FROM CLIENTE c JOIN PEDIDO ON c.ID=pedido.id_cliente ORDER BY APELLIDOS,NOMBRE; --1

SELECT DISTINCT * FROM CLIENTE c LEFT JOIN PEDIDO p ON c.ID=p.id_cliente WHERE p.id IS NULL; --2

SELECT DISTINCT * FROM COMERCIAL c LEFT JOIN PEDIDO p ON c.ID=p.id_comercial WHERE p.id IS NULL; --3

SELECT DISTINCT c.*,p.* FROM CLIENTE c JOIN PEDIDO p ON c.ID=p.id_cliente ORDER BY CLIENTE; --4

SELECT DISTINCT c.*,p.* FROM PEDIDO p JOIN COMERCIAL c ON p.id_comercial=c.id ORDER BY c.nombre; --5

SELECT DISTINCT * FROM CLIENTE C JOIN PEDIDO P ON C.ID=p.id_cliente JOIN COMERCIAL CL ON CL.ID=p.id_comercial; --6

SELECT DISTINCT 'cliente' as tipo, c.ID,c.NOMBRE,c.APELLIDO1||' '||c.APELLIDO2 AS APELLIDOS FROM CLIENTE c JOIN PEDIDO ON c.ID=pedido.id_cliente  UNION SELECT DISTINCT 'comercial' as tipo, c.ID,c.NOMBRE,c.APELLIDO1||' '||c.APELLIDO2 AS APELLIDOS FROM CLIENTE c LEFT JOIN PEDIDO p ON c.ID=p.id_cliente WHERE p.id IS NULL ORDER BY NOMBRE; --7

SELECT * FROM CLIENTE JOIN PEDIDO ON CLIENTE.ID=PEDIDO.ID_CLIENTE WHERE EXTRACT(YEAR FROM PEDIDO.FECHA)=2017 AND PEDIDO.TOTAL BETWEEN 300 AND 1000; --8

SELECT * FROM COMERCIAL C LEFT JOIN PEDIDO P ON C.ID=P.ID_COMERCIAL ORDER BY C.apellido1,C.APELLIDO2,C.NOMBRE; --9

SELECT CO.NOMBRE,CO.apellido1||' '||CO.apellido2 AS APELLIDOS FROM COMERCIAL CO JOIN PEDIDO P ON p.id_comercial=CO.ID JOIN CLIENTE C ON C.ID=p.id_cliente WHERE C.NOMBRE||' '||CO.apellido1||' '||CO.APELLIDO2='María Santana Moreno';--10

-- 1. Devuelve un listado con el identificador, nombre y los apellidos de todos los clientes que han realizado algún pedido.
-- El listado debe estar ordenado alfabéticamente y se deben eliminar los elementos repetidos.

-- 2. Devuelve un listado que solamente muestre los clientes que no han realizado ningún pedido.

-- 3. Devuelve un listado que solamente muestre los comerciales que no han realizado ningún pedido.

-- 4. Devuelve un listado que muestre todos los pedidos que ha realizado cada cliente
-- El resultado debe mostrar todos los datos de los pedidos y del cliente. El listado debe mostrar los datos de los clientes ordenados alfabéticamente.

-- 5. Devuelve un listado que muestre todos los pedidos en los que ha participado un comercial.
-- El resultado debe mostrar todos los datos de los pedidos y de los comerciales. El listado debe mostrar los datos de los comerciales ordenados alfabéticamente.

-- 6. Devuelve un listado que muestre todos los clientes, con todos los pedidos que han realizado y
-- con los datos de los comerciales asociados a cada pedido.

-- 7. Devuelve un listado con los clientes que no han realizado ningún pedido y de los comerciales que no han participado en ningún pedido.
-- Ordene el listado alfabéticamente por los apellidos y el nombre. En en listado deberá diferenciar de algún modo los clientes y los comerciales.

-- 8. Devuelve un listado de todos los clientes que realizaron un pedido durante el año 2017, cuya cantidad esté entre 300 € y 1000 €.

-- 9. Devuelve un listado con todos los comerciales junto con los datos de los pedidos que han realizado.
-- Este listado también debe incluir los comerciales que no han realizado ningún pedido.
-- El listado debe estar ordenado alfabéticamente por el primer apellido, segundo apellido y nombre de los comerciales.

-- 10. Devuelve el nombre y los apellidos de todos los comerciales que ha participado en algún pedido realizado por María Santana Moreno.

-- 11. Devuelve el nombre de todos los clientes que han realizado algún pedido con el comercial Daniel Sáez Vega.

-- 12. Devuelve un listado con todos los clientes junto con los datos de los pedidos que han realizado.
-- Este listado también debe incluir los clientes que no han realizado ningún pedido.
-- El listado debe estar ordenado alfabéticamente por el primer apellido, segundo apellido y nombre de los clientes.
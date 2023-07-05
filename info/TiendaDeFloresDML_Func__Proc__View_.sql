USE tiendaflores;
SET GLOBAL log_bin_trust_function_creators = 1;

/* ------------------------------ Funciones ------------------------------ */

DROP FUNCTION IF EXISTS nombre_completo;
DELIMITER |
CREATE
FUNCTION nombre_completo (iduser INT)
RETURNS VARCHAR(200)
COMMENT 'Función que devuelve la concatenación del nombre completo del usuario'
BEGIN
DECLARE nombre VARCHAR(200);
	SELECT CONCAT(nombre1, COALESCE(CONCAT(' ', nombre2), '') , ' ', paterno, ' ', materno) INTO nombre
	FROM usuario
	WHERE id_usuario = iduser;
RETURN nombre;
END;
| DELIMITER ;

SELECT nombre_completo(2) AS nombre;
SELECT nombre_completo(5) AS nombre;
SELECT nombre_completo(10) AS nombre;

/*-*/

DROP FUNCTION IF EXISTS show_dir;
DELIMITER |
CREATE
FUNCTION show_dir (iddir INT)
RETURNS VARCHAR(200)
COMMENT 'Función que devuelve la concatenación de todos los datos de una dirección'
BEGIN
DECLARE direccion VARCHAR(200);
	SELECT CONCAT( t1.calle, " #", t1.numero, ", ", t1.codigo_postal, ", ", t2.cpd_nombre, ', ', t3.nombre_edo ) INTO direccion
	FROM direccion AS t1
	INNER JOIN ciudad_pueblo_delegacion AS t2 ON t1.id_cpd_fk = t2.id_cpd
	INNER JOIN estados AS t3 ON t2.id_estado_fk = t3.id_estado
	WHERE iddireccion = iddir;
RETURN direccion;
END
| DELIMITER ;

SELECT show_dir(2) AS direccion;
SELECT show_dir(7) AS direccion;
SELECT show_dir(11) AS direccion;

/* ------------------------------ Procesos ------------------------------ */

DROP PROCEDURE IF EXISTS buscador_usuario;
DELIMITER |
CREATE PROCEDURE buscador_usuario(dato VARCHAR(100))
COMMENT 'Proceso que busca los datos de un usuario mediante un dato en especifico'
BEGIN
	SELECT t1.id_usuario, t1.nombre1, t1.nombre2, t1.paterno, t1.materno, t1.fecha_nacimiento, t1.num_celular, t2.email, t2.pass_word
    FROM usuario AS t1
    INNER JOIN cuentas AS t2 ON t2.id_usuario_fk = t1.id_usuario
    WHERE (t1.nombre1 LIKE CONCAT ('%', dato, '%') OR 
    t1.nombre2 LIKE CONCAT ('%', dato, '%') OR 
    t1.paterno LIKE CONCAT ('%', dato, '%') OR 
    t1.materno LIKE CONCAT ('%', dato, '%') OR 
    t1.fecha_nacimiento LIKE CONCAT ('%', dato, '%') OR 
    t1.num_celular LIKE CONCAT ('%', dato, '%') OR 
    t2.email LIKE CONCAT ('%', dato, '%') OR 
    t2.pass_word LIKE CONCAT ('%', dato, '%'));
END
| DELIMITER ;

CALL buscador_usuario('Castro');
CALL buscador_usuario('org');
CALL buscador_usuario('com');

/*-*/

DROP PROCEDURE IF EXISTS datos_tipo_usuario;
DELIMITER |
CREATE PROCEDURE datos_tipo_usuario(tipo INT)
COMMENT 'Proceso que muestra los datos de administradores o clientes'
BEGIN
	IF tipo > 0 THEN
		SELECT t1.id_usuario, nombre_completo(t1.id_usuario) AS nombre, (YEAR(curdate()) - YEAR(t1.fecha_nacimiento)) AS edad, t1.num_celular, show_dir(t1.id_direccion) AS direccion, t2.tipo_usuario
		FROM usuario AS t1
		INNER JOIN tipo_usuario AS t2 ON t1.id_tipo = t2.idtipo_usuario
        WHERE t1.id_tipo = tipo 
        ORDER BY id_usuario ASC;
    ELSE 
		SELECT t1.id_usuario, nombre_completo(t1.id_usuario) AS nombre, (YEAR(curdate()) - YEAR(t1.fecha_nacimiento)) AS edad, t1.num_celular, show_dir(t1.id_direccion) AS direccion, t2.tipo_usuario
		FROM usuario AS t1
		INNER JOIN tipo_usuario AS t2 ON t1.id_tipo = t2.idtipo_usuario
        ORDER BY id_usuario ASC;
	END IF;
END
| DELIMITER ;

CALL datos_tipo_usuario(0);
CALL datos_tipo_usuario(1);
CALL datos_tipo_usuario(2);

/*-*/

DROP PROCEDURE IF EXISTS ganancias_generales;
DELIMITER |
CREATE PROCEDURE ganancias_generales()
COMMENT 'Proceso que calcula entradas y salidas generales'
BEGIN
	SELECT
    (SELECT ROUND(SUM(a_pagar),2) FROM tickets_compra WHERE edo_pago = "Realizado" AND estado_envio = "Entregado") AS ganancias,
	(SELECT ROUND(SUM(a_pagar),2) FROM tickets_compra WHERE (edo_pago = "En proceso" OR edo_pago = "Error") AND estado_envio = "Pendiente") AS pendientes,
	(SELECT ROUND(SUM(a_pagar),2) FROM tickets_compra WHERE edo_pago = "Cancelado") AS perdidas;
END
| DELIMITER ;

CALL ganancias_generales();

/*-*/

DROP PROCEDURE IF EXISTS ganancias_mes;
DELIMITER |
CREATE PROCEDURE ganancias_mes(mes INT)
COMMENT 'Proceso que calcula entradas y salidas de un mes en especifico'
BEGIN
	SELECT monthname(STR_TO_DATE(mes, '%m')) AS mes,
    (SELECT COALESCE(ROUND(SUM(a_pagar),2), 0) FROM tickets_compra WHERE MONTH(fecha_compra) = mes AND edo_pago = "Realizado" AND estado_envio = "Entregado") AS ganancias,
	(SELECT COALESCE(ROUND(SUM(a_pagar),2), 0) FROM tickets_compra WHERE MONTH(fecha_compra) = mes AND (edo_pago = "En proceso" OR edo_pago = "Error") AND estado_envio = "Pendiente") AS pendientes,
	(SELECT COALESCE(ROUND(SUM(a_pagar),2), 0) FROM tickets_compra WHERE MONTH(fecha_compra) = mes AND edo_pago = "Cancelado") AS perdidas;
END
| DELIMITER ;

CALL ganancias_mes(9);
CALL ganancias_mes(10);
CALL ganancias_mes(11);

/*-*/

DROP PROCEDURE IF EXISTS tabla_usuario_busqueda;
DELIMITER |
CREATE PROCEDURE tabla_usuario_busqueda(IN dato VARCHAR(50))
COMMENT 'Procedimiento que crea una tabla y traslada los datos encontrados mediante busqueda a dicha tabla'
BEGIN
	 DECLARE done INT DEFAULT FALSE;
	 DECLARE v1, id INT DEFAULT 0;
	 
	 DECLARE nom1, nom2, pa, ma, num, email, pass VARCHAR(100);
     DECLARE nacimiento date;
	 
	 DECLARE cur1 CURSOR FOR 
		SELECT t1.id_usuario, t1.nombre1, t1.nombre2, t1.paterno, t1.materno, t1.fecha_nacimiento, t1.num_celular, t2.email, t2.pass_word
		FROM usuario AS t1 INNER JOIN cuentas AS t2 ON t2.id_usuario_fk = t1.id_usuario
		WHERE (t1.nombre1 LIKE CONCAT ('%', dato, '%') OR t1.nombre2 LIKE CONCAT ('%', dato, '%') OR t1.paterno LIKE CONCAT ('%', dato, '%') OR 
		t1.materno LIKE CONCAT ('%', dato, '%') OR t1.fecha_nacimiento LIKE CONCAT ('%', dato, '%') OR t1.num_celular LIKE CONCAT ('%', dato, '%') OR 
		t2.email LIKE CONCAT ('%', dato, '%') OR t2.pass_word LIKE CONCAT ('%', dato, '%'));
	 
	 DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
		SELECT COUNT(t1.id_usuario) INTO v1 
        FROM usuario AS t1 INNER JOIN cuentas AS t2 ON t2.id_usuario_fk = t1.id_usuario
		WHERE (t1.nombre1 LIKE CONCAT ('%', dato, '%') OR t1.nombre2 LIKE CONCAT ('%', dato, '%') OR t1.paterno LIKE CONCAT ('%', dato, '%') OR 
		t1.materno LIKE CONCAT ('%', dato, '%') OR t1.fecha_nacimiento LIKE CONCAT ('%', dato, '%') OR t1.num_celular LIKE CONCAT ('%', dato, '%') OR 
		t2.email LIKE CONCAT ('%', dato, '%') OR t2.pass_word LIKE CONCAT ('%', dato, '%'));
        
		IF v1 > 0 THEN
			DROP TABLE IF EXISTS busqueda;
			CREATE TABLE busqueda (iddato INT, nombre1 VARCHAR (50), nombre2 VARCHAR (50), paterno VARCHAR (50), materno VARCHAR (50), fecha DATE, celular VARCHAR (12), email VARCHAR (100), contra VARCHAR (100));

			OPEN cur1;		 
			read_loop: LOOP

				FETCH cur1 INTO id, nom1, nom2, pa, ma, nacimiento, num, email, pass;                

				IF done THEN 
					LEAVE read_loop;
				END IF;

                INSERT INTO busqueda (iddato, nombre1, nombre2, paterno, materno, fecha, celular, email, contra) 
				VALUES (id, nom1, nom2, pa, ma, nacimiento, num, email, pass);
			end loop;

			CLOSE cur1;
		END IF;
	
    SELECT * FROM busqueda;
END |
DELIMITER ;

CALL tabla_usuario_busqueda('org');
CALL tabla_usuario_busqueda('com');

/* ------------------------------ Vistas ------------------------------ */

DROP VIEW IF EXISTS tickets_compra;
CREATE VIEW tickets_compra AS
SELECT t2.id_ticket, nombre_completo(t1.id_usuario_fk) AS nombre, concat(t3.nombre, ': ', t3.descripcion) AS producto, t2.cantidad, round(t2.cantidad * sum(t3.costo + t3.costo_envio), 2) AS a_pagar, 
t2.fecha_compra, t2.fecha_entrega, show_dir(t4.id_direccion) AS direccion_envio,  t2.detalles_direccion, t5.tipo_metodo, t6.edo_pago, t7.estado_envio
FROM compras AS t1
INNER JOIN ticket AS t2 ON t1.id_ticket_fk = t2.id_ticket
INNER JOIN productos AS t3 ON t2.id_producto = t3.id_producto
INNER JOIN usuario AS t4 ON t1.id_usuario_fk = t4.id_usuario
INNER JOIN metodos_pago AS t5 ON t2.id_metodo_pago_fk = t5.id_metodo
INNER JOIN estado_pago AS t6 ON t2.id_estado_pago_fk = t6.id_edo_pago
INNER JOIN estado_envio AS t7 ON t2.id_estado_envio_fk = t7.id_estado_envio
GROUP BY t1.idcompras ORDER BY t1.idcompras ASC;

SELECT * FROM tickets_compra;

/*-*/

DROP VIEW IF EXISTS tickets_soporte;
CREATE VIEW tickets_soporte AS
SELECT concat(t7.nombre1, ' en el área de ', t6.nombre) AS admin_asigando, t2.id_ticket_soporte AS num_ticket, nombre_completo(t2.id_usuario_fk) AS nombre_usuario, 
t3.nombre_cat AS categoria, t2.descripcion, t4.estado, t5.nivel AS prioridad
FROM soporte_tecnico AS t1
INNER JOIN ticket_soporte AS t2 ON t1.id_ticket_fk = t2.id_ticket_soporte
INNER JOIN ticket_sop_categoria AS t3 ON t2.id_categoria_fk = t3.id_ticket_categoria
INNER JOIN ticket_sop_estado AS t4 ON t2.id_ticket_estado_fk = t4.id_ticket_estado
INNER JOIN ticket_sop_nivel AS t5 ON t2.id_nivel_fk = t5.id_nivel_ticket
INNER JOIN areas AS t6 ON t1.id_area_fk = idareas
INNER JOIN usuario AS t7 ON t1.id_administrador_fk = t7.id_usuario;

SELECT * FROM tickets_soporte;

/*-*/

DROP VIEW IF EXISTS vista_catalogo;
CREATE VIEW vista_catalogo AS
SELECT t3.id_producto, t3.tipo_producto, t3.nombre, t3.stock, t3.costo, t3.costo_envio, t3.descripcion, t2.nombre AS vendido_por
FROM catalogo AS t1
INNER JOIN tiendas AS t2 ON t1.id_tienda_fk = t2.id_tienda
INNER JOIN productos AS t3 ON t1.id_producto_fk = t3.id_producto
GROUP BY t3.id_producto ORDER BY t3.id_producto;

SELECT * FROM vista_catalogo;

/*-*/

DROP VIEW IF EXISTS vista_facturas;
CREATE VIEW vista_facturas AS
SELECT nombre_completo(t1.id_usuario_fk) AS nombre, t2.rfc, show_dir(t2.id_dir_fiscal) AS direccion_fiscal, t3.concepto, 
(SELECT producto FROM tickets_compra WHERE id_ticket = t4.id_ticket_fk) AS compra,
(SELECT cantidad FROM tickets_compra WHERE id_ticket = t4.id_ticket_fk) AS cantidad,
(SELECT a_pagar FROM tickets_compra WHERE id_ticket = t4.id_ticket_fk) AS pago,
(SELECT fecha_compra FROM tickets_compra WHERE id_ticket = t4.id_ticket_fk) AS fecha_compra
FROM facturas AS t1
INNER JOIN facturacion AS t2 ON t1.id_facturacion_fk = t2.idfactura
INNER JOIN cfdi AS t3 ON t2.id_cfdi = t3.idcfdi
INNER JOIN compras AS t4 ON t2.id_compra_fk = idcompras;

SELECT * FROM vista_facturas;
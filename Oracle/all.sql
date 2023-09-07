-- up
ALTER SESSION SET PLSCOPE_SETTINGS = 'IDENTIFIERS:NONE'; -- Evita errores raros. Ejecutar solo una vez. En los siguientes CREATE, no ejecutarlo.

CREATE TABLE facturas(
	id NUMBER(7) NOT NULL, -- "PRIMARY KEY" quitado por redundancia con el CONSTRAINT PRIMARY KEY
  codigo VARCHAR2(9),
  valor_venta FLOAT,
  igv FLOAT,
  precio_venta FLOAT,
  fecha_creacion DATE,
	moneda VARCHAR2(20)
);

ALTER TABLE facturas ADD (
  CONSTRAINT facturas_pk PRIMARY KEY (ID));

CREATE SEQUENCE facturas_seq START WITH 1;

CREATE OR REPLACE TRIGGER facturas_pk 
BEFORE INSERT ON facturas 
FOR EACH ROW

BEGIN
  SELECT facturas_seq.NEXTVAL
  INTO   :new.id
  FROM   dual;
END;
/

CREATE TABLE productos(
	id NUMBER(7) NOT NULL,
  nombre VARCHAR(40),
  valor_unitario FLOAT,
	codigo VARCHAR2(7),
  tipo_producto VARCHAR2(2)
);

ALTER TABLE productos ADD (
  CONSTRAINT productos_pk PRIMARY KEY (ID));

CREATE SEQUENCE productos_seq START WITH 1;

CREATE OR REPLACE TRIGGER productos_pk 
BEFORE INSERT ON productos 
FOR EACH ROW

BEGIN
  SELECT productos_seq.NEXTVAL
  INTO   :new.id
  FROM   dual;
END;
/

CREATE TABLE detalles(
	id NUMBER(7) NOT NULL,
  cantidad NUMBER(8),
  valor_total FLOAT,
  factura_id NUMBER(7),
  producto_id NUMBER(7),
  FOREIGN KEY (factura_id) REFERENCES facturas,
  FOREIGN KEY (producto_id) REFERENCES productos
);

ALTER TABLE detalles ADD (
  CONSTRAINT detalles_pk PRIMARY KEY (ID));

CREATE SEQUENCE detalles_seq START WITH 1;

CREATE OR REPLACE TRIGGER detalles_pk 
BEFORE INSERT ON detalles 
FOR EACH ROW

BEGIN
  SELECT detalles_seq.NEXTVAL
  INTO   :new.id
  FROM   dual;
END;
/

INSERT INTO facturas (codigo, valor_venta, igv, precio_venta, fecha_creacion, moneda) VALUES ('E001-0001',61,10.98,71.98,TO_DATE('12/12/2023', 'dd/mm/yyyy'),'soles');
INSERT INTO facturas (codigo, valor_venta, igv, precio_venta, fecha_creacion, moneda) VALUES ('E001-0002',51,9.18,60.18,TO_DATE('18/12/2023', 'dd/mm/yyyy'),'dolares');
INSERT INTO facturas (codigo, valor_venta, igv, precio_venta, fecha_creacion, moneda) VALUES ('E001-0003',78,14.04,92.04,TO_DATE('15/12/2023', 'dd/mm/yyyy'),'euros');
INSERT INTO facturas (codigo, valor_venta, igv, precio_venta, fecha_creacion, moneda) VALUES ('E001-0004',76,13.68,89.68,TO_DATE('18/10/2023', 'dd/mm/yyyy'),'soles');
INSERT INTO facturas (codigo, valor_venta, igv, precio_venta, fecha_creacion, moneda) VALUES ('E001-0005',52,9.36,61.36,TO_DATE('19/12/2023', 'dd/mm/yyyy'),'dolares');
INSERT INTO facturas (codigo, valor_venta, igv, precio_venta, fecha_creacion, moneda) VALUES ('E001-0006',72,12.96,84.96,TO_DATE('23/12/2023', 'dd/mm/yyyy'),'euros');
INSERT INTO facturas (codigo, valor_venta, igv, precio_venta, fecha_creacion, moneda) VALUES ('E001-0007',70,12.6,82.6,TO_DATE('11/12/2023', 'dd/mm/yyyy'),'soles');
INSERT INTO facturas (codigo, valor_venta, igv, precio_venta, fecha_creacion, moneda) VALUES ('E001-0008',67,12.06,79.06,TO_DATE('10/10/2023', 'dd/mm/yyyy'),'dolares');
INSERT INTO facturas (codigo, valor_venta, igv, precio_venta, fecha_creacion, moneda) VALUES ('E001-0009',74,13.32,87.32,TO_DATE('23/12/2023', 'dd/mm/yyyy'),'euros');
INSERT INTO facturas (codigo, valor_venta, igv, precio_venta, fecha_creacion, moneda) VALUES ('E001-0010',55,9.9,64.9,TO_DATE('12/12/2023', 'dd/mm/yyyy'),'soles');

INSERT INTO productos (nombre, valor_unitario, codigo, tipo_producto) VALUES ('Polo de Algodon',29.99,'POL-001','MP');
INSERT INTO productos (nombre, valor_unitario, codigo, tipo_producto) VALUES ('Polo de Manga Larga',24.99,'POL-002','PT');
INSERT INTO productos (nombre, valor_unitario, codigo, tipo_producto) VALUES ('Camisa de Vestir',29.99,'CAM-001','PT');
INSERT INTO productos (nombre, valor_unitario, codigo, tipo_producto) VALUES ('Camisa a Cuadros',22.99,'CAM-002','PT');
INSERT INTO productos (nombre, valor_unitario, codigo, tipo_producto) VALUES ('Pantalón Chino',34.99,'PAN-001','MP');
INSERT INTO productos (nombre, valor_unitario, codigo, tipo_producto) VALUES ('Pantalón Vaquero Skinny',39.99,'PAN-002','PT');
INSERT INTO productos (nombre, valor_unitario, codigo, tipo_producto) VALUES ('Vestido de Noche',49.99,'VES-001','PT');
INSERT INTO productos (nombre, valor_unitario, codigo, tipo_producto) VALUES ('Vestido de Verano',29.99,'VES-002','PT');
INSERT INTO productos (nombre, valor_unitario, codigo, tipo_producto) VALUES ('Blusa de Encaje',26.99,'BLU-001','MP');
INSERT INTO productos (nombre, valor_unitario, codigo, tipo_producto) VALUES ('Blusa de Seda',32.99,'BLU-002','PT');
INSERT INTO productos (nombre, valor_unitario, codigo, tipo_producto) VALUES ('Polo de Rayas',18.99,'POL-003','PT');
INSERT INTO productos (nombre, valor_unitario, codigo, tipo_producto) VALUES ('Polo de Poliester',21.99,'POL-004','PT');

INSERT INTO detalles (cantidad, valor_total, factura_id, producto_id) VALUES (15,458,1,1);
INSERT INTO detalles (cantidad, valor_total, factura_id, producto_id) VALUES (17,946,1,2);
INSERT INTO detalles (cantidad, valor_total, factura_id, producto_id) VALUES (10,824,1,4);
INSERT INTO detalles (cantidad, valor_total, factura_id, producto_id) VALUES (17,983,1,5);
INSERT INTO detalles (cantidad, valor_total, factura_id, producto_id) VALUES (12,137,1,7);
INSERT INTO detalles (cantidad, valor_total, factura_id, producto_id) VALUES (18,715,2,9);
INSERT INTO detalles (cantidad, valor_total, factura_id, producto_id) VALUES (20,184,2,10);
INSERT INTO detalles (cantidad, valor_total, factura_id, producto_id) VALUES (10,276,2,11);
INSERT INTO detalles (cantidad, valor_total, factura_id, producto_id) VALUES (18,981,2,12);
INSERT INTO detalles (cantidad, valor_total, factura_id, producto_id) VALUES (16,254,3,3);
INSERT INTO detalles (cantidad, valor_total, factura_id, producto_id) VALUES (14,903,3,5);
INSERT INTO detalles (cantidad, valor_total, factura_id, producto_id) VALUES (11,360,3,6);
INSERT INTO detalles (cantidad, valor_total, factura_id, producto_id) VALUES (17,636,4,7);
INSERT INTO detalles (cantidad, valor_total, factura_id, producto_id) VALUES (14,561,4,9);
INSERT INTO detalles (cantidad, valor_total, factura_id, producto_id) VALUES (11,613,5,12);
INSERT INTO detalles (cantidad, valor_total, factura_id, producto_id) VALUES (13,488,6,1);
INSERT INTO detalles (cantidad, valor_total, factura_id, producto_id) VALUES (16,695,6,2);
INSERT INTO detalles (cantidad, valor_total, factura_id, producto_id) VALUES (12,839,6,3);
INSERT INTO detalles (cantidad, valor_total, factura_id, producto_id) VALUES (10,558,6,4);
INSERT INTO detalles (cantidad, valor_total, factura_id, producto_id) VALUES (20,661,7,2);
INSERT INTO detalles (cantidad, valor_total, factura_id, producto_id) VALUES (12,200,7,5);
INSERT INTO detalles (cantidad, valor_total, factura_id, producto_id) VALUES (12,107,7,6);
INSERT INTO detalles (cantidad, valor_total, factura_id, producto_id) VALUES (15,461,7,8);
INSERT INTO detalles (cantidad, valor_total, factura_id, producto_id) VALUES (19,925,8,9);
INSERT INTO detalles (cantidad, valor_total, factura_id, producto_id) VALUES (11,323,8,10);
INSERT INTO detalles (cantidad, valor_total, factura_id, producto_id) VALUES (17,247,8,11);
INSERT INTO detalles (cantidad, valor_total, factura_id, producto_id) VALUES (15,673,9,3);
INSERT INTO detalles (cantidad, valor_total, factura_id, producto_id) VALUES (11,623,9,4);
INSERT INTO detalles (cantidad, valor_total, factura_id, producto_id) VALUES (10,846,10,11);
INSERT INTO detalles (cantidad, valor_total, factura_id, producto_id) VALUES (15,629,10,12);

CREATE TABLE facturas_logs(
	id NUMBER(7) NOT NULL,
  operation VARCHAR2(10),

  codigo_old VARCHAR2(9),
  codigo_new VARCHAR2(9),

  valor_venta_old FLOAT,
  valor_venta_new FLOAT,

  igv_old FLOAT,
  igv_new FLOAT,

  precio_venta_old FLOAT,
  precio_venta_new FLOAT,

  fecha_creacion_old DATE,
  fecha_creacion_new DATE,

	moneda_old VARCHAR2(20),
	moneda_new VARCHAR2(20),

  executed_at DATE
);

ALTER TABLE facturas_logs ADD (
  CONSTRAINT facturas_logs_pk PRIMARY KEY (ID));

CREATE SEQUENCE facturas_logs_seq START WITH 1;

CREATE OR REPLACE TRIGGER facturas_logs_pk 
BEFORE INSERT ON facturas_logs 
FOR EACH ROW

BEGIN
  SELECT facturas_logs_seq.NEXTVAL
  INTO   :new.id
  FROM   dual;
END;
/

CREATE TABLE productos_logs(
	id NUMBER(7),
  operation VARCHAR2(10),

  nombre_old VARCHAR(40),
  nombre_new VARCHAR(40),

  valor_unitario_old FLOAT,
  valor_unitario_new FLOAT,

	codigo_old VARCHAR2(7),
	codigo_new VARCHAR2(7),

  tipo_producto_old VARCHAR2(2),
  tipo_producto_new VARCHAR2(2),

  executed_at DATE
);

ALTER TABLE productos_logs ADD (
  CONSTRAINT productos_logs_pk PRIMARY KEY (ID));

CREATE SEQUENCE productos_logs_seq START WITH 1;

CREATE OR REPLACE TRIGGER productos_logs_pk 
BEFORE INSERT ON productos_logs 
FOR EACH ROW

BEGIN
  SELECT productos_logs_seq.NEXTVAL
  INTO   :new.id
  FROM   dual;
END;
/

CREATE TABLE detalles_logs(
	id NUMBER(7) NOT NULL,
  operation VARCHAR2(10),

  cantidad_old NUMBER(8),
  cantidad_new NUMBER(8),

  valor_total_old FLOAT,
  valor_total_new FLOAT,

  factura_id_old NUMBER(7),
  factura_id_new NUMBER(7),

  producto_id_old NUMBER(7),
  producto_id_new NUMBER(7),

  executed_at DATE
);

ALTER TABLE detalles_logs ADD (
  CONSTRAINT detalles_logs_pk PRIMARY KEY (ID));

CREATE SEQUENCE detalles_logs_seq START WITH 1;

CREATE OR REPLACE TRIGGER detalles_logs_pk 
BEFORE INSERT ON detalles_logs 
FOR EACH ROW

BEGIN
  SELECT detalles_logs_seq.NEXTVAL
  INTO   :new.id
  FROM   dual;
END;
/

SET SERVEROUTPUT ON

CREATE OR REPLACE TRIGGER facturas_trigger
AFTER 
DELETE OR INSERT OR UPDATE ON facturas
REFERENCING NEW AS N OLD AS O 
FOR EACH ROW 
BEGIN 
  IF INSERTING THEN
    DBMS_OUTPUT.PUT_LINE('1++++++++++++++++++++++++++++');
    INSERT INTO facturas_logs (operation, codigo_old, codigo_new, valor_venta_old, valor_venta_new, igv_old, igv_new, precio_venta_old, precio_venta_new, fecha_creacion_old, fecha_creacion_new, moneda_old, moneda_new, executed_at) 
    VALUES ('INSERT', 'NA', :N.codigo, 0, :N.valor_venta, 0, :N.igv, 0, :N.precio_venta, TO_DATE('01/01/2000', 'dd/mm/yyyy'), :N.fecha_creacion, 'NA', :N.moneda, sysdate);
  ELSIF UPDATING THEN
    DBMS_OUTPUT.PUT_LINE('2++++++++++++++++++++++++++++');
    INSERT INTO facturas_logs (operation, codigo_old, codigo_new, valor_venta_old, valor_venta_new, igv_old, igv_new, precio_venta_old, precio_venta_new, fecha_creacion_old, fecha_creacion_new, moneda_old, moneda_new, executed_at) 
    VALUES ('UPDATE', :O.codigo, :N.codigo, :O.valor_venta, :N.valor_venta, :O.igv, :N.igv, :O.precio_venta, :N.precio_venta, :O.fecha_creacion, :N.fecha_creacion, :O.moneda, :N.moneda, sysdate);
  ELSIF DELETING THEN
    DBMS_OUTPUT.PUT_LINE('3++++++++++++++++++++++++++++');
    INSERT INTO facturas_logs (operation, codigo_old, codigo_new, valor_venta_old, valor_venta_new, igv_old, igv_new, precio_venta_old, precio_venta_new, fecha_creacion_old, fecha_creacion_new, moneda_old, moneda_new, executed_at) 
    VALUES ('DELETE', :O.codigo, 'NA', :O.valor_venta, 0, :O.igv, 0, :O.precio_venta, 0, :O.fecha_creacion, TO_DATE('01/01/2000', 'dd/mm/yyyy'), :O.moneda, 'NA', sysdate);
  END IF;
END;
/

SET SERVEROUTPUT ON

CREATE OR REPLACE TRIGGER productos_trigger
AFTER 
DELETE OR INSERT OR UPDATE ON productos
REFERENCING NEW AS N OLD AS O 
FOR EACH ROW 
BEGIN 
  IF INSERTING THEN
    DBMS_OUTPUT.PUT_LINE('1++++++++++++++++++++++++++++');
    INSERT INTO productos_logs (operation, nombre_old, nombre_new, valor_unitario_old, valor_unitario_new, codigo_old, codigo_new, tipo_producto_old, tipo_producto_new, executed_at) 
    VALUES ('INSERT', 'NA', :N.nombre, 0, :N.valor_unitario, 'NA', :N.codigo, 'NA', :N.tipo_producto, sysdate);
  ELSIF UPDATING THEN
    DBMS_OUTPUT.PUT_LINE('2++++++++++++++++++++++++++++');
    INSERT INTO productos_logs (operation, nombre_old, nombre_new, valor_unitario_old, valor_unitario_new, codigo_old, codigo_new, tipo_producto_old, tipo_producto_new, executed_at) 
    VALUES ('UPDATE', :O.nombre, :N.nombre, :O.valor_unitario, :N.valor_unitario, :O.codigo, :N.codigo, :O.tipo_producto, :N.tipo_producto, sysdate);
  ELSIF DELETING THEN
    DBMS_OUTPUT.PUT_LINE('3++++++++++++++++++++++++++++');
    INSERT INTO productos_logs (operation, nombre_old, nombre_new, valor_unitario_old, valor_unitario_new, codigo_old, codigo_new, tipo_producto_old, tipo_producto_new, executed_at)  
    VALUES ('DELETE', :O.nombre, 'NA', :O.valor_unitario, 0, :O.codigo, 'NA', :O.tipo_producto, 'NA', sysdate);
  END IF;
END;
/

SET SERVEROUTPUT ON

CREATE OR REPLACE TRIGGER detalles_trigger
AFTER 
DELETE OR INSERT OR UPDATE ON detalles
REFERENCING NEW AS N OLD AS O 
FOR EACH ROW 
BEGIN 
  IF INSERTING THEN
    DBMS_OUTPUT.PUT_LINE('1++++++++++++++++++++++++++++');
    INSERT INTO detalles_logs (operation, cantidad_old, cantidad_new, valor_total_old, valor_total_new, factura_id_old, factura_id_new, producto_id_old, producto_id_new, executed_at) 
    VALUES ('INSERT', 0, :N.cantidad, 0, :N.valor_total, 0, :N.factura_id, 0, :N.producto_id, sysdate);
  ELSIF UPDATING THEN
    DBMS_OUTPUT.PUT_LINE('2++++++++++++++++++++++++++++');
    INSERT INTO detalles_logs (operation, cantidad_old, cantidad_new, valor_total_old, valor_total_new, factura_id_old, factura_id_new, producto_id_old, producto_id_new, executed_at) 
    VALUES ('UPDATE', :O.cantidad, :N.cantidad, :O.valor_total, :N.valor_total, :O.factura_id, :N.factura_id, :O.producto_id, :N.producto_id, sysdate);
  ELSIF DELETING THEN
    DBMS_OUTPUT.PUT_LINE('3++++++++++++++++++++++++++++');
    INSERT INTO detalles_logs (operation, cantidad_old, cantidad_new, valor_total_old, valor_total_new, factura_id_old, factura_id_new, producto_id_old, producto_id_new, executed_at) 
    VALUES ('DELETE', :O.cantidad, 0, :O.valor_total, 0, :O.factura_id, 0, :O.producto_id, 0, sysdate);
  END IF;
END;
/


SET SERVEROUTPUT ON

CREATE OR REPLACE FUNCTION cantidad_productos_por_factura(fact_cod VARCHAR2)
RETURN INTEGER
AS 
  contador NUMBER(5) := 0;
  CURSOR facturas_detalles IS 
    SELECT * FROM facturas F INNER JOIN detalles D 
    ON F.id = D.factura_id
    WHERE F.codigo = fact_cod;
BEGIN  
  FOR det IN facturas_detalles LOOP
    DBMS_OUTPUT.PUT_LINE('+++++++++++++');
    DBMS_OUTPUT.PUT_LINE(det.codigo || ' ' || det.cantidad);
    contador := contador + det.cantidad;
  END LOOP;
  RETURN contador;
END cantidad_productos_por_factura;
/

SET SERVEROUTPUT ON

CREATE OR REPLACE PROCEDURE cambiar_divisa_de_factura(fact_cod VARCHAR2, moneda_nueva VARCHAR2) 
IS 
  moneda_actual VARCHAR2(20);
  factor_conversion FLOAT;
  valor_venta_actual FLOAT;
  igv_actual FLOAT;
  precio_venta_actual FLOAT;
BEGIN 
  SELECT moneda INTO moneda_actual FROM facturas WHERE codigo = fact_cod;
  SELECT valor_venta INTO valor_venta_actual FROM facturas WHERE codigo = fact_cod;
  SELECT igv INTO igv_actual FROM facturas WHERE codigo = fact_cod;
  SELECT precio_venta INTO precio_venta_actual FROM facturas WHERE codigo = fact_cod;
  DBMS_OUTPUT.PUT_LINE('Moneda actual: ' ||moneda_actual);
  DBMS_OUTPUT.PUT_LINE('Nueva moneda: ' || moneda_nueva);
  IF moneda_actual LIKE moneda_nueva THEN
    DBMS_OUTPUT.PUT_LINE('Son iguales');
    DBMS_OUTPUT.PUT_LINE('Ninguna conversion realizada');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Realizando conversion');
    IF moneda_actual LIKE 'soles' THEN
      IF moneda_nueva LIKE 'dolares' THEN factor_conversion := 1/3.57; END IF;
      IF moneda_nueva LIKE 'euros' THEN factor_conversion := 1/4.02; END IF;
    END IF;
    IF moneda_actual LIKE 'dolares' THEN
      IF moneda_nueva LIKE 'soles' THEN factor_conversion := 3.57; END IF;
      IF moneda_nueva LIKE 'euros' THEN factor_conversion := 0.89; END IF;
    END IF;
    IF moneda_actual LIKE 'euros' THEN
      IF moneda_nueva LIKE 'soles' THEN factor_conversion := 4.02; END IF;
      IF moneda_nueva LIKE 'dolares' THEN factor_conversion := 1/0.89; END IF;
    END IF;
    DBMS_OUTPUT.PUT_LINE('Factor de conversion: ' || factor_conversion);
    UPDATE facturas SET 
    moneda = moneda_nueva, 
    valor_venta = ROUND(valor_venta_actual*factor_conversion, 2),
    igv = ROUND(igv_actual*factor_conversion, 2),
    precio_venta = ROUND(valor_venta_actual*factor_conversion,2)+ROUND(igv_actual*factor_conversion, 2)
    WHERE codigo = fact_cod;
  END IF;
END cambiar_divisa_de_factura;
/
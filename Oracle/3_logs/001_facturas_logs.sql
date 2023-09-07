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
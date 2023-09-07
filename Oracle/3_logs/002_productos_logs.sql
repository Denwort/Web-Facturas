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
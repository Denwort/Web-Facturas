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
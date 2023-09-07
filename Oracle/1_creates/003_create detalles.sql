-- up
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

-- down
--DROP SEQUENCE detalles_seq;
--DROP TABLE detalles;
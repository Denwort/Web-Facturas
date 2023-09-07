-- up
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

-- down
--DROP SEQUENCE productos_seq;
--DROP TABLE productos;
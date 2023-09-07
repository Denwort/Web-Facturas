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

-- down
--DROP SEQUENCE facturas_seq;
--DROP TABLE facturas;

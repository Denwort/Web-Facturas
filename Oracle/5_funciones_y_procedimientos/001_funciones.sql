
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

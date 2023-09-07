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
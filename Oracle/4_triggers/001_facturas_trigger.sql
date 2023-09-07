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
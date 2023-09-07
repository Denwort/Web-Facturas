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
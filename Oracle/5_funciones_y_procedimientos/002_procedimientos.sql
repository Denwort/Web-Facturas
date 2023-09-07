SET SERVEROUTPUT ON

CREATE OR REPLACE PROCEDURE cambiar_divisa_de_factura(fact_cod VARCHAR2, moneda_nueva VARCHAR2) 
IS 
  moneda_actual VARCHAR2(20);
  factor_conversion FLOAT;
  valor_venta_actual FLOAT;
  igv_actual FLOAT;
  precio_venta_actual FLOAT;
BEGIN 
  SELECT moneda INTO moneda_actual FROM facturas WHERE codigo = fact_cod;
  SELECT valor_venta INTO valor_venta_actual FROM facturas WHERE codigo = fact_cod;
  SELECT igv INTO igv_actual FROM facturas WHERE codigo = fact_cod;
  SELECT precio_venta INTO precio_venta_actual FROM facturas WHERE codigo = fact_cod;
  DBMS_OUTPUT.PUT_LINE('Moneda actual: ' ||moneda_actual);
  DBMS_OUTPUT.PUT_LINE('Nueva moneda: ' || moneda_nueva);
  IF moneda_actual LIKE moneda_nueva THEN
    DBMS_OUTPUT.PUT_LINE('Son iguales');
    DBMS_OUTPUT.PUT_LINE('Ninguna conversion realizada');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Realizando conversion');
    IF moneda_actual LIKE 'soles' THEN
      IF moneda_nueva LIKE 'dolares' THEN factor_conversion := 1/3.57; END IF;
      IF moneda_nueva LIKE 'euros' THEN factor_conversion := 1/4.02; END IF;
    END IF;
    IF moneda_actual LIKE 'dolares' THEN
      IF moneda_nueva LIKE 'soles' THEN factor_conversion := 3.57; END IF;
      IF moneda_nueva LIKE 'euros' THEN factor_conversion := 0.89; END IF;
    END IF;
    IF moneda_actual LIKE 'euros' THEN
      IF moneda_nueva LIKE 'soles' THEN factor_conversion := 4.02; END IF;
      IF moneda_nueva LIKE 'dolares' THEN factor_conversion := 1/0.89; END IF;
    END IF;
    DBMS_OUTPUT.PUT_LINE('Factor de conversion: ' || factor_conversion);
    UPDATE facturas SET 
    moneda = moneda_nueva, 
    valor_venta = ROUND(valor_venta_actual*factor_conversion, 2),
    igv = ROUND(igv_actual*factor_conversion, 2),
    precio_venta = ROUND(valor_venta_actual*factor_conversion,2)+ROUND(igv_actual*factor_conversion, 2)
    WHERE codigo = fact_cod;
  END IF;
END cambiar_divisa_de_factura;

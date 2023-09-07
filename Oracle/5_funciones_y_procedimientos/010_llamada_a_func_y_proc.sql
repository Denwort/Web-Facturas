SET SERVEROUTPUT ON

BEGIN
    DBMS_OUTPUT.PUT_LINE('Cantidad productos: ' || cantidad_productos_por_factura('E001-0001'));
cambiar_divisa_de_factura('E001-0001', 'soles');
END;

UPDATE facturas SET 
    valor_venta = 61,
    igv = 10.98,
    precio_venta = 71.98
    WHERE codigo = 'E001-0001';
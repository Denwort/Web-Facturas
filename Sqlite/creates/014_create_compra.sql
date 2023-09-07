CREATE TABLE compras (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  factura_id INT,
  venta_id INT,
  proveedor_id INT,
  FOREIGN KEY (factura_id) REFERENCES facturas(id) ON DELETE CASCADE,
  FOREIGN KEY (venta_id) REFERENCES ventas(id) ON DELETE CASCADE,
  FOREIGN KEY (proveedor_id) REFERENCES proveedores(id) ON DELETE CASCADE
);

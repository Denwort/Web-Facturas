CREATE TABLE ventas (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  cliente_id INT,
  factura_id INT,
  FOREIGN KEY (cliente_id) REFERENCES clientes(id) ON DELETE CASCADE,
  FOREIGN KEY (factura_id) REFERENCES facturas(id) ON DELETE CASCADE
);
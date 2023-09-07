CREATE TABLE detalles (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  cantidad INT NOT NULL,
  valor_total FLOAT NOT NULL,
  factura_id INT,
  producto_id INT,
  FOREIGN KEY (factura_id) REFERENCES facturas(id) ON DELETE CASCADE,
  FOREIGN KEY (producto_id) REFERENCES productos(id) ON DELETE CASCADE
);
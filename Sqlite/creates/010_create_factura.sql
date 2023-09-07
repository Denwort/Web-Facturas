CREATE TABLE facturas (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  valor_venta FLOAT NOT NULL,
  IGV FLOAT NOT NULL,
  precio_venta FLOAT NOT NULL,
  fecha_creacion DATE NOT NULL,
  empresa_propia_id INT,
  moneda_id INT,
  FOREIGN KEY (empresa_propia_id) REFERENCES empresa_propia(id) ON DELETE CASCADE,
  FOREIGN KEY (moneda_id) REFERENCES monedas(id) ON DELETE CASCADE
);
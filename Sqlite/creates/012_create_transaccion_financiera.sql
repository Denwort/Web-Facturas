CREATE TABLE transacciones_financieras (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  fecha DATE NOT NULL,
  monto FLOAT NOT NULL,
  factura_id INT,
  empleado_id INT,
  forma_pago_id INT,
  FOREIGN KEY (factura_id) REFERENCES facturas(id) ON DELETE CASCADE,
  FOREIGN KEY (empleado_id) REFERENCES empleados(id) ON DELETE CASCADE,
  FOREIGN KEY (forma_pago_id) REFERENCES formas_pago(id) ON DELETE CASCADE
);
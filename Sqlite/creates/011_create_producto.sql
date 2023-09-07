CREATE TABLE productos (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  valor_unitario FLOAT NOT NULL,
  informacion_adicional TEXT  NOT NULL,
  nombre VARCHAR(20) NOT NULL,
  codigo INT NOT NULL,
  tipo_producto_id INT,
  categoria_id INT,
  unidad_medida_id INT,
  FOREIGN KEY (tipo_producto_id) REFERENCES tipos_producto(id) ON DELETE CASCADE,
  FOREIGN KEY (categoria_id) REFERENCES categorias(id) ON DELETE CASCADE,
  FOREIGN KEY (unidad_medida_id) REFERENCES unidades_medida(id) ON DELETE CASCADE
);
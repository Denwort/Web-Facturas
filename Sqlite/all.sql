CREATE TABLE clientes (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  RUC VARCHAR(11) NOT NULL,
  razon_social VARCHAR(50) NOT NULL,
  direcc_cliente VARCHAR(100) NOT NULL
);

CREATE TABLE empresa_propia (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  RUC VARCHAR(11) NOT NULL,
  razon_social VARCHAR(50) NOT NULL,
  direcc_empresa VARCHAR(100) NOT NULL
);

CREATE TABLE proveedores (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  RUC VARCHAR(11) NOT NULL,
  razon_social VARCHAR(50) NOT NULL,
  direcc_proveedor VARCHAR(100) NOT NULL
);

CREATE TABLE tipos_producto (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  nombre VARCHAR(20) NOT NULL
);

CREATE TABLE categorias (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  nombre VARCHAR(30) NOT NULL
);

CREATE TABLE unidades_medida (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  nombre VARCHAR(15) NOT NULL
);

CREATE TABLE monedas (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  nombre VARCHAR(10) NOT NULL
);

CREATE TABLE empleados (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  nombre VARCHAR(30) NOT NULL
);

CREATE TABLE formas_pago (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  nombre VARCHAR(10) NOT NULL
);

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

CREATE TABLE ventas (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  cliente_id INT,
  factura_id INT,
  FOREIGN KEY (cliente_id) REFERENCES clientes(id) ON DELETE CASCADE,
  FOREIGN KEY (factura_id) REFERENCES facturas(id) ON DELETE CASCADE
);

CREATE TABLE compras (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  factura_id INT,
  venta_id INT,
  proveedor_id INT,
  FOREIGN KEY (factura_id) REFERENCES facturas(id) ON DELETE CASCADE,
  FOREIGN KEY (venta_id) REFERENCES ventas(id) ON DELETE CASCADE,
  FOREIGN KEY (proveedor_id) REFERENCES proveedores(id) ON DELETE CASCADE
);

CREATE TABLE detalles (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  cantidad INT NOT NULL,
  valor_total FLOAT NOT NULL,
  factura_id INT,
  producto_id INT,
  FOREIGN KEY (factura_id) REFERENCES facturas(id) ON DELETE CASCADE,
  FOREIGN KEY (producto_id) REFERENCES productos(id) ON DELETE CASCADE
);


INSERT INTO clientes (RUC, razon_social, direcc_cliente) VALUES (20131366966, "MINISTERIO DEL INTERIOR (MININTER)", "Pza. 30 de Agosto Nro. 150");
INSERT INTO clientes (RUC, razon_social, direcc_cliente) VALUES (20601192404, "THE PISONAY COMPANY S.A.C", "Av. Caminos del Inca Nro. 1168");
INSERT INTO clientes (RUC, razon_social, direcc_cliente) VALUES (20559159469, "GRUPO 41 S.R.L.", "Av. Av. Porongoche Nro. 500 Int. Re02 Otr. Av. Porongoche (Mall Aventura)");
INSERT INTO clientes (RUC, razon_social, direcc_cliente) VALUES (20538810682, "KALLPA GENERACION S.A.", "Cal. las Palmeras Nro. 435 Int. 701");
INSERT INTO clientes (RUC, razon_social, direcc_cliente) VALUES (20429240752, "PRODUCTORES Y EXPORTADORES DE PALTA HASS", "Av. Nicolas Arriola Nro. 314 Int. 901 (902)");

INSERT INTO empresa_propia (RUC, razon_social, direcc_empresa) VALUES (10459583918, "AT studio S.A.C.", "Jose Maria Seguin 230, San Juan de Miraflores");

INSERT INTO proveedores(RUC, razon_social, direcc_proveedor) VALUES (20230000001, "MARIBEL", "832 Forest Place");
INSERT INTO proveedores(RUC, razon_social, direcc_proveedor) VALUES (20230000002, "GERARDO", "40802 Garrison Hill	");
INSERT INTO proveedores(RUC, razon_social, direcc_proveedor) VALUES (20230000003, "LIZETH", "43975 7th Center");
INSERT INTO proveedores(RUC, razon_social, direcc_proveedor) VALUES (20230000004, "TONY", "22 Sunbrook Hill");
INSERT INTO proveedores(RUC, razon_social, direcc_proveedor) VALUES (20230000005, "SARA", "92 Lerdahl Way");

INSERT INTO tipos_producto (nombre) VALUES ("MP");
INSERT INTO tipos_producto (nombre) VALUES ("PT");

INSERT INTO categorias (nombre) VALUES ("POLOS");
INSERT INTO categorias (nombre) VALUES ("CAMISAS");
INSERT INTO categorias (nombre) VALUES ("PANTALONES");
INSERT INTO categorias (nombre) VALUES ("VESTIDOS");
INSERT INTO categorias (nombre) VALUES ("BLUSAS");
INSERT INTO categorias (nombre) VALUES ("TELAS");
INSERT INTO categorias (nombre) VALUES ("ENVASES");

INSERT INTO unidades_medida (nombre) VALUES ("UNIDAD");
INSERT INTO unidades_medida (nombre) VALUES ("METROS");
INSERT INTO unidades_medida (nombre) VALUES ("CENTIMETROS");
INSERT INTO unidades_medida (nombre) VALUES ("METRO-CUADRADO");
INSERT INTO unidades_medida (nombre) VALUES ("KILAGRAMOS");

INSERT INTO monedas (nombre) VALUES ("SOLES");
INSERT INTO monedas (nombre) VALUES ("DOLARES");

INSERT INTO empleados (nombre) VALUES ("PIERO");
INSERT INTO empleados (nombre) VALUES ("ALAN");
INSERT INTO empleados (nombre) VALUES ("MAX");
INSERT INTO empleados (nombre) VALUES ("SAM");
INSERT INTO empleados (nombre) VALUES ("GERARDO");

INSERT INTO formas_pago (nombre) VALUES ("CONTADO");
INSERT INTO formas_pago (nombre) VALUES ("CREDITO");

INSERT INTO facturas (valor_venta, IGV, precio_venta, fecha_creacion, empresa_propia_id, moneda_id) VALUES (381.24,68.62,449.86,'2023-06-11',1,1);
INSERT INTO facturas (valor_venta, IGV, precio_venta, fecha_creacion, empresa_propia_id, moneda_id) VALUES (317.7,57.19,374.89,'2023-06-13',1,1);
INSERT INTO facturas (valor_venta, IGV, precio_venta, fecha_creacion, empresa_propia_id, moneda_id) VALUES (3753.96,675.71,4429.67,'2023-06-14',1,2);
INSERT INTO facturas (valor_venta, IGV, precio_venta, fecha_creacion, empresa_propia_id, moneda_id) VALUES (3049.3,548.87,3598.17,'2023-06-15',1,1);
INSERT INTO facturas (valor_venta, IGV, precio_venta, fecha_creacion, empresa_propia_id, moneda_id) VALUES (79,14.22,93.22,'2023-06-18',1,1);
INSERT INTO facturas (valor_venta, IGV, precio_venta, fecha_creacion, empresa_propia_id, moneda_id) VALUES (3023.04,544.15,3567.19,'2023-06-19',1,1);
INSERT INTO facturas (valor_venta, IGV, precio_venta, fecha_creacion, empresa_propia_id, moneda_id) VALUES (1749.45,314.9,2064.35,'2023-06-21',1,2);
INSERT INTO facturas (valor_venta, IGV, precio_venta, fecha_creacion, empresa_propia_id, moneda_id) VALUES (769.75,138.56,908.31,'2023-06-22',1,1);
INSERT INTO facturas (valor_venta, IGV, precio_venta, fecha_creacion, empresa_propia_id, moneda_id) VALUES (59.4,10.69,70.09,'2023-06-25',1,1);
INSERT INTO facturas (valor_venta, IGV, precio_venta, fecha_creacion, empresa_propia_id, moneda_id) VALUES (49.5,8.91,58.41,'2023-06-28',1,1);

INSERT INTO productos (valor_unitario, informacion_adicional,nombre, codigo,tipo_producto_id,categoria_id,unidad_medida_id) VALUES (19.99,'Polo de algodón suave y cómodo','Polo de Algodón','POL-001',1,1,1);
INSERT INTO productos (valor_unitario, informacion_adicional,nombre, codigo,tipo_producto_id,categoria_id,unidad_medida_id) VALUES (24.99,'Polo de manga larga con diseño moderno','Polo de Manga Larga','POL-002',1,1,1);
INSERT INTO productos (valor_unitario, informacion_adicional,nombre, codigo,tipo_producto_id,categoria_id,unidad_medida_id) VALUES (29.99,'Camisa de vestir elegante con cuello francés','Camisa de Vestir','CAM-001',1,2,1);
INSERT INTO productos (valor_unitario, informacion_adicional,nombre, codigo,tipo_producto_id,categoria_id,unidad_medida_id) VALUES (22.99,'Camisa a cuadros de manga corta en tonos neutros','Camisa a Cuadros','CAM-002',1,2,1);
INSERT INTO productos (valor_unitario, informacion_adicional,nombre, codigo,tipo_producto_id,categoria_id,unidad_medida_id) VALUES (34.99,'Pantalón chino de corte recto y tejido resistente','Pantalón Chino','PAN-001',1,3,1);
INSERT INTO productos (valor_unitario, informacion_adicional,nombre, codigo,tipo_producto_id,categoria_id,unidad_medida_id) VALUES (39.99,'Pantalón vaquero skinny de lavado oscuro','Pantalón Vaquero Skinny','PAN-002',1,3,1);
INSERT INTO productos (valor_unitario, informacion_adicional,nombre, codigo,tipo_producto_id,categoria_id,unidad_medida_id) VALUES (49.99,'Vestido de noche con escote en V y falda acampanada','Vestido de Noche','VES-001',1,4,1);
INSERT INTO productos (valor_unitario, informacion_adicional,nombre, codigo,tipo_producto_id,categoria_id,unidad_medida_id) VALUES (29.99,'Vestido de verano ligero con estampado floral','Vestido de Verano','VES-002',1,4,1);
INSERT INTO productos (valor_unitario, informacion_adicional,nombre, codigo,tipo_producto_id,categoria_id,unidad_medida_id) VALUES (26.99,'Blusa de encaje con mangas acampanadas','Blusa de Encaje','BLU-001',1,5,1);
INSERT INTO productos (valor_unitario, informacion_adicional,nombre, codigo,tipo_producto_id,categoria_id,unidad_medida_id) VALUES (32.99,'Blusa de seda con estampado floral y lazo en el cuello','Blusa de Seda','BLU-002',1,5,1);
INSERT INTO productos (valor_unitario, informacion_adicional,nombre, codigo,tipo_producto_id,categoria_id,unidad_medida_id) VALUES (12.99,'Tela de algodón de alta calidad para confección','Tela de Algodón','TEL-001',2,6,4);
INSERT INTO productos (valor_unitario, informacion_adicional,nombre, codigo,tipo_producto_id,categoria_id,unidad_medida_id) VALUES (24.99,'Tela de seda suave y brillante para prendas elegantes','Tela de Seda','TEL-002',2,6,4);
INSERT INTO productos (valor_unitario, informacion_adicional,nombre, codigo,tipo_producto_id,categoria_id,unidad_medida_id) VALUES (0.99,'Envase de plástico para almacenamiento y transporte de productos','Envase de Plástico','ENV-001',2,7,1);
INSERT INTO productos (valor_unitario, informacion_adicional,nombre, codigo,tipo_producto_id,categoria_id,unidad_medida_id) VALUES (1.99,'Envase de vidrio resistente y reutilizable para conservas','Envase de Vidrio','ENV-002',2,7,1);
INSERT INTO productos (valor_unitario, informacion_adicional,nombre, codigo,tipo_producto_id,categoria_id,unidad_medida_id) VALUES (0.79,'Envase de cartón ecológico para empaquetado de alimentos','Envase de Cartón','ENV-003',2,7,1);

INSERT INTO transacciones_financieras (fecha, monto, factura_id, empleado_id, forma_pago_id) VALUES ('2023-06-11',449.86,1,4,1);
INSERT INTO transacciones_financieras (fecha, monto, factura_id, empleado_id, forma_pago_id) VALUES ('2023-06-13',374.89,2,1,1);
INSERT INTO transacciones_financieras (fecha, monto, factura_id, empleado_id, forma_pago_id) VALUES ('2023-06-15',2214.835,3,5,2);
INSERT INTO transacciones_financieras (fecha, monto, factura_id, empleado_id, forma_pago_id) VALUES ('2023-06-16',2214.835,3,5,2);
INSERT INTO transacciones_financieras (fecha, monto, factura_id, empleado_id, forma_pago_id) VALUES ('2023-06-15',3598.17,4,5,1);
INSERT INTO transacciones_financieras (fecha, monto, factura_id, empleado_id, forma_pago_id) VALUES ('2023-06-19',50.11,5,4,2);
INSERT INTO transacciones_financieras (fecha, monto, factura_id, empleado_id, forma_pago_id) VALUES ('2023-06-20',43.11,5,5,2);
INSERT INTO transacciones_financieras (fecha, monto, factura_id, empleado_id, forma_pago_id) VALUES ('2023-06-19',3567.19,6,5,1);
INSERT INTO transacciones_financieras (fecha, monto, factura_id, empleado_id, forma_pago_id) VALUES ('2023-06-21',2064.35,7,2,1);
INSERT INTO transacciones_financieras (fecha, monto, factura_id, empleado_id, forma_pago_id) VALUES ('2023-06-23',227.0775,8,1,2);
INSERT INTO transacciones_financieras (fecha, monto, factura_id, empleado_id, forma_pago_id) VALUES ('2023-06-24',227.0775,8,5,2);
INSERT INTO transacciones_financieras (fecha, monto, factura_id, empleado_id, forma_pago_id) VALUES ('2023-06-25',227.0775,8,2,2);
INSERT INTO transacciones_financieras (fecha, monto, factura_id, empleado_id, forma_pago_id) VALUES ('2023-06-25',227.0775,9,1,1);
INSERT INTO transacciones_financieras (fecha, monto, factura_id, empleado_id, forma_pago_id) VALUES ('2023-06-28',58.41,10,3,1);

INSERT INTO ventas (cliente_id, factura_id) VALUES (4,1);
INSERT INTO ventas (cliente_id, factura_id) VALUES (3,3);
INSERT INTO ventas (cliente_id, factura_id) VALUES (2,6);
INSERT INTO ventas (cliente_id, factura_id) VALUES (1,9);

INSERT INTO compras (factura_id, venta_id, proveedor_id) VALUES (2,1,5);
INSERT INTO compras (factura_id, venta_id, proveedor_id) VALUES (4,2,3);
INSERT INTO compras (factura_id, venta_id, proveedor_id) VALUES (5,2,4);
INSERT INTO compras (factura_id, venta_id, proveedor_id) VALUES (7,3,1);
INSERT INTO compras (factura_id, venta_id, proveedor_id) VALUES (8,3,3);
INSERT INTO compras (factura_id, venta_id, proveedor_id) VALUES (10,4,2);

INSERT INTO detalles (cantidad, valor_total, factura_id, producto_id) VALUES (10,249.9,1,2);
INSERT INTO detalles (cantidad, valor_total, factura_id, producto_id) VALUES (15,14.85,1,11);
INSERT INTO detalles (cantidad, valor_total, factura_id, producto_id) VALUES (10,299.88,2,2);
INSERT INTO detalles (cantidad, valor_total, factura_id, producto_id) VALUES (15,17.82,2,11);
INSERT INTO detalles (cantidad, valor_total, factura_id, producto_id) VALUES (30,1259.64,3,5);
INSERT INTO detalles (cantidad, valor_total, factura_id, producto_id) VALUES (40,2399.52,3,7);
INSERT INTO detalles (cantidad, valor_total, factura_id, producto_id) VALUES (100,94.8,3,13);
INSERT INTO detalles (cantidad, valor_total, factura_id, producto_id) VALUES (30,1049.7,4,5);
INSERT INTO detalles (cantidad, valor_total, factura_id, producto_id) VALUES (40,1999.6,4,7);
INSERT INTO detalles (cantidad, valor_total, factura_id, producto_id) VALUES (100,79,5,13);
INSERT INTO detalles (cantidad, valor_total, factura_id, producto_id) VALUES (20,719.76,6,3);
INSERT INTO detalles (cantidad, valor_total, factura_id, producto_id) VALUES (15,719.82,6,6);
INSERT INTO detalles (cantidad, valor_total, factura_id, producto_id) VALUES (35,1259.58,6,8);
INSERT INTO detalles (cantidad, valor_total, factura_id, producto_id) VALUES (10,323.88,6,9);
INSERT INTO detalles (cantidad, valor_total, factura_id, producto_id) VALUES (20,599.8,7,3);
INSERT INTO detalles (cantidad, valor_total, factura_id, producto_id) VALUES (10,399.9,7,6);
INSERT INTO detalles (cantidad, valor_total, factura_id, producto_id) VALUES (25,749.75,7,8);
INSERT INTO detalles (cantidad, valor_total, factura_id, producto_id) VALUES (5,199.95,8,6);
INSERT INTO detalles (cantidad, valor_total, factura_id, producto_id) VALUES (10,299.9,8,8);
INSERT INTO detalles (cantidad, valor_total, factura_id, producto_id) VALUES (10,269.9,8,9);
INSERT INTO detalles (cantidad, valor_total, factura_id, producto_id) VALUES (50,59.4,9,11);
INSERT INTO detalles (cantidad, valor_total, factura_id, producto_id) VALUES (50,49.5,10,11);

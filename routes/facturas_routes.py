from bottle import Bottle, run, template, request, redirect
from sqlalchemy import text
from database import engine

subapp = Bottle()


############# variable
@subapp.route('/', method='GET')
def facturas():
  # mensaje
  mensaje = request.params.mensaje
  # acceso a db
  conn = engine.connect()
  stmt = text(("""
    SELECT * FROM (
    	SELECT F.id, "Venta" AS transaccion, CL.razon_social, F.fecha_creacion, F.valor_venta, F.IGV, F.precio_venta, M.nombre AS moneda
    	FROM facturas F
    	INNER JOIN monedas M ON F.moneda_id = M.id
    	INNER JOIN ventas V ON F.id = V.factura_id
    	INNER JOIN clientes CL ON V.cliente_id = CL.id
    	UNION
    	SELECT F.id, "Compra"AS transaccion, PR.razon_social , F.fecha_creacion, F.valor_venta, F.IGV, F.precio_venta, M.nombre AS moneda
    	FROM facturas F
    	INNER JOIN monedas M ON F.moneda_id = M.id
    	INNER JOIN compras C ON F.id = C.factura_id
    	INNER JOIN proveedores PR ON C.proveedor_id = PR.id
    )
    ORDER BY id ASC
    """).format())
  rows = conn.execute(stmt)

  detalles = []
  for row in rows:
    stmt2 = text(("""
    SELECT D.id, P.nombre, D.cantidad, D.valor_total FROM detalles D INNER JOIN productos P ON D.producto_id = P.id WHERE factura_id = {}
    """).format(row[0]))
    respuesta = conn.execute(stmt2)
    detalles.append(respuesta)

  rows = conn.execute(stmt)

  conn.close()
  locals = {'contenido': rows, 'mensaje': mensaje, 'detalles': detalles}
  # respuesta
  return template('facturas/facturas', locals)


############# editar variable
@subapp.route('/edit', method='GET')
def facturas_edit():
  id = int(request.params.id)
  # acceso a db
  conn = engine.connect()
  stmt = text(("SELECT * FROM facturas WHERE id = {}").format(id))
  facturas = conn.execute(stmt).fetchone()
  stmt = text(("SELECT * FROM monedas").format())
  monedas = conn.execute(stmt)

  conn.close()
  locals = {'facturas': facturas, 'id': id, 'monedas': monedas}
  # respuesta
  return template('facturas/facturas_edit', locals)


############# Borrar variable
@subapp.route('/delete', method='GET')
def facturas_delete():
  id = int(request.params.id)
  # acceso a db
  conn = engine.connect()
  stmt = text(("DELETE FROM facturas WHERE id = {}").format(id))
  conn.execute(stmt)
  conn.commit()
  conn.close()
  # respuesta
  return redirect("/facturas?mensaje=Se ha eliminado una Factura")


############# Crear variable
@subapp.route('/new', method='GET')
def facturas_new():
  # acceso a db
  contenido = (0, "", "", "", "", "", "")
  conn = engine.connect()
  stmt = text(("SELECT * FROM monedas").format())
  monedas = conn.execute(stmt)

  ## David estuvo aqui

  stmt = text(("SELECT * FROM clientes").format())
  clientes = conn.execute(stmt)
  stmt = text(("SELECT * FROM proveedores").format())
  proveedores = conn.execute(stmt)
  stmt = text(("""
  SELECT V.id, C.razon_social, F.fecha_creacion
  FROM ventas V INNER JOIN clientes C ON V.cliente_id = C.id
	INNER JOIN facturas F ON V.factura_id = F.id
  """).format())
  ventas = conn.execute(stmt)
  stmt = text(("SELECT * FROM empresa_propia").format())
  empresa_propia = conn.execute(stmt).fetchone()

  conn.close()

  locals = {
    'facturas': contenido,
    'id': 0,
    'empresa_propia': empresa_propia,
    'monedas': monedas,
    'clientes': clientes,
    'proveedores': proveedores,
    'ventas': ventas
  }
  # respuesta
  return template('facturas/facturas_new', locals)


############# Guardar variable
@subapp.route('/save', method='POST')
def facturas_save():
  moneda_id = int(request.forms.get('moneda_id'))
  fecha_creacion = request.forms.get('fecha_creacion')
  #precio_venta = float(request.forms.get('precio_venta'))
  #IGV = float(request.forms.get('IGV'))
  valor_venta = float(request.forms.get('valor_venta'))
  id = int(request.forms.get('id'))
  # acceso a db
  conn = engine.connect()
  mensaje = ""
  if id == 0:
    # crear
    transaccion = request.forms.get('transaccion')
    cliente_id = int(request.forms.get('cliente_id'))
    proveedor_id = int(request.forms.get('proveedor_id'))
    venta_id = int(request.forms.get('venta_id'))
    stmt = text((
      "INSERT INTO facturas (valor_venta, IGV, precio_venta, fecha_creacion, empresa_propia_id, moneda_id) VALUES ('{}','{}','{}','{}','{}','{}')"
    ).format(valor_venta, valor_venta * 0.18, valor_venta * 1.18,
             fecha_creacion, 1, moneda_id))

    rs = conn.execute(stmt)
    conn.commit()
    factura_id = rs.lastrowid

    # crear registro en Compra o Venta
    if (transaccion == "V"):
      stmt = text(
        ("INSERT INTO ventas (cliente_id, factura_id) VALUES ({},{})").format(
          cliente_id, factura_id))
    elif (transaccion == "C"):
      stmt = text((
        "INSERT INTO compras (proveedor_id, factura_id, venta_id) VALUES ({},{},{})"
      ).format(proveedor_id, factura_id, venta_id))

    mensaje = "Factura creada con éxito"
  else:
    # editar
    stmt = text((
      "UPDATE facturas SET valor_venta = '{}', IGV ='{}', precio_venta = '{}', fecha_creacion = '{}', moneda_id = '{}' WHERE id = {}"
    ).format(valor_venta, valor_venta * 0.18, valor_venta * 1.18,
             fecha_creacion, moneda_id, id))
    mensaje = "Factura editada con éxito"
  conn.execute(stmt)
  conn.commit()
  conn.close()
  return redirect("/facturas?mensaje=" + mensaje)

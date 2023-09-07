from bottle import Bottle, run, template, request, redirect
from sqlalchemy import text
from database import engine

subapp = Bottle()


############# variable
@subapp.route('/', method='GET')
def detalles():
  # mensaje
  mensaje = request.params.mensaje
  # acceso a db
  conn = engine.connect()
  stmt = text(("""
    SELECT D.id, D.cantidad, P.nombre, D.valor_total, D.factura_id
FROM detalles D
INNER JOIN productos P ON D.producto_id = P.id
""").format())
  rows = conn.execute(stmt)
  conn.close()
  locals = {'contenido': rows, 'mensaje': mensaje}
  # respuesta
  return template('detalles/detalles', locals)


@subapp.route('/new', method='GET')
def detalles_new():
  # acceso a db
  contenido = (0, 0, 0, 0)
  factura_id = int(request.params.factura_id)
  conn = engine.connect()
  stmt = text(("SELECT * FROM productos").format())
  productos = conn.execute(stmt)
  stmt = text(("SELECT * FROM facturas").format())
  facturas = conn.execute(stmt)

  if (factura_id == 0):
    # Haciendo New desde detalles
    print("xd")
  else:
    # Haciendo New desde Factura
    print("xd")

  conn.close()
  locals = {
    'id': 0,
    'factura_id': factura_id,
    'facturas': facturas,
    'productos': productos,
    'contenido': contenido,
  }
  # respuesta
  return template('detalles/detalles_new', locals)


@subapp.route('/save', method='POST')
def detalles_save():
  factura_id = request.forms.get('factura_id')
  cantidad = request.forms.get('cantidad')
  producto_id = request.forms.get('producto_id')
  valor_total = request.forms.get('valor_total')
  id = int(request.forms.get('id'))
  conn = engine.connect()
  mensaje = ""
  if id == 0:
    # crear
    stmt = text((
      "INSERT INTO detalles (cantidad, valor_total, factura_id, producto_id) VALUES ({}, {}, {}, {})"
    ).format(cantidad, valor_total, factura_id, producto_id))
    mensaje = "Detalle creado con éxito"
  else:
    # edit
    stmt = text((
      "UPDATE detalles SET cantidad = '{}', valor_total={}, factura_id={}, producto_id={} WHERE id = {}"
    ).format(cantidad, valor_total, factura_id, producto_id, id))
    mensaje = "Detalle editado con éxito"
  conn.execute(stmt)
  conn.commit()
  conn.close()
  return redirect("/facturas?mensaje=" + mensaje)


@subapp.route('/edit', method='GET')
def detalles_edit():
  id = int(request.params.id)
  # acceso a db
  conn = engine.connect()
  stmt = text(("SELECT * FROM detalles WHERE id = {}").format(id))
  contenido = conn.execute(stmt).fetchone()
  stmt = text(("SELECT * FROM facturas").format())
  facturas = conn.execute(stmt)
  stmt = text(("SELECT * FROM productos").format())
  productos = conn.execute(stmt)

  factura_id = 0

  conn.close()
  locals = {
    'contenido': contenido,
    'factura_id': factura_id,
    'id': id,
    'productos': productos,
    'facturas': facturas
  }
  return template('detalles/detalles_edit', locals)


@subapp.route('/delete', method='GET')
def detalles_delete():
  id = int(request.params.id)
  conn = engine.connect()
  stmt = text(("DELETE FROM detalles WHERE id = {}").format(id))
  conn.execute(stmt)
  conn.commit()
  conn.close()
  # respuesta
  return redirect("/facturas?mensaje=Se ha eliminado una Compra")


########################################## FIN DE - Detalles

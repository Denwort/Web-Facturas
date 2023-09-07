from bottle import Bottle, run, template, request, redirect
from sqlalchemy import text
from database import engine

subapp = Bottle()


@subapp.route('/', method='GET')
def transaccionesfinancieras():
  # mensaje
  mensaje = request.params.mensaje
  # acceso a db
  conn = engine.connect()
  stmt = text(("""
    SELECT T.id, T.fecha, T.monto, F.id, E.nombre, FP.nombre 
    FROM transacciones_financieras T
    INNER JOIN facturas F ON T.factura_id = F.id
    INNER JOIN empleados E ON T.empleado_id = E.id
    INNER JOIN formas_pago FP ON T.forma_pago_id = FP.id
    """).format())
  rows = conn.execute(stmt)
  conn.close()
  locals = {'contenido': rows, 'mensaje': mensaje}
  # respuesta
  return template('transacciones_financieras/transacciones_financieras',
                  locals)


@subapp.route('/new', method='GET')
def transaccionesfinancieras_new():
  # acceso a db
  contenido = (0, "", 0, 0, 0, 0)
  conn = engine.connect()
  stmt = text(("SELECT * FROM facturas").format())
  facturas = conn.execute(stmt)
  stmt = text(("SELECT * FROM empleados").format())
  empleados = conn.execute(stmt)
  stmt = text(("SELECT * FROM formas_pago").format())
  formas_pago = conn.execute(stmt)
  conn.close()
  locals = {
    'contenido': contenido,
    'id': 0,
    'facturas': facturas,
    'empleados': empleados,
    'formas_pago': formas_pago
  }
  # respuesta
  return template('transacciones_financieras/transacciones_financieras_new',
                  locals)


@subapp.route('/save', method='POST')
def productos_save():
  id = int(request.forms.get('id'))
  fecha = request.forms.get('fecha')
  monto = float(request.forms.get('monto'))
  factura_id = int(request.forms.get('factura_id'))
  empleado_id = int(request.forms.get('empleado_id'))
  forma_pago_id = request.forms.get('forma_pago_id')

  # acceso a db
  conn = engine.connect()
  mensaje = ""
  if id == 0:
    # crear
    stmt = text((
      "INSERT INTO transacciones_financieras (fecha, monto, factura_id, empleado_id, forma_pago_id) VALUES ('{}',{},{},{},{})"
    ).format(fecha, monto, factura_id, empleado_id, forma_pago_id))
    mensaje = "Transaccion financiera creada con éxito"
  else:
    # editar
    stmt = text((
      "UPDATE transacciones_financieras SET fecha = '{}', monto ={}, factura_id = {}, empleado_id = {}, forma_pago_id = {} WHERE id = {}"
    ).format(fecha, monto, factura_id, empleado_id, forma_pago_id, id))
    mensaje = "Transaccion financiera editada con éxito"
  conn.execute(stmt)
  conn.commit()
  conn.close()
  return redirect("/transacciones_financieras?mensaje=" + mensaje)


@subapp.route('/edit', method='GET')
def productos_edit():
  id = int(request.params.id)
  # acceso a db
  conn = engine.connect()
  stmt = text(
    ("SELECT * FROM transacciones_financieras WHERE id = {}").format(id))
  contenido = conn.execute(stmt).fetchone()
  stmt = text(("SELECT * FROM facturas").format())
  facturas = conn.execute(stmt)
  stmt = text(("SELECT * FROM empleados").format())
  empleados = conn.execute(stmt)
  stmt = text(("SELECT * FROM formas_pago").format())
  formas_pago = conn.execute(stmt)
  conn.close()
  locals = {
    'contenido': contenido,
    'id': id,
    'facturas': facturas,
    'empleados': empleados,
    'formas_pago': formas_pago
  }
  # respuesta
  return template('transacciones_financieras/transacciones_financieras_edit',
                  locals)

@subapp.route('/delete', method='GET')
def productos_delete():
  id = int(request.params.id)
  # acceso a db
  conn = engine.connect()
  stmt = text(("DELETE FROM transacciones_financieras WHERE id = {}").format(id))
  conn.execute(stmt)
  conn.commit()
  conn.close()
  # respuesta
  return redirect("/transacciones_financieras?mensaje=Se ha eliminado una Transaccion Financiera")
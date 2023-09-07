from bottle import Bottle, run, template, request, redirect
from sqlalchemy import text
from database import engine

subapp = Bottle()

########################################## INICIO DE - Lista de Ventas
## FALA CORREGIR


############# variable
@subapp.route('/', method='GET')
def ventas():
  # mensaje
  mensaje = request.params.mensaje
  # acceso a db
  conn = engine.connect()
  stmt = text(("""
    SELECT V.id, C.razon_social, F.fecha_creacion, F.valor_venta, M.nombre
    FROM ventas V INNER JOIN clientes C ON V.cliente_id = C.id
	INNER JOIN facturas F ON V.factura_id = F.id
	INNER JOIN monedas M ON F.moneda_id = M.id""").format())
  rows = conn.execute(stmt)
  conn.close()
  locals = {'contenido': rows, 'mensaje': mensaje}
  # respuesta
  return template('ventas/ventas', locals)


@subapp.route('/edit', method='GET')
def productos_edit():
  id = int(request.params.id)
  # acceso a db
  conn = engine.connect()
  stmt = text(("SELECT * FROM ventas WHERE id = {}").format(id))
  ventas = conn.execute(stmt).fetchone()
  stmt = text(("SELECT id, razon_social FROM clientes").format())
  clientes = conn.execute(stmt)
  stmt = text(("SELECT * FROM facturas").format())
  facturas = conn.execute(stmt)
  conn.close()
  locals = {
    'ventas': ventas,
    'id': id,
    'clientes': clientes,
    'facturas': facturas
  }
  return template('ventas/ventas_edit', locals)


@subapp.route('/save', method='POST')
def ventas_save():
  cliente_id = request.forms.get('cliente_id')
  factura_id = request.forms.get('factura_id')
  id = int(request.forms.get('id'))
  # Solo edit
  conn = engine.connect()
  stmt = text(
    ("UPDATE ventas SET cliente_id = {},factura_id = {} WHERE id = {}").format(
      cliente_id, factura_id, id))
  conn.execute(stmt)
  conn.commit()
  conn.close()
  mensaje = "Se ha editado correctamente"
  return redirect("/ventas?mensaje=" + mensaje)


@subapp.route('/delete', method='GET')
def ventas_delete():
  id = int(request.params.id)
  # acceso a db
  conn = engine.connect()
  stmt = text(("DELETE FROM ventas WHERE id = {}").format(id))
  conn.execute(stmt)
  conn.commit()
  conn.close()
  # respuesta
  return redirect("/ventas?mensaje=Se ha eliminado una Factura")


########################################## FIN DE - Lista de Ventas

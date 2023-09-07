from bottle import Bottle, run, template, request, redirect
from sqlalchemy import text
from database import engine

subapp = Bottle()


############# variable
@subapp.route('/', method='GET')
def compras():
  # mensaje
  mensaje = request.params.mensaje
  # acceso a db
  conn = engine.connect()
  stmt = text(("""
    SELECT compra_id, proveedor, compra_fecha, cliente_razon_social, F.fecha_creacion AS venta_fecha, compra_valor_venta, divisa FROM (
	SELECT C.id AS compra_id, P.razon_social AS proveedor, F.fecha_creacion AS compra_fecha, V.id AS venta_id, CL.razon_social AS cliente_razon_social, F.valor_venta AS compra_valor_venta, M.nombre AS divisa
	FROM compras C
	INNER JOIN facturas F ON C.factura_id = F.id
	INNER JOIN ventas V ON C.venta_id = V.id
	INNER JOIN clientes CL ON V.cliente_id = CL.id
	INNER JOIN proveedores P ON C.proveedor_id = P.id
	INNER JOIN monedas M ON F.moneda_id = M.id
)
INNER JOIN ventas V ON venta_id = V.id
INNER JOIN facturas F on V.factura_id = F.id
""").format())
  rows = conn.execute(stmt)
  conn.close()
  locals = {'contenido': rows, 'mensaje': mensaje}
  # respuesta
  return template('compras/compras', locals)


############# editar variable
@subapp.route('/edit', method='GET')
def compras_edit():
  id = int(request.params.id)
  # acceso a db
  conn = engine.connect()
  stmt = text(("SELECT * FROM compras WHERE id = {}").format(id))
  compras = conn.execute(stmt).fetchone()
  stmt = text(("SELECT id, razon_social FROM proveedores").format())
  proveedores = conn.execute(stmt)
  stmt = text(("SELECT * FROM facturas").format())
  facturas = conn.execute(stmt)
  stmt = text(("SELECT * FROM ventas").format())
  ventas = conn.execute(stmt)

  conn.close()
  locals = {
    'compras': compras,
    'id': id,
    'proveedores': proveedores,
    'facturas': facturas,
    'ventas': ventas,
  }
  # respuesta
  return template('compras/compras_edit', locals)


@subapp.route('/save', method='POST')
def compras_save():
  venta_id = request.forms.get('venta_id')
  proveedor_id = request.forms.get('proveedor_id')
  factura_id = request.forms.get('factura_id')
  id = int(request.forms.get('id'))
  # Solo edit
  conn = engine.connect()
  stmt = text((
    "UPDATE compras SET venta_id = {}, proveedor_id = {}, factura_id = {} WHERE id = {}"
  ).format(venta_id, proveedor_id, factura_id, id))
  conn.execute(stmt)
  conn.commit()
  conn.close()
  mensaje = "Se ha editado correctamente"
  return redirect("/compras?mensaje=" + mensaje)


############# Borrar variable
@subapp.route('/delete', method='GET')
def compras_delete():
  id = int(request.params.id)
  # acceso a db
  conn = engine.connect()
  stmt = text(("DELETE FROM compras WHERE id = {}").format(id))
  conn.execute(stmt)
  conn.commit()
  conn.close()
  # respuesta
  return redirect("/compras?mensaje=Se ha eliminado una Compra")

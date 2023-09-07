from bottle import Bottle, run, template, request, redirect
from sqlalchemy import text
from database import engine

subapp = Bottle()


############# variable
@subapp.route('/', method='GET')
def productos():
  # mensaje
  mensaje = request.params.mensaje
  # acceso a db
  conn = engine.connect()
  stmt = text((
    "SELECT P.id, P.nombre, P.valor_unitario, P.codigo, P.informacion_adicional, TP.id AS tipo_id, TP.nombre, C.id AS cate_id, C.nombre, UM.id AS unid_id, UM.nombre FROM productos P INNER JOIN tipos_producto TP ON P.tipo_producto_id = tipo_id INNER JOIN categorias C ON P.categoria_id = cate_id INNER JOIN unidades_medida UM ON P.unidad_medida_id = unid_id"
  ).format())
  rows = conn.execute(stmt)
  conn.close()
  locals = {'contenido': rows, 'mensaje': mensaje}
  # respuesta
  return template('productos/productos', locals)


############# editar variable
@subapp.route('/edit', method='GET')
def productos_edit():
  id = int(request.params.id)
  # acceso a db
  conn = engine.connect()
  stmt = text(("SELECT * FROM productos WHERE id = {}").format(id))
  productos = conn.execute(stmt).fetchone()
  stmt = text(("SELECT * FROM tipos_producto").format())
  tipos_producto = conn.execute(stmt)
  stmt = text(("SELECT * FROM categorias").format())
  categorias = conn.execute(stmt)
  stmt = text(("SELECT * FROM unidades_medida").format())
  unidades_medida = conn.execute(stmt)
  conn.close()
  locals = {
    'productos': productos,
    'id': id,
    'tipos_producto': tipos_producto,
    'categorias': categorias,
    'unidades_medida': unidades_medida
  }
  # respuesta
  return template('productos/productos_edit', locals)


############# Borrar variable
@subapp.route('/delete', method='GET')
def productos_delete():
  id = int(request.params.id)
  # acceso a db
  conn = engine.connect()
  stmt = text(("DELETE FROM productos WHERE id = {}").format(id))
  conn.execute(stmt)
  conn.commit()
  conn.close()
  # respuesta
  return redirect("/productos?mensaje=Se ha eliminado un Producto")


############# Crear variable
@subapp.route('/new', method='GET')
def productos_new():
  # acceso a db
  contenido = (0, "", "", "", "", "", "", "")
  conn = engine.connect()
  stmt = text(("SELECT * FROM tipos_producto").format())
  tipos_producto = conn.execute(stmt)
  stmt = text(("SELECT * FROM categorias").format())
  categorias = conn.execute(stmt)
  stmt = text(("SELECT * FROM unidades_medida").format())
  unidades_medida = conn.execute(stmt)
  conn.close()
  locals = {
    'productos': contenido,
    'id': 0,
    'tipos_producto': tipos_producto,
    'categorias': categorias,
    'unidades_medida': unidades_medida
  }
  # respuesta
  return template('productos/productos_new', locals)


############# Guardar variable
@subapp.route('/save', method='POST')
def productos_save():
  tipo_producto_id = int(request.forms.get('tipo_producto_id'))
  unidad_medida_id = int(request.forms.get('unidad_medida_id'))
  informacion_adicional = request.forms.get('informacion_adicional')
  categoria_id = int(request.forms.get('categoria_id'))
  codigo = request.forms.get('codigo')
  valor_unitario = float(request.forms.get('valor_unitario'))
  nombre = request.forms.get('nombre')
  id = int(request.forms.get('id'))
  # acceso a db
  conn = engine.connect()
  mensaje = ""
  if id == 0:
    # crear
    stmt = text((
      "INSERT INTO productos (nombre, valor_unitario, codigo, informacion_adicional, unidad_medida_id, categoria_id, tipo_producto_id) VALUES ('{}','{}','{}','{}','{}','{}','{}')"
    ).format(nombre, valor_unitario, codigo, informacion_adicional,
             unidad_medida_id, categoria_id, tipo_producto_id))
    mensaje = "Producto creada con éxito"
  else:
    # editar
    stmt = text((
      "UPDATE productos SET nombre = '{}', valor_unitario ='{}', codigo = '{}', informacion_adicional = '{}', unidad_medida_id = '{}', categoria_id = '{}', tipo_producto_id = '{}' WHERE id = {}"
    ).format(nombre, valor_unitario, codigo, informacion_adicional,
             unidad_medida_id, categoria_id, tipo_producto_id, id))
    mensaje = "Producto editado con éxito"
  conn.execute(stmt)
  conn.commit()
  conn.close()
  return redirect("/productos?mensaje=" + mensaje)

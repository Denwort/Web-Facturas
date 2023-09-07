from bottle import Bottle, run, template, request, redirect
from sqlalchemy import text
from database import engine

subapp = Bottle()

############# variable
@subapp.route('/', method='GET')
def tipos_producto():
  # mensaje
  mensaje = request.params.mensaje

  # nombre de la entidad
  conn = engine.connect()
  stmt = text(("SELECT * FROM tipos_producto").format())
  rows = conn.execute(stmt)

  # Almacenar los artistas para pasarlos al tpl
  locals = {'contenido': rows, 'mensaje': mensaje}

  # respuesta
  return template('tipos_producto/tipos_producto', locals)


############# editar variable
@subapp.route('/edit', method='GET')
def tipos_producto_edit():
  id = int(request.params.id)
  # acceso a db
  conn = engine.connect()
  stmt = text(("SELECT * FROM tipos_producto WHERE id = {}").format(id))
  contenido = conn.execute(stmt).fetchone()
  conn.close()
  locals = {'contenido': contenido, 'id': id}
  # respuesta
  return template('tipos_producto/tipos_producto_edit', locals)


############# Borrar variable
@subapp.route('/delete', method='GET')
def tipos_producto_delete():
  id = int(request.params.id)
  # acceso a db
  conn = engine.connect()
  stmt = text(("DELETE FROM tipos_producto WHERE id = {}").format(id))
  conn.execute(stmt)
  conn.commit()
  conn.close()
  # respuesta
  return redirect(
    "/tipos_producto?mensaje=Se ha eliminado un Tipo de Producto")


############# Crear variable
@subapp.route('/new', method='GET')
def tipos_producto_new():
  # acceso a db
  contenido = (0, "")
  locals = {'contenido': contenido, 'id': 0}
  # respuesta
  return template('tipos_producto/tipos_producto_new', locals)


############# Guardar variable
@subapp.route('/save', method='POST')
def tipos_producto_save():
  nombre = request.forms.get('nombre')
  id = int(request.forms.get('id'))
  # acceso a db
  conn = engine.connect()
  mensaje = ""
  if id == 0:
    # crear
    stmt = text(
      ("INSERT INTO tipos_producto (nombre) VALUES ('{}')").format(nombre))
    mensaje = "Tipo de Producto creado con éxito"
  else:
    stmt = text(
      ("UPDATE tipos_producto SET nombre = '{}' WHERE id = {}").format(
        nombre, id))
    mensaje = "Tipo de Producto editado con éxito"
  conn.execute(stmt)
  conn.commit()
  conn.close()
  return redirect("/tipos_producto?mensaje=" + mensaje)


########################################## FIN DE - Lista de Tipos de Producto

from bottle import Bottle, run, template, request, redirect
from sqlalchemy import text
from database import engine

subapp = Bottle()

############# variable
@subapp.route('/', method='GET')
def unidades_medida():
  # mensaje
  mensaje = request.params.mensaje

  # nombre de la entidad
  conn = engine.connect()
  stmt = text(("SELECT * FROM unidades_medida").format())
  rows = conn.execute(stmt)

  # Almacenar los artistas para pasarlos al tpl
  locals = {'contenido': rows, 'mensaje': mensaje}

  # respuesta
  return template('unidades_medida/unidades_medida', locals)


############# editar variable
@subapp.route('/edit', method='GET')
def unidades_medida_edit():
  id = int(request.params.id)
  # acceso a db
  conn = engine.connect()
  stmt = text(("SELECT * FROM unidades_medida WHERE id = {}").format(id))
  contenido = conn.execute(stmt).fetchone()
  conn.close()
  locals = {'contenido': contenido, 'id': id}
  # respuesta
  return template('unidades_medida/unidades_medida_edit', locals)


############# Borrar variable
@subapp.route('/delete', method='GET')
def unidades_medida_delete():
  id = int(request.params.id)
  # acceso a db
  conn = engine.connect()
  stmt = text(("DELETE FROM unidades_medida WHERE id = {}").format(id))
  conn.execute(stmt)
  conn.commit()
  conn.close()
  # respuesta
  return redirect(
    "/unidades_medida?mensaje=Se ha eliminado una Unidad de Medida")


############# Crear variable
@subapp.route('/new', method='GET')
def unidades_medida_new():
  # acceso a db
  contenido = (0, "")
  locals = {'contenido': contenido, 'id': 0}
  # respuesta
  return template('unidades_medida/unidades_medida_new', locals)


############# Guardar variable
@subapp.route('/save', method='POST')
def unidades_medida_save():
  nombre = request.forms.get('nombre')
  id = int(request.forms.get('id'))
  # acceso a db
  conn = engine.connect()
  mensaje = ""
  if id == 0:
    # crear
    stmt = text(
      ("INSERT INTO unidades_medida (nombre) VALUES ('{}')").format(nombre))
    mensaje = "Unidad de Medida creada con éxito"
  else:
    stmt = text(
      ("UPDATE unidades_medida SET nombre = '{}' WHERE id = {}").format(
        nombre, id))
    mensaje = "Unidad de Medida editada con éxito"
  conn.execute(stmt)
  conn.commit()
  conn.close()
  return redirect("/unidades_medida?mensaje=" + mensaje)
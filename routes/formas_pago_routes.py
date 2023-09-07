from bottle import Bottle, run, template, request, redirect
from sqlalchemy import text
from database import engine

subapp = Bottle()

############# variable
@subapp.route('/', method='GET')
def formas_pago():
  # mensaje
  mensaje = request.params.mensaje

  # nombre de la entidad
  conn = engine.connect()
  stmt = text(("SELECT * FROM formas_pago").format())
  rows = conn.execute(stmt)

  # Almacenar los artistas para pasarlos al tpl
  locals = {'contenido': rows, 'mensaje': mensaje}

  # respuesta
  return template('formas_pago/formas_pago', locals)


############# editar variable
@subapp.route('/edit', method='GET')
def formas_pago_edit():
  id = int(request.params.id)
  # acceso a db
  conn = engine.connect()
  stmt = text(("SELECT * FROM formas_pago WHERE id = {}").format(id))
  contenido = conn.execute(stmt).fetchone()
  conn.close()
  locals = {'contenido': contenido, 'id': id}
  # respuesta
  return template('formas_pago/formas_pago_edit', locals)


############# Borrar variable
@subapp.route('/delete', method='GET')
def formas_pago_delete():
  id = int(request.params.id)
  # acceso a db
  conn = engine.connect()
  stmt = text(("DELETE FROM formas_pago WHERE id = {}").format(id))
  conn.execute(stmt)
  conn.commit()
  conn.close()
  # respuesta
  return redirect("/formas_pago?mensaje=Se ha eliminado una Forma de pago")


############# Crear variable
@subapp.route('/new', method='GET')
def formas_pago_new():
  # acceso a db
  contenido = (0, "")
  locals = {'contenido': contenido, 'id': 0}
  # respuesta
  return template('formas_pago/formas_pago_new', locals)


############# Guardar variable
@subapp.route('/save', method='POST')
def formas_pago_save():
  nombre = request.forms.get('nombre')
  id = int(request.forms.get('id'))
  # acceso a db
  conn = engine.connect()
  mensaje = ""
  if id == 0:
    # crear
    stmt = text(
      ("INSERT INTO formas_pago (nombre) VALUES ('{}')").format(nombre))
    mensaje = "Forma de pago creado con éxito"
  else:
    stmt = text(("UPDATE formas_pago SET nombre = '{}' WHERE id = {}").format(
      nombre, id))
    mensaje = "Forma de pago editado con éxito"
  conn.execute(stmt)
  conn.commit()
  conn.close()
  return redirect("/formas_pago?mensaje=" + mensaje)



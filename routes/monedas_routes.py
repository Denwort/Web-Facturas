from bottle import Bottle, run, template, request, redirect
from sqlalchemy import text
from database import engine

subapp = Bottle()

############# variable
@subapp.route('/', method='GET')
def monedas():
  # mensaje
  mensaje = request.params.mensaje

  # nombre de la entidad
  conn = engine.connect()
  stmt = text(("SELECT * FROM monedas").format())
  rows = conn.execute(stmt)

  # Almacenar los artistas para pasarlos al tpl
  locals = {'contenido': rows, 'mensaje': mensaje}

  # respuesta
  return template('monedas/monedas', locals)


############# editar variable
@subapp.route('/edit', method='GET')
def monedas_edit():
  id = int(request.params.id)
  # acceso a db
  conn = engine.connect()
  stmt = text(("SELECT * FROM monedas WHERE id = {}").format(id))
  contenido = conn.execute(stmt).fetchone()
  conn.close()
  locals = {'contenido': contenido, 'id': id}
  # respuesta
  return template('monedas/monedas_edit', locals)


############# Borrar variable
@subapp.route('/delete', method='GET')
def monedas_delete():
  id = int(request.params.id)
  # acceso a db
  conn = engine.connect()
  stmt = text(("DELETE FROM monedas WHERE id = {}").format(id))
  conn.execute(stmt)
  conn.commit()
  conn.close()
  # respuesta
  return redirect("/monedas?mensaje=Se ha eliminado una Moneda")


############# Crear variable
@subapp.route('/new', method='GET')
def monedas_new():
  # acceso a db
  contenido = (0, "")
  locals = {'contenido': contenido, 'id': 0}
  # respuesta
  return template('monedas/monedas_new', locals)


############# Guardar variable
@subapp.route('/save', method='POST')
def monedas_save():
  nombre = request.forms.get('nombre')
  id = int(request.forms.get('id'))
  # acceso a db
  conn = engine.connect()
  mensaje = ""
  if id == 0:
    # crear
    stmt = text(("INSERT INTO monedas (nombre) VALUES ('{}')").format(nombre))
    mensaje = "Moneda creada con éxito"
  else:
    stmt = text(
      ("UPDATE monedas SET nombre = '{}' WHERE id = {}").format(nombre, id))
    mensaje = "Moneda editada con éxito"
  conn.execute(stmt)
  conn.commit()
  conn.close()
  return redirect("/monedas?mensaje=" + mensaje)
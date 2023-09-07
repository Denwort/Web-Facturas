from bottle import Bottle, run, template, request, redirect
from sqlalchemy import text
from database import engine

subapp = Bottle()

############# variable
@subapp.route('/', method='GET')
def categorias():
  # mensaje
  mensaje = request.params.mensaje

  conn = engine.connect()
  stmt = text(("SELECT * FROM categorias").format())
  rows = conn.execute(stmt)

  # Almacenar los artistas para pasarlos al tpl
  locals = {'contenido': rows, 'mensaje': mensaje}

  # respuesta
  return template('categorias/categorias', locals)


############# editar variable
@subapp.route('/edit', method='GET')
def categorias_edit():
  id = int(request.params.id)
  # acceso a db
  conn = engine.connect()
  stmt = text(("SELECT * FROM categorias WHERE id = {}").format(id))
  contenido = conn.execute(stmt).fetchone()
  conn.close()
  locals = {'contenido': contenido, 'id': id}
  # respuesta
  return template('categorias/categorias_edit', locals)


############# Borrar variable
@subapp.route('/delete', method='GET')
def categorias_delete():
  id = int(request.params.id)
  # acceso a db
  conn = engine.connect()
  stmt = text(("DELETE FROM categorias WHERE id = {}").format(id))
  conn.execute(stmt)
  conn.commit()
  conn.close()
  # respuesta
  return redirect("/categorias?mensaje=Se ha eliminado una categoria")


############# Crear variable
@subapp.route('/new', method='GET')
def categorias_new():
  # acceso a db
  contenido = (0, "")
  locals = {'contenido': contenido, 'id': 0}
  # respuesta
  return template('categorias/categorias_new', locals)


############# Guardar variable
@subapp.route('/save', method='POST')
def categorias_save():
  nombre = request.forms.get('nombre')
  id = int(request.forms.get('id'))
  # acceso a db
  conn = engine.connect()
  mensaje = ""
  if id == 0:
    # crear
    stmt = text(
      ("INSERT INTO categorias (nombre) VALUES ('{}')").format(nombre))
    mensaje = "Categoria creado con exito"
  else:
    stmt = text(
      ("UPDATE categorias SET nombre = '{}' WHERE id = {}").format(nombre, id))
    mensaje = "Categoria editado con exito"
  conn.execute(stmt)
  conn.commit()
  conn.close()
  return redirect("/categorias?mensaje=" + mensaje)
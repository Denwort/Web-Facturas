from bottle import Bottle, run, template, request, redirect
from sqlalchemy import text
from database import engine

subapp = Bottle()


########################################## INICIO DE - Lista de empleados


############# variable
@subapp.route('/', method='GET')
def empleados():
  # mensaje
  mensaje = request.params.mensaje

  # nombre de la entidad
  conn = engine.connect()
  stmt = text(("SELECT * FROM empleados").format())
  rows = conn.execute(stmt)

  # Almacenar los artistas para pasarlos al tpl
  locals = {'contenido': rows, 'mensaje': mensaje}

  # respuesta
  return template('empleados/empleados', locals)


############# editar variable
@subapp.route('/edit', method='GET')
def empleados_edit():
  id = int(request.params.id)
  # acceso a db
  conn = engine.connect()
  stmt = text(("SELECT * FROM empleados WHERE id = {}").format(id))
  contenido = conn.execute(stmt).fetchone()
  conn.close()
  locals = {'contenido': contenido, 'id': id}
  # respuesta
  return template('empleados/empleados_edit', locals)


############# Borrar variable
@subapp.route('/delete', method='GET')
def empleados_delete():
  id = int(request.params.id)
  # acceso a db
  conn = engine.connect()
  stmt = text(("DELETE FROM empleados WHERE id = {}").format(id))
  conn.execute(stmt)
  conn.commit()
  conn.close()
  # respuesta
  return redirect("/empleados?mensaje=Se ha eliminado un Empleado")


############# Crear variable
@subapp.route('/new', method='GET')
def empleados_new():
  # acceso a db
  contenido = (0, "")
  locals = {'contenido': contenido, 'id': 0}
  # respuesta
  return template('empleados/empleados_new', locals)


############# Guardar variable
@subapp.route('/save', method='POST')
def empleados_save():
  nombre = request.forms.get('nombre')
  id = int(request.forms.get('id'))
  # acceso a db
  conn = engine.connect()
  mensaje = ""
  if id == 0:
    # crear
    stmt = text(
      ("INSERT INTO empleados (nombre) VALUES ('{}')").format(nombre))
    mensaje = "Empleado creado con éxito"
  else:
    stmt = text(
      ("UPDATE empleados SET nombre = '{}' WHERE id = {}").format(nombre, id))
    mensaje = "Empleados editado con éxito"
  conn.execute(stmt)
  conn.commit()
  conn.close()
  return redirect("/empleados?mensaje=" + mensaje)


########################################## FIN DE - Lista de empleados

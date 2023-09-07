from bottle import Bottle, run, template, request, redirect
from sqlalchemy import text
from database import engine

subapp=Bottle()
########################################## INICIO DE - Lista de clientes


############# variables
@subapp.route('/', method='GET')
def clientes():
  # mensaje
  mensaje = request.params.mensaje
  # acceso a db
  conn = engine.connect()
  stmt = text(("SELECT * FROM clientes").format())
  rows = conn.execute(stmt)
  conn.close()
  locals = {'contenido': rows, 'mensaje': mensaje}
  # respuesta
  return template('clientes/clientes', locals)


############ editar variable
@subapp.route('/edit', method='GET')
def clientes_edit():
  id = int(request.params.id)
  # acceso a db
  conn = engine.connect()
  stmt = text(("SELECT * FROM clientes WHERE id = {}").format(id))
  contenido = conn.execute(stmt).fetchone()
  conn.close()
  locals = {'contenido': contenido, 'id': id}
  # respuesta
  return template('clientes/clientes_edit', locals)


############# Borrar variable
@subapp.route('s/delete', method='GET')
def clientes_delete():
  id = int(request.params.id)
  # acceso a db
  conn = engine.connect()
  stmt = text(("DELETE FROM clientes WHERE id = {}").format(id))
  conn.execute(stmt)
  conn.commit()
  conn.close()
  # respuesta
  return redirect("/clientes?mensaje=Se ha eliminado un cliente")


############# Crear variable
@subapp.route('/new', method='GET')
def clientes_new():
  # acceso a db
  contenido = (0, "", "", "")
  locals = {'contenido': contenido}
  # respuesta
  return template('clientes/clientes_new', locals)


############# Guardar variable
@subapp.route('/save', method='POST')
def clientes_save():
  direcc_cliente = request.forms.get('direcc_cliente')
  razon_social = request.forms.get('razon_social')
  ruc = request.forms.get('RUC')
  id = int(request.forms.get('id'))
  # acceso a db
  conn = engine.connect()
  mensaje = ""
  if id == 0:
    # crear
    stmt = text((
      "INSERT INTO clientes (RUC,razon_social,direcc_cliente) VALUES ('{}','{}','{}')"
    ).format(ruc, razon_social, direcc_cliente))
    mensaje = "Cliente creado con exito"
  else:
    stmt = text((
      "UPDATE clientes SET RUC = '{}', razon_social = '{}', direcc_cliente = '{}' WHERE id = {}"
    ).format(ruc, razon_social, direcc_cliente, id))
    mensaje = "Cliente editado con exito"
  conn.execute(stmt)
  conn.commit()
  conn.close()
  return redirect("/clientes?mensaje=" + mensaje)


########################################## FIN DE - Lista de clientes

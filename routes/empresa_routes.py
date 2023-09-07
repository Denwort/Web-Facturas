from bottle import Bottle, run, template, request, redirect
from sqlalchemy import text
from database import engine

subapp = Bottle()

########################################## INICIO DE - Lista de empresa propia


############# variables
@subapp.route('/', method='GET')
def empresa_propia():
  # mensaje
  mensaje = request.params.mensaje
  # acceso a db
  conn = engine.connect()
  stmt = text(("SELECT * FROM empresa_propia").format())
  rows = conn.execute(stmt)
  conn.close()
  locals = {'contenido': rows, 'mensaje': mensaje}
  # respuesta
  return template('empresa_propia/empresa_propia', locals)


############ editar variable
@subapp.route('/edit', method='GET')
def empresa_propia_edit():
  id = int(request.params.id)
  # acceso a db
  conn = engine.connect()
  stmt = text(("SELECT * FROM empresa_propia WHERE id = {}").format(id))
  contenido = conn.execute(stmt).fetchone()
  conn.close()
  locals = {'contenido': contenido, 'id': id}
  # respuesta
  return template('empresa_propia/empresa_propia_edit', locals)


############# Borrar variable
@subapp.route('/delete', method='GET')
def empresa_propia_delete():
  id = int(request.params.id)
  # acceso a db
  conn = engine.connect()
  stmt = text(("DELETE FROM empresa_propia WHERE id = {}").format(id))
  conn.execute(stmt)
  conn.commit()
  conn.close()
  # respuesta
  return redirect(
    "/empresa_propia?mensaje=Se han eliminado los datos de tu empresa con éxito"
  )


############# Crear variable
@subapp.route('/new', method='GET')
def empresa_propia_new():
  # acceso a db
  contenido = (0, "", "", "")
  locals = {'contenido': contenido}
  # respuesta
  return template('empresa_propia/empresa_propia_new', locals)


############# Guardar variable
@subapp.route('/save', method='POST')
def empresa_propia_save():
  direcc_empresa = request.forms.get('direcc_empresa')
  razon_social = request.forms.get('razon_social')
  ruc = request.forms.get('RUC')
  id = int(request.forms.get('id'))
  # acceso a db
  conn = engine.connect()
  mensaje = ""
  if id == 0:
    # crear
    stmt = text((
      "INSERT INTO empresa_propia (RUC,razon_social,direcc_empresa) VALUES ('{}','{}','{}')"
    ).format(ruc, razon_social, direcc_empresa))
    mensaje = "Empresa creada con éxito"
  else:
    stmt = text((
      "UPDATE empresa_propia SET RUC = '{}', razon_social = '{}', direcc_empresa = '{}' WHERE id = {}"
    ).format(ruc, razon_social, direcc_empresa, id))
    mensaje = "Empresa editada con éxito"
  conn.execute(stmt)
  conn.commit()
  conn.close()
  return redirect("/empresa_propia?mensaje=" + mensaje)


########################################## FIN DE - Lista de empresa propia

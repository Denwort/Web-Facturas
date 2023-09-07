from bottle import Bottle, run, template, request, redirect
from sqlalchemy import text
from database import engine

subapp = Bottle()


############# variable
@subapp.route('/', method='GET')
def proveedores():
  # mensaje
  mensaje = request.params.mensaje
  # acceso a db
  conn = engine.connect()
  stmt = text(("SELECT * FROM proveedores").format())
  rows = conn.execute(stmt)
  conn.close()
  locals = {'contenido': rows, 'mensaje': mensaje}
  # respuesta
  return template('proveedores/proveedores', locals)


############ editar variable
@subapp.route('/edit', method='GET')
def proveedores_edit():
  id = int(request.params.id)
  # acceso a db
  conn = engine.connect()
  stmt = text(("SELECT * FROM proveedores WHERE id = {}").format(id))
  contenido = conn.execute(stmt).fetchone()
  conn.close()
  locals = {'contenido': contenido, 'id': id}
  # respuesta
  return template('proveedores/proveedores_edit', locals)


############# Borrar variable
@subapp.route('/delete', method='GET')
def proveedores_delete():
  id = int(request.params.id)
  # acceso a db
  conn = engine.connect()
  stmt = text(("DELETE FROM proveedores WHERE id = {}").format(id))
  conn.execute(stmt)
  conn.commit()
  conn.close()
  # respuesta
  return redirect(
    "/proveedores?mensaje=Se han eliminado los datos del proveedor con éxito")


############# Crear variable
@subapp.route('/new', method='GET')
def proveedores_new():
  # acceso a db
  contenido = (0, "", "", "")
  locals = {'contenido': contenido}
  # respuesta
  return template('proveedores/proveedores_new', locals)


############# Guardar variable
@subapp.route('/proveedores/save', method='POST')
def proveedores_save():
  direcc_proveedor = request.forms.get('direcc_proveedor')
  razon_social = request.forms.get('razon_social')
  ruc = request.forms.get('RUC')
  id = int(request.forms.get('id'))
  # acceso a db
  conn = engine.connect()
  mensaje = ""
  if id == 0:
    # crear
    stmt = text((
      "INSERT INTO proveedores (RUC,razon_social, direcc_proveedor) VALUES ('{}','{}','{}')"
    ).format(ruc, razon_social, direcc_proveedor))
    mensaje = "Proveedor creado con éxito"
  else:
    stmt = text((
      "UPDATE proveedores SET RUC = '{}', razon_social = '{}', direcc_proveedor = '{}' WHERE id = {}"
    ).format(ruc, razon_social, direcc_proveedor, id))
    mensaje = "Proveedor editado con éxito"
  conn.execute(stmt)
  conn.commit()
  conn.close()
  return redirect("/proveedores?mensaje=" + mensaje)

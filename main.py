from bottle import Bottle, run, template, request, redirect
from sqlalchemy import text
from database import engine

## ENTIDADES FUERTES
from routes.categorias_routes import subapp as categorias_routes
from routes.clientes_routes import subapp as clientes_routes
from routes.empleados_routes import subapp as empleados_routes
from routes.empresa_routes import subapp as empresa_routes
from routes.monedas_routes import subapp as monedas_routes
from routes.formas_pago_routes import subapp as formas_pago_routes
from routes.proveedores_routes import subapp as proveedores_routes
from routes.tipos_producto_routes import subapp as tipos_producto_routes
from routes.unidades_medida_routes import subapp as unidades_medida_routes
## ENTIDADES DEBILES
from routes.productos_routes import subapp as productos_routes
from routes.facturas_routes import subapp as facturas_routes
from routes.transacciones_financieras_routes import subapp as transacciones_financieras_routes
## ENTIDADES ASOCIATIVAS
from routes.ventas_routes import subapp as ventas_routes
from routes.compras_routes import subapp as compras_routes
from routes.detalles_routes import subapp as detalles_routes

app = Bottle()

############################################### INICIO Menu de entidades

@app.route('/', method='GET')
def home():

  return template('home')

############################################### FIN Menu de entidades



########################################## INICIO DE - Contacto

@app.route('/contacto', method='GET')
def contacto():
  return template('contacto')

########################################## FIN DE - Contacto

if __name__ == '__main__':
  ## ENTIDADES FUERTES
  app.mount('/categorias', categorias_routes)
  app.mount('/clientes', clientes_routes)
  app.mount('/empleados', empleados_routes)
  app.mount('/empresa_propia', empresa_routes)
  app.mount('/monedas', monedas_routes)
  app.mount('/formas_pago', formas_pago_routes)
  app.mount('/proveedores', proveedores_routes)
  app.mount('/tipos_producto', tipos_producto_routes)
  app.mount('/unidades_medida', unidades_medida_routes)
  ## ENNTIDADES DEBILES
  app.mount('/productos', productos_routes)
  app.mount('/facturas', facturas_routes)
  app.mount('/transacciones_financieras', transacciones_financieras_routes)
  ## ENTIDADES ASOCIATIVAS
  app.mount('/ventas', ventas_routes)
  app.mount('/compras', compras_routes)
  app.mount('/detalles', detalles_routes)
  
  run(app, host='0.0.0.0', port=8080, debug=True, reloader=True)

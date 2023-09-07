#import os
from sqlalchemy import create_engine
#from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

# Cambiar al nombre de la basedatos.db
engine = create_engine('sqlite:///db/app.db')
session_db = sessionmaker()
session_db.configure(bind=engine)

#agregar "sqlalchemy" al requirements.txt y ejecutar en el shell "pip install -r requirements.txt"
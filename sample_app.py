import os
import pymysql
from flask import Flask

sample = Flask(__name__)

@sample.route("/")
def home():
    try:
        conn = pymysql.connect(
            host=os.getenv("MYSQL_HOST", "servidor-bd"),
            user="root",
            password=os.getenv("MYSQL_ROOT_PASSWORD"),
            database=os.getenv("MYSQL_DATABASE")
        )
        conn.close()
        db_status = "Conexión exitosa a la base de datos (CI/CD Activo)"
    except Exception as e:
        db_status = f"Error al conectar a la base de datos: {e}"

    return f"<h1>Bienvenido a mi aplicación Flask - Actualizado</h1><p>{db_status}</p>"

if __name__ == "__main__":
    modo_debug = os.getenv("FLASK_DEBUG", "False").lower() == "true"
    sample.run(host="0.0.0.0", port=5050, debug=modo_debug)  # nosec B104
#!/bin/bash

# Crear directorios temporales
mkdir tempdir
mkdir tempdir/templates
mkdir tempdir/static

# Copiar archivos
cp sample_app.py tempdir/.
cp -r templates/* tempdir/templates/.
cp -r static/* tempdir/static/.

# Crear Dockerfile
echo "FROM python" > tempdir/Dockerfile
echo "RUN pip install flask" >> tempdir/Dockerfile
echo "COPY ./static /home/myapp/static/" >> tempdir/Dockerfile
echo "COPY ./templates /home/myapp/templates/" >> tempdir/Dockerfile
echo "COPY sample_app.py /home/myapp/" >> tempdir/Dockerfile
echo "EXPOSE 5050" >> tempdir/Dockerfile
echo 'CMD ["python3","/home/myapp/sample_app.py"]' >> tempdir/Dockerfile

# Entrar al directorio temporal
cd tempdir

# Construir la imagen
docker build -t sampleapp .

# Ejecutar el contenedor
docker run -t -d -p 5050:5050 --name samplerunning sampleapp

# Mostrar los contenedores
docker ps -a

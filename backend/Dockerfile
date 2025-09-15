# Usar una imagen base de Python
FROM python:3.13.1-slim

# Establecer el directorio de trabajo dentro del contenedor
WORKDIR /app

# Instalar wget y dependencias
RUN apt-get update && apt-get install -y wget && rm -rf /var/lib/apt/lists/*

# Instalar netcat para realizar el cargado de 
RUN apt-get update && apt-get install -y netcat-openbsd && rm -rf /var/lib/apt/lists/*

# Descargar e instalar Miniconda para los entornos
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-py39_24.9.2-0-Linux-x86_64.sh -O miniconda.sh \
    && bash miniconda.sh -b -p /opt/conda \
    && rm miniconda.sh

# Agregar Miniconda al PATH
ENV PATH="/opt/conda/bin:$PATH"

# Desactivar el buffering en los flujos de entrada y salida estándar (stdin, stdout, stderr) podría ser útil para ver inmediatamente los resultados de lo que se está ejecutando. (LOGS)
ENV PYTHONUNBUFFERED=1

# Cambiar la shell a bash (para que conda funcione correctamente)
SHELL ["/bin/bash", "-c"]

# Archivo de dependencias de pip
# A partir de aquí, se instalan las dependencias de conda manualmente. No se puede realizar a partir del archivo de requerimientos porque da error, al estar mezclados las dependencias de conda y los de pip. Por eso, se instalan manualmente las de conda y, una vez acabado, se instalan las de pip.
# Si se añadieran más dependencias de conda, habría que añadirlas aquí para su instalación manual con el Dockerfile.
COPY backend/requirements-pypi.txt /app/

RUN conda init bash && \
    conda create -n grafana-loki -y && \
    source activate grafana-loki

# Instala las dependencias de conda y pip:
## djangorestframework
# Instala el resto de requirements-pypi
RUN conda init bash && \
    source activate grafana-loki && \
    pip install djangorestframework && \
    pip install -r /app/requirements-pypi.txt

# Instalar gunicorn
RUN conda init bash && \
    source activate grafana-loki && \
    pip install gunicorn && \
    echo "PATH: $PATH" && \
    which gunicorn

# Copiar el resto de los archivos del proyecto
COPY backend /app/

# Archivos estáticos (para los estilos)
RUN conda init bash && \
    source activate grafana-loki && \
    python manage.py collectstatic --noinput

# Exponer el puerto donde Gunicorn servirá la app
EXPOSE 8000

# Copiar el archivo de inicio y dar permisos de ejecución
COPY backend/start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Establecer el entorno activado al iniciar el contenedor
CMD ["/app/start.sh"]
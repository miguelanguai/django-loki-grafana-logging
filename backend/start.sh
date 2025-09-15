#!/bin/bash

# Activar el entorno de Conda
source /opt/conda/bin/activate grafana-loki

# Iniciar Gunicorn para servir Django
echo "Iniciando el servidor..."
exec gunicorn mysite.wsgi:application --bind 0.0.0.0:8000 --access-logfile - --error-logfile -
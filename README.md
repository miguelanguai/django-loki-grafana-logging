# Grafana with Loki and Django

## Initial settings

You need to create an

## Ajustes iniciales

Loguear por primera vez con admin como usuario y contraseña. Después pide cambiar la contraseña, y le ponemos la que queramos

## Configure Loki Service as a data source

Explore
Open advanced data source picker
Configure a new data source
Loki
http://loki:3100
Save & Test -_> debe dar exito

## Create a Dashboard with visualization

Dashboard
Create dashboard
Add visualization
Loki
En label filters -> service_name = backend
run queries
Save Dashboard

## Filtering queries

Ahora se pueden filtrar los logs desde el query. En line filters, line contains. Por ejemplo, se puede hacer un filtro de los logs de ERROR solo
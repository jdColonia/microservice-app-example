#!/bin/sh

# Procesar la plantilla con las variables de entorno
envsubst < /etc/prometheus/prometheus.template.yml > /etc/prometheus/prometheus.yml

# Ejecutar Prometheus
exec /bin/prometheus "$@"

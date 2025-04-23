#!/bin/bash

# Nombre del ACR (sin https://)
ACR_NAME="msappacrestebangzam.azurecr.io"

# Lista de microservicios
SERVICES=("auth-api" "frontend" "log-message-processor" "todos-api" "users-api")

echo "Iniciando login en el ACR..."
az acr login --name ${ACR_NAME%%.*} || { echo "Fallo el login en el ACR"; exit 1; }

for SERVICE in "${SERVICES[@]}"; do
    echo "Procesando $SERVICE..."

    IMAGE_NAME="$ACR_NAME/$SERVICE:latest"

    echo "Construyendo imagen para $SERVICE..."
    docker build -t "$IMAGE_NAME" "$SERVICE" || { echo "Error al construir $SERVICE"; continue; }

    echo "Subiendo imagen $IMAGE_NAME al ACR..."
    docker push "$IMAGE_NAME" || { echo "Error al subir $IMAGE_NAME"; continue; }

    echo "✅ $SERVICE completado."
    echo "-------------------------------------------"
done

echo "🎉 Todas las imágenes fueron procesadas."

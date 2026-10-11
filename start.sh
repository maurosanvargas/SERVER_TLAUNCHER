#!/bin/bash
# Script de inicio rápido del servidor de Minecraft
echo "Iniciando servidor de Minecraft (PaperMC 1.21.1)..."

# Descargar imagen y levantar en segundo plano
sudo docker compose pull
sudo docker compose up -d

echo ""
echo "✅ Servidor levantado en segundo plano."
echo "Mostrando logs en vivo (Presiona Ctrl+C para salir de los logs sin apagar el servidor):"
echo ""
sudo docker compose logs -f

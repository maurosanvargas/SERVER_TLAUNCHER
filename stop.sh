#!/bin/bash
# Script de apagado seguro del servidor de Minecraft
echo "Guardando mundo y deteniendo contenedor..."
sudo docker compose down
echo "✅ Servidor detenido correctamente."

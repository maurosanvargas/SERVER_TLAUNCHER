# Servidor de Minecraft en Google Cloud (PaperMC 1.21.x + TLauncher)

Servidor de Minecraft optimizado con PaperMC y Docker Compose, configurado para permitir jugadores de **TLauncher (No-Premium)** y **Cuentas Premium**.

---

## 🛠️ Requisitos de la VM en Google Cloud (Compute Engine)

- **Serie:** `E2`
- **Tipo de máquina:** `e2-medium` (2 vCPUs, 4 GB de RAM)
- **Disco:** 25 GB a 30 GB (Disco persistente equilibrado o estándar)
- **Sistema Operativo:** Debian 12 (Bookworm) o Ubuntu 24.04 LTS

---

## 🔒 Regla de Firewall obligatoria en Google Cloud

Para que tú y tus amigos puedan conectarse desde el juego:

1. Ve a **Google Cloud Console > Red de VPC > Cortafuegos (Firewall)**.
2. Haz clic en **Crear regla de firewall**:
   - **Nombre:** `allow-minecraft-25565`
   - **Dirección del tráfico:** Entrada (*Ingress*)
   - **Acción:** Permitir
   - **Destinos:** Todas las instancias de la red
   - **Rango de IPv4 de origen:** `0.0.0.0/0`
   - **Protocolos y puertos:** Marca **TCP** y escribe `25565`.
3. Haz clic en **Crear**.

---

## 🚀 Despliegue en la Máquina Virtual

Conéctate por SSH a tu nueva VM y ejecuta:

```bash
# 1. Instalar Docker y Git si aún no están instalados
sudo apt update && sudo apt install -y docker.io git docker-compose-plugin
sudo systemctl enable --now docker

# 2. Clonar este repositorio
git clone https://github.com/maurosanvargas/Server-Minecraft.git
cd Server-Minecraft

# 3. Dar permisos de ejecución a los scripts
chmod +x start.sh stop.sh

# 4. Iniciar el servidor
./start.sh
```

---

## 🎮 Cómo conectarse desde Minecraft / TLauncher

1. Busca la **IP externa** de tu VM en la consola de Google Cloud (por ejemplo, `34.123.45.67`).
2. Abre Minecraft en la versión **1.21.1** (o la versión que definiste en `docker-compose.yml`).
3. Ve a **Multijugador > Agregar Servidor**:
   - **Dirección del servidor:** `TU_IP_EXTERNA` (o `TU_IP_EXTERNA:25565`).
4. ¡Entra a jugar!

---

## ⚙️ Comandos de administración útiles

### Dar permisos de Operador (OP):
```bash
sudo docker compose exec minecraft rcon-cli op TuNombreDeUsuario
```

### Ver los logs de la consola en vivo:
```bash
sudo docker compose logs -f
```

### Detener el servidor:
```bash
./stop.sh
```

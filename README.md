# Servidor de Minecraft en Google Cloud (PaperMC 1.21.x + TLauncher)

Servidor de Minecraft optimizado con PaperMC y Docker Compose, configurado para permitir jugadores de **TLauncher (No-Premium)** y **Cuentas Premium**.

---

## 🛠️ Requisitos de la VM en Google Cloud (Compute Engine)

- **Serie:** `E2`
- **Tipo de máquina:** `e2-standard-4` (4 vCPUs, 16 GB de RAM)
- **Disco:** 25 GB a 50 GB (Disco persistente equilibrado)
- **Sistema Operativo:** Debian 12 (Bookworm) o Ubuntu 24.04 LTS

---

## 🔒 Regla de Firewall obligatoria en Google Cloud

Para que tú y tus amigos puedan conectarse desde el juego:

1. Ve a **Google Cloud Console > Red de VPC > Cortafuegos (Firewall)**.
2. Haz clic en **Crear regla de firewall**:
   - **Nombre:** `allow-minecraft-28475`
   - **Dirección del tráfico:** Entrada (*Ingress*)
   - **Acción:** Permitir
   - **Destinos:** Todas las instancias de la red
   - **Rango de IPv4 de origen:** `0.0.0.0/0`
   - **Protocolos y puertos:** Marca **TCP** y escribe `28475`.
3. Haz clic en **Crear**.

---

## 🚀 Despliegue en la Máquina Virtual

Conéctate por SSH a tu nueva VM y ejecuta:

```bash
# 1. Instalar Docker y Git si aún no están instalados
sudo apt update && sudo apt install -y docker.io git docker-compose-plugin
sudo systemctl enable --now docker

# 2. Clonar este repositorio
git clone https://github.com/maurosanvargas/SERVER_TLAUNCHER.git
cd SERVER_TLAUNCHER

# 3. Dar permisos de ejecución a los scripts
chmod +x start.sh stop.sh

# 4. Iniciar el servidor
./start.sh
```

---

## 🔄 Protocolo de Sincronización y Flujo Git (Regla de Oro para el Asistente de IA)

> [!IMPORTANT]
> **RECORDATORIO PARA EL ASISTENTE / OTROS CHATS:**
> Cada vez que se realicen modificaciones en archivos locales (como `docker-compose.yml`, configuraciones o scripts), **SIEMPRE responder primero con el flujo de Git** antes de pedir ejecutar comandos dentro del juego o por RCON:
> 
> **Paso 1: En la máquina local (Terminal local):**
> ```bash
> git add .
> git commit -m "Descripción de los cambios"
> git push
> ```
> 
> **Paso 2: En la VM de Google Cloud (SSH):**
> ```bash
> git pull
> ./stop.sh && ./start.sh
> ```
> 
> **Paso 3:** Una vez reiniciado el contenedor, recién ahí entregar comandos in-game o RCON.

---

## 🎮 Cómo conectarse desde Minecraft / TLauncher

1. Busca la **IP externa** de tu VM en la consola de Google Cloud (por ejemplo, `34.123.45.67`).
2. Abre Minecraft en la versión **1.21.1** (o la versión que definiste en `docker-compose.yml`).
3. Ve a **Multijugador > Agregar Servidor**:
   - **Dirección del servidor:** `TU_IP_EXTERNA:28475`.
4. ¡Entra a jugar!

---

## ⚙️ Comandos de administración útiles

### Dar permisos de Operador (OP):
```bash
sudo docker compose exec minecraft rcon-cli op TuNombreDeUsuario
```

### Configurar permisos de jugadores en LuckPerms (/home, /sethome, /tpa, /spawn):
```bash
sudo docker compose exec minecraft rcon-cli lp group default permission set essentials.sethome true
sudo docker compose exec minecraft rcon-cli lp group default permission set essentials.sethome.multiple.default true
sudo docker compose exec minecraft rcon-cli lp group default permission set essentials.home true
sudo docker compose exec minecraft rcon-cli lp group default permission set essentials.tpa true
sudo docker compose exec minecraft rcon-cli lp group default permission set essentials.tpaccept true
sudo docker compose exec minecraft rcon-cli lp group default permission set essentials.tpdeny true
sudo docker compose exec minecraft rcon-cli lp group default permission set essentials.spawn true
```

### Agregar jugadores a la lista blanca (Whitelist):
```bash
sudo docker compose exec minecraft rcon-cli whitelist add NombreDelJugador
```

### Ver los logs de la consola en vivo:
```bash
sudo docker compose logs -f
```

### Detener el servidor de forma segura:
```bash
./stop.sh
```

# Minecraft VM para Proxmox - 100% Mexicano 🇲🇽

Este repositorio contiene una plantilla completa para desplegar un servidor Minecraft optimizado en una máquina virtual (VM) con Ubuntu 24.04 dentro de Proxmox.

---

## ¿Qué incluye?

- Scripts para instalar Java 21, PaperMC y configurar el servidor Minecraft.
- Configuración de firewall (ufw) para abrir puertos necesarios.
- Servicio systemd para manejar el servidor.
- Scripts para backups automáticos y monitoreo básico.
- Soporte para jugadores premium y sin premium con plugins recomendados.
- Configuración flexible mediante archivo `config.env`.
- Documentación completa en español.

---

## Requisitos previos

- Tener Proxmox VE instalado y configurado.
- Crear una VM con Ubuntu Server 24.04.
- Asignar al menos 4 GB RAM para el servidor Minecraft (ajustable).
- Acceso SSH a la VM.

---

## Instalación y configuración

1. Clona este repositorio o transfiere los archivos a la VM:

   ```bash
   git clone https://github.com/Zharm29/minecraft-vm-proxmox.git
   cd minecraft-vm-proxmox
   ```

2. Revisa y ajusta las variables en `config.env` según tus necesidades (RAM, versión, usuario, puerto).

3. Da permisos y ejecuta el script de instalación:

   ```bash
   chmod +x setup.sh
   ./setup.sh
   ```

4. El servidor se instalará, configurará el firewall y creará el servicio systemd.

5. El servidor Minecraft arrancará automáticamente. Puedes controlar el servicio con:

   ```bash
   sudo systemctl start minecraft
   sudo systemctl stop minecraft
   sudo systemctl status minecraft
   ```

---

## Firewall y puertos

El firewall `ufw` se configurará para abrir el puerto 25565 TCP (puerto estándar Minecraft).  
Si quieres abrir más puertos o restringir IPs, edita el script `setup.sh` o usa:

```bash
sudo ufw allow 25565/tcp
sudo ufw enable
```

---

## Soporte para jugadores sin premium

Para permitir que jugadores sin cuenta premium jueguen, recomendamos usar el plugin **Floodgate** (de GeyserMC) o **BungeeCord**.

Documentación y descarga:

- [Floodgate](https://geysermc.org/floodgate/)
- [BungeeCord](https://www.spigotmc.org/wiki/bungeecord/)

Instala estos plugins en la carpeta `plugins` dentro de `/opt/minecraft`.

---

## Backups automáticos

El script `backup.sh` hará copias diarias en `/opt/minecraft/backups`. Puedes modificarlo o crear un cronjob:

```bash
crontab -e
# Añade la siguiente línea para backup diario a las 2am
0 2 * * * /opt/minecraft/backup.sh
```

---

## Monitoreo básico

El script `monitor.sh` reporta uso de CPU, RAM y disco, ideal para integrarlo con alertas personalizadas.

---

## ¡Este proyecto es 100% mexicano! 🇲🇽

Orgullosamente creado para la comunidad Minecraft de México, con amor y dedicación.

---

## Contacto

Para dudas o sugerencias, abre un issue en el repositorio o contáctame en GitHub: [Zharm29](https://github.com/Zharm29)

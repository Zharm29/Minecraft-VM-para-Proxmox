#!/bin/bash

source ./config.env

# Crear usuario si no existe
if ! id -u $MC_USER > /dev/null 2>&1; then
  sudo adduser --system --group $MC_USER
fi

# Actualizar sistema e instalar Java 21, curl, wget, unzip
sudo apt update && sudo apt upgrade -y
sudo apt install -y openjdk-21-jre-headless curl wget unzip ufw

# Crear carpeta base y cambiar dueño
sudo mkdir -p $MC_PATH
sudo chown $MC_USER:$MC_USER $MC_PATH

# Descargar PaperMC
cd $MC_PATH
sudo -u $MC_USER wget -O paperclip.jar "https://api.papermc.io/v2/projects/paper/versions/$PAPER_VERSION/builds/$PAPER_BUILD/downloads/paper-$PAPER_VERSION-$PAPER_BUILD.jar"

# Aceptar EULA
echo "eula=true" | sudo tee $MC_PATH/eula.txt

# Crear script de inicio
cat <<EOL | sudo tee $MC_PATH/start.sh
#!/bin/bash
java -Xms$MIN_RAM -Xmx$MAX_RAM -XX:+UseG1GC -XX:+ParallelRefProcEnabled \
     -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions \
     -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 \
     -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M \
     -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 \
     -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 \
     -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 \
     -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 \
     -Dusing.aikars.flags=https://mcflags.emc.gs -jar paperclip.jar nogui
EOL

sudo chmod +x $MC_PATH/start.sh
sudo chown $MC_USER:$MC_USER $MC_PATH/start.sh

# Crear servicio systemd
cat <<EOL | sudo tee /etc/systemd/system/minecraft.service
[Unit]
Description=Minecraft Server
After=network.target

[Service]
User=$MC_USER
WorkingDirectory=$MC_PATH
ExecStart=$MC_PATH/start.sh
Restart=on-failure
SuccessExitStatus=0 1

[Install]
WantedBy=multi-user.target
EOL

# Configurar firewall
sudo ufw allow $MC_PORT/tcp
sudo ufw --force enable

# Recargar y habilitar servicio
sudo systemctl daemon-reload
sudo systemctl enable minecraft
sudo systemctl start minecraft

echo "¡Servidor Minecraft instalado y corriendo! Usa 'sudo systemctl status minecraft' para verificar."

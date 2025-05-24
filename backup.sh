#!/bin/bash
source ./config.env

BACKUP_DIR="$MC_PATH/backups"
mkdir -p $BACKUP_DIR

TIMESTAMP=$(date +%Y%m%d-%H%M%S)
BACKUP_FILE="$BACKUP_DIR/minecraft-backup-$TIMESTAMP.tar.gz"

tar -czf $BACKUP_FILE $MC_PATH/world $MC_PATH/world_nether $MC_PATH/world_the_end $MC_PATH/server.properties $MC_PATH/whitelist.json $MC_PATH/ops.json

echo "Backup creado en $BACKUP_FILE"

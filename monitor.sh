#!/bin/bash

echo "=== Estado del servidor Minecraft ==="
echo "CPU:"
top -b -n1 | head -n 10

echo ""
echo "Memoria:"
free -h

echo ""
echo "Espacio en disco:"
df -h $MC_PATH

echo "==============================="

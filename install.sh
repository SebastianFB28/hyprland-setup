#!/usr/bin/env bash
# install.sh
# Punto de entrada único del setup. Orquesta los scripts de scripts/
# en el orden correcto: primero instala, después coloca los archivos.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "============================================="
echo "  Hyprland Setup"
echo "============================================="
echo ""

# -----------------------------------------------------
# 1) Instalar paquetes y dependencias
# -----------------------------------------------------
echo "==> Paso 1/2: Instalando paquetes..."
bash "$SCRIPT_DIR/scripts-config/install_packages.sh"

# -----------------------------------------------------
# 2) Colocar los archivos de configuración
# -----------------------------------------------------
# echo ""
# echo "==> Paso 2/2: Enlazando archivos de configuración..."
# bash "$SCRIPT_DIR/scripts-config/link_configs.sh"

echo ""
echo "============================================="
echo "  ✅ Instalación de paquetes completa."
echo "  (Paso 2 - enlazar configs - pendiente de implementar)"
echo "============================================="


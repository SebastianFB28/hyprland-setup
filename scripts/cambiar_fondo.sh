#!/bin/bash

# Ruta de tus fondos Catppuccin
WALLPAPER_DIR="/home/sebastianfb/Wallpaper/walls-catppuccin-mocha"

# Selecciona una imagen al azar
RANDOM_WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" \) | shuf -n 1)

# Color base Rosewater en formato hexadecimal sin el '#'
COLOR_TRANS="f5e0dc"

# 1. Expandir un círculo de color sólido desde el centro a 144 FPS
awww clear "$COLOR_TRANS" \
    --transition-type center \
    --transition-step 90 \
    --transition-fps 144

# Esperar medio segundo para que la animación del color cubra la pantalla
sleep 0.5

# 2. Expandir el nuevo fondo desde el centro tapando el color
awww img "$RANDOM_WALLPAPER" \
    --transition-type center \
    --transition-step 90 \
    --transition-fps 144

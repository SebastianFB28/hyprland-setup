#!/bin/bash

# Método 1: Revisar si el puerto AC reporta conectado (el método viejo)
AC_STATUS=$(cat /sys/class/power_supply/AC*/online 2>/dev/null)

# Método 2: Revisar el estado de la batería (si dice "Full" o "Not charging" pero el voltaje es alto, está conectada)
BAT_STATUS=$(cat /sys/class/power_supply/BAT*/status 2>/dev/null)

# SI el AC dice 1, O si la batería está llena/estacionaria (no descargándose "Discharging")
if [ "$AC_STATUS" = "1" ] || [ "$BAT_STATUS" = "Full" ] || [ "$BAT_STATUS" = "Not charging" ]; then
    # Conectado a la corriente (incluso limitado al 80%)
    exec prime-run "$@"
else
    # Descargándose (Batería real)
    exec "$@"
fi

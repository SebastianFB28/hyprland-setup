#!/bin/bash
if hyprctl monitors | grep -q "eDP-1"; then
    hyprctl eval 'hl.monitor({ output = "eDP-1", disabled = true })'
else
    hyprctl eval 'hl.monitor({ output = "eDP-1", mode = "1920x1080@144", position = "0x0", scale = 1, disabled = false })'
fi

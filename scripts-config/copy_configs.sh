#!/usr/bin/env bash
# scripts-config/copy_configs.sh
# Copia los archivos de configuración de cada app desde el repo hacia su
# ruta correspondiente en ~/.config/ (o donde corresponda). Usa COPIAS
# reales (no symlinks): si borras el repo clonado después, la
# configuración instalada sigue funcionando intacta.
set -euo pipefail

# Necesario para que "$dir"/* también detecte archivos ocultos como
# .zshrc o .zsh_aliases — por defecto bash los ignora en el glob.
shopt -s dotglob

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"

# -----------------------------------------------------
# Apps a copiar: "carpeta_en_el_repo:ruta_destino[:exec]"
# El tercer campo "exec" es opcional: si está presente, los archivos
# copiados quedan con permiso de ejecución (chmod +x). Úsalo para
# scripts personales, no para archivos de configuración normales.
# -----------------------------------------------------
APPS=(
    "hyprland:$HOME/.config/hypr"
    "wofi:$HOME/.config/wofi"
    "waybar:$HOME/.config/waybar"
    "kitty:$HOME/.config/kitty"
    "starship:$HOME/.config"
    "zsh:$HOME"
    "waypaper:$HOME/.config/waypaper"
    "walls-catppuccin-mocha:$HOME/Wallpaper/walls-catppuccin-mocha"
    "scripts:$HOME/.local/bin:exec"
)

# -----------------------------------------------------
# Copia el contenido de una carpeta origen hacia un destino,
# respaldando cualquier archivo existente que sea distinto.
# -----------------------------------------------------
copy_app_config() {
    local source_dir="$1"
    local target_dir="$2"
    local mode="${3:-}"
    local app_name
    app_name="$(basename "$source_dir")"
    # Todos los respaldos van centralizados aquí, nunca "al lado" del
    # destino — si el destino es $HOME (como zsh), "${target_dir}-backup"
    # quedaría en /home/, fuera del control del usuario.
    local backup_dir="$HOME/.hyprland-setup-backups/${app_name}-$(date +%Y%m%d-%H%M%S)"
    local backed_up=false

    echo "==> $app_name"
    echo "    Origen:  $source_dir"
    echo "    Destino: $target_dir"

    if [ ! -d "$source_dir" ]; then
        echo "  ⚠ No existe la carpeta '$source_dir' en el repo, se omite."
        echo ""
        return
    fi

    mkdir -p "$target_dir"

    for file in "$source_dir"/*; do
        # Saltar subcarpetas por ahora, solo copiamos archivos directos
        [ -f "$file" ] || continue

        local filename target
        filename="$(basename "$file")"
        target="$target_dir/$filename"

        if [ -e "$target" ]; then
            if cmp -s "$file" "$target"; then
                echo "  ✓ $filename (ya está al día)"
                [ "$mode" = "exec" ] && chmod +x "$target"
                continue
            fi

            mkdir -p "$backup_dir"
            mv "$target" "$backup_dir/$filename"
            backed_up=true
            echo "  ⚠ $filename existía con contenido distinto — respaldado en $backup_dir"
        fi

        cp "$file" "$target"

        if [ "$mode" = "exec" ]; then
            chmod +x "$target"
            echo "  ✓ $filename copiado (ejecutable)"
        else
            echo "  ✓ $filename copiado"
        fi
    done

    if [ "$backed_up" = true ]; then
        echo "  ℹ️  Respaldo en: $backup_dir"
    fi
    echo ""
}

echo "==> Copiando archivos de configuración..."
echo ""

for entry in "${APPS[@]}"; do
    IFS=':' read -r app_folder target_dir mode <<< "$entry"
    copy_app_config "$REPO_ROOT/$app_folder" "$target_dir" "$mode"
done

echo "✅ Configuración copiada correctamente."
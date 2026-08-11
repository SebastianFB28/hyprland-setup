#!/usr/bin/env bash
# scripts/install_packages.sh
# Instala los paquetes necesarios para el setup de Hyprland + Waybar.
set -euo pipefail

# -----------------------------------------------------
# Paquetes de repos oficiales (pacman)
# -----------------------------------------------------
PACKAGES=(
    # Core Hyprland / capturas
    waybar
    grim
    slurp
    wl-clipboard
    # Apps y lanzador
    wofi
    kitty
    nautilus
    # Dependencias de los módulos de Waybar
    playerctl      # custom/music
    blueman        # bluetooth (blueman-manager)
    pavucontrol    # pulseaudio (click)
    swaync         # custom/notification (swaync-client)
    wlogout        # custom/power (menú de apagado)
    libnotify      # notify-send (click derecho del reloj)
    zsh            # shell (requerido por Oh My Zsh)
)

# -----------------------------------------------------
# Paquetes de AUR (necesitan yay o paru)
# -----------------------------------------------------
AUR_PACKAGES=(
    waypaper
)

TOTAL=$(( ${#PACKAGES[@]} + ${#AUR_PACKAGES[@]} ))
CURRENT=0

# -----------------------------------------------------
# Sincronizar sistema ANTES de instalar nada
# -----------------------------------------------------
# Instalar paquetes puntuales sin sincronizar primero puede causar un
# "partial upgrade" (versiones desincronizadas entre sí), que es una de
# las causas más comunes de que Arch se rompa. Por eso actualizamos
# todo el sistema primero, y luego instalamos lo específico.
echo "==> Sincronizando y actualizando el sistema..."
if ! sudo pacman -Syu --noconfirm > /tmp/system_update.log 2>&1; then
    echo "‼️  Error actualizando el sistema. Revisa /tmp/system_update.log"
    exit 1
fi
echo "✅ Sistema actualizado."
echo ""

# -----------------------------------------------------
# Función: dibuja una barra de progreso en la terminal
# -----------------------------------------------------
draw_progress() {
    local current=$1
    local total=$2
    local label=$3
    local width=40
    local percent=$(( current * 100 / total ))
    local filled=$(( width * current / total ))
    local empty=$(( width - filled ))

    printf "\r["
    printf "%0.s#" $(seq 1 "$filled") 2>/dev/null || true
    printf "%0.s-" $(seq 1 "$empty") 2>/dev/null || true
    printf "] %3d%% - %s" "$percent" "$label"
}

is_installed_pacman() {
    pacman -Qi "$1" &>/dev/null
}

is_installed_aur() {
    "$AUR_HELPER" -Qi "$1" &>/dev/null
}

# -----------------------------------------------------
# Instalar yay si no hay ningún AUR helper presente
# -----------------------------------------------------
install_yay() {
    echo "==> No se encontró 'yay' ni 'paru'. Instalando yay..."

    # Prerequisitos para compilar desde AUR
    sudo pacman -S --noconfirm --needed base-devel git > /tmp/install_yay_deps.log 2>&1 || {
        echo "‼️  Error instalando dependencias de compilación. Revisa /tmp/install_yay_deps.log"
        exit 1
    }

    local build_dir
    build_dir="$(mktemp -d)"

    if ! git clone https://aur.archlinux.org/yay.git "$build_dir" > /tmp/install_yay.log 2>&1; then
        echo "‼️  Error clonando yay desde AUR. Revisa /tmp/install_yay.log"
        exit 1
    fi

    if ! (cd "$build_dir" && makepkg -si --noconfirm) >> /tmp/install_yay.log 2>&1; then
        echo "‼️  Error compilando/instalando yay. Revisa /tmp/install_yay.log"
        exit 1
    fi

    rm -rf "$build_dir"
    echo "✅ yay instalado correctamente."
}

# -----------------------------------------------------
# Detectar helper de AUR disponible (yay o paru)
# -----------------------------------------------------
AUR_HELPER=""
if command -v yay &>/dev/null; then
    AUR_HELPER="yay"
elif command -v paru &>/dev/null; then
    AUR_HELPER="paru"
elif [ ${#AUR_PACKAGES[@]} -gt 0 ]; then
    # Solo instalamos yay si de verdad hay paquetes de AUR que instalar
    install_yay
    AUR_HELPER="yay"
fi

echo "==> Instalando ${TOTAL} paquetes..."
echo ""

# --- Paquetes oficiales ---
for pkg in "${PACKAGES[@]}"; do
    CURRENT=$((CURRENT + 1))

    if is_installed_pacman "$pkg"; then
        draw_progress "$CURRENT" "$TOTAL" "$pkg (ya instalado)"
    else
        draw_progress "$CURRENT" "$TOTAL" "$pkg"
        if ! sudo pacman -S --noconfirm --needed "$pkg" > /tmp/install_"$pkg".log 2>&1; then
            echo ""
            echo "‼️  Error instalando '$pkg'. Revisa /tmp/install_${pkg}.log"
            exit 1
        fi
    fi
done

# --- Paquetes de AUR ---
for pkg in "${AUR_PACKAGES[@]}"; do
    CURRENT=$((CURRENT + 1))

    if is_installed_aur "$pkg"; then
        draw_progress "$CURRENT" "$TOTAL" "$pkg (ya instalado)"
    else
        draw_progress "$CURRENT" "$TOTAL" "$pkg (AUR)"
        if ! "$AUR_HELPER" -S --noconfirm --needed "$pkg" > /tmp/install_"$pkg".log 2>&1; then
            echo ""
            echo "‼️  Error instalando '$pkg' desde AUR. Revisa /tmp/install_${pkg}.log"
            exit 1
        fi
    fi
done

printf "\n\n✅ Todos los paquetes fueron instalados correctamente.\n"

# -----------------------------------------------------
# Oh My Zsh (no es paquete de pacman ni de AUR)
# -----------------------------------------------------
# Se instala corriendo su script oficial. RUNZSH=no evita que abra un
# shell nuevo al terminar, CHSH=no evita que cambie tu shell por defecto
# automáticamente (eso lo dejamos como decisión tuya, aparte).
echo ""
echo "==> Configurando Oh My Zsh..."
if [ -d "$HOME/.oh-my-zsh" ]; then
    echo "✅ Oh My Zsh ya está instalado."
else
    if ! RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" > /tmp/install_ohmyzsh.log 2>&1; then
        echo "‼️  Error instalando Oh My Zsh. Revisa /tmp/install_ohmyzsh.log"
        exit 1
    fi
    echo "✅ Oh My Zsh instalado correctamente."
fi

echo ""
echo "ℹ️  Para hacer zsh tu shell por defecto, corre manualmente: chsh -s \$(which zsh)"
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# ------------------------------
# CONFIG FASTFETCH CON POKEMONS COLOR SCRIPTS
#------------------------------
# Lista de pokemons
pokemones_epicos=(
    rayquaza groudon kyogre lugia ho-oh dialga palkia giratina
    reshiram zekrom kyurem yveltal xerneas solgaleo lunala
    charizard gyarados dragonite tyranitar metagross aggron
    steelix onix wailord snorlax arcanine salamence garchomp hydreigon
)

# Elegir un Pokémon al azar estrictamente de la lista anterior
poke_elegido=${pokemones_epicos[$RANDOM % ${#pokemones_epicos[@]} + 1]}

# Mostrar Fastfetch inyectando el Pokémon elegido como logo
fastfetch --logo-type data-raw --logo "$(pokemon-colorscripts -n $poke_elegido --no-title)"
eval "$(starship init zsh)"

#---------------------------------------
# CONFIGURACION DE ALIAS PARA LA TERMIANL
#----------------------------------------
if [ -f ~/.zsh_aliases ]; then
    source ~/.zsh_aliases
fi


#----------------------------------------
# CONFIGURACIÓN DE FZF (FUZZY FINDER)
#----------------------------------------
source <(fzf --zsh)

# Configuración oficial de FZF usando FD por debajo
export FZF_DEFAULT_COMMAND="fd --type f --strip-cwd-prefix --hidden --follow --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d --strip-cwd-prefix --hidden --follow --exclude .git"

#----------------------------------------
# VISTAS PREVIAS DINÁMICAS (FZF + BAT + EZA)
#----------------------------------------

# Vista previa de archivos con 'bat' y de carpetas con 'eza' al presionar Ctrl+T
export FZF_CTRL_T_OPTS="--preview 'if [ -d {} ]; then eza --tree --color=always --icons {} | head -200; else bat --style=numbers --color=always --line-range :500 {}; fi'"

# Vista previa del árbol de carpetas con 'eza' al presionar Alt+C
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always --icons {} | head -200'"

#---------------------------------------
# VARIABLES DE ENTORNO (PATH) // sh
#---------------------------------------
export PATH="$HOME/.local/bin:$PATH"

# Custom Zinit paths
declare -A ZINIT=(
  [BIN_DIR]="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
  [HOME_DIR]="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit"
  [ZCOMPDUMP_PATH]="${XDG_CACHE_HOME:-${HOME}/.cache}/zinit/zcompdump"
)

# Set the directory we want to store zinit and plugins
export ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "${ZINIT_HOME}" ]; then
  mkdir -p "$(dirname ${ZINIT_HOME})"
  git clone https://github.com/zdharma-continuum/zinit.git "${ZINIT_HOME}"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

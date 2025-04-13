# Custom Zinit paths
declare -A ZINIT=(
  [HOME_DIR]="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit"
  [BIN_DIR]="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
  [MAN_DIR]="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/polaris/man"
  [PLUGINS_DIR]="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/plugins"
  [ZCOMPDUMP_PATH]="${XDG_CACHE_HOME:-${HOME}/.cache}/zinit/zcompdump"
  [SNIPPETS_DIR]="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/snippets"
  [COMPLETIONS_DIR]="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/completions"
  [LIST_COMMAND]="lsd --tree --group-directories-first --color=always --icon=always"
  [NO_ALIASES]=1
  [MUTE_WARNINGS]=1
  [COMPINIT_OPTS]="-C"
  [OPTIMIZE_OUT_DISK_ACCESSES]=1
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

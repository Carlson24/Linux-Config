#!/usr/bin/zsh

# 自定义 zinit，顺序来自 Github
declare -A ZINIT=(
  [BIN_DIR]="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
  [HOME_DIR]="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit"
  [MAN_DIR]="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/polaris/man"
  [PLUGINS_DIR]="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/plugins"
  [COMPLETIONS_DIR]="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/completions"
  [SNIPPETS_DIR]="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/snippets"
  [LIST_COMMAND]="eza -T"
  [ZCOMPDUMP_PATH]="${XDG_CACHE_HOME:-${HOME}/.cache}/zinit/zcompdump-$ZSH_VERSION"
  [COMPINIT_OPTS]="-C"
  [MUTE_WARNINGS]=1
  [OPTIMIZE_OUT_DISK_ACCESSES]=1
  [NO_ALIASES]=1
)
export ZPFX="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/polaris"

# 自动加载 zinit
export ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[[ ! -d $ZINIT_HOME ]] && mkdir -p "$(dirname "$ZINIT_HOME")"
[[ ! -d $ZINIT_HOME/.git ]] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "$ZINIT_HOME/zinit.zsh"

# 加载 zinit compinit
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# zmodload zsh/datetime
# setopt PROMPT_SUBST
# PS4='+$EPOCHREALTIME %N:%i> '
# logfile=$(mktemp zsh_profile.XXXXXXXX)
# echo "Logging to $logfile"
# exec 3>&2 2>$logfile
# setopt XTRACE

# Set the directory we want to store zsh config
export ZSH_CONFIG_PATH="${XDG_CONFIG_HOME:-${HOME}/.config}/zinit"

# Load zinit
source "${ZSH_CONFIG_PATH}/zinit-load.zsh"

# Load plugins
source "${ZSH_CONFIG_PATH}/plugins.zsh"

# Load Keybinds
source "${ZSH_CONFIG_PATH}/keybinds.zsh"

# Load history styling
source "${ZSH_CONFIG_PATH}/history.zsh"

# Load aliases
source "${ZSH_CONFIG_PATH}/aliases.zsh"

# Load user config
source "${ZSH_CONFIG_PATH}/userconfig.zsh"

# Shell integrations
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
source <(fzf --zsh)

# unsetopt XTRACE
# exec 2>&3 3>&-

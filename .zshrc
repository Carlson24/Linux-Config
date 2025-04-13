# zmodload zsh/datetime
# setopt PROMPT_SUBST
# PS4='+$EPOCHREALTIME %N:%i> '
# logfile=$(mktemp zsh_profile.XXXXXXXX)
# echo "Logging to $logfile"
# exec 3>&2 2>$logfile
# setopt XTRACE

# Shell integrations
eval "$(starship init zsh)"

# Set the directory we want to store zsh config
export ZSH_CONFIG_PATH="${XDG_CONFIG_HOME:-${HOME}/.config}/zinit"

# Load all config
declare -a config=(
  zinitload
  plugins
  keybinds
  history
  aliases
  userconfig
)
for config in ${config[@]}; do
  source "${ZSH_CONFIG_PATH}/${config}.zsh"
done

# unsetopt XTRACE
# exec 2>&3 3>&-

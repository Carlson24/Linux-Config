# Path to your Oh My Zsh installation.
export ZSH="${XDG_DATA_HOME:-$HOME/.local/share}"/zsh/oh-my-zsh
export ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}"/zsh
export ZSH_COMPDUMP="${XDG_CACHE_HOME:-$HOME/.cache}"/zsh/zcompdump

# Loading Plugins
plugins=(
    'fzf' 'zsh-interactive-cd' 'thefuck'
    'gpg-agent' 'safe-paste' 'zoxide'
    'shell-proxy' 'git' 'rust' 'ufw'
)
# Auto Notify & Auto Suggestions & Command not found & Fast Syntax Highlighting
source /usr/share/zsh/plugins/zsh-auto-notify/auto-notify.plugin.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source /usr/share/doc/pkgfile/command-not-found.zsh

source $ZSH/oh-my-zsh.sh

# Plugins Custom Setting
source $ZSH/../plugins-custom.zsh

# User configuration
source $ZSH/../userconfig.zsh

# Set personal aliases, overriding those provided by Oh My Zsh libs, plugins, and themes.
source $ZSH/../aliases.zsh

# Use Starship replace zsh theme
if (( $+commands[starship] )); then
  unset ZSH_THEME
  eval "$(starship init zsh)"
fi

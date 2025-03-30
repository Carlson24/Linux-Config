# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your Oh My Zsh installation.
export ZSH="$XDG_DATA_HOME"/zsh/oh-my-zsh
export ZSH_CACHE_DIR="$XDG_CACHE_HOME"/zsh
export ZSH_COMPDUMP="$XDG_DATA_HOME"/zsh/zcompdump

# Set name of the theme to load
ZSH_THEME="powerlevel10k/powerlevel10k"

# Change the auto-update behavior
zstyle ':omz:update' mode reminder    # just remind me to update when it's time

# Change how often to auto-update (in days).
zstyle ':omz:update' frequency 8

# If pasting URLs and other text is messed up.
DISABLE_MAGIC_FUNCTIONS="true"

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Disable marking untracked files
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Loading Plugins
plugins=(
    'command-not-found' 'history-substring-search'
    'fast-syntax-highlighting' 'zsh-autosuggestions'
    'fzf' 'zoxide' 'zsh-interactive-cd'
    'auto-notify' 'autoupdate' 'timer'
    'extract' 'gpg-agent' 'safe-paste' 'shell-proxy'
    'git' 'kate' 'rust' 'ufw'
)

source $ZSH/oh-my-zsh.sh

# User configuration
source $ZSH_CUSTOM/userconfig.zsh

# Set personal aliases, overriding those provided by Oh My Zsh libs, plugins, and themes.
source $ZSH_CUSTOM/aliases.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f $ZSH/../p10k.zsh ]] || source $ZSH/../p10k.zsh

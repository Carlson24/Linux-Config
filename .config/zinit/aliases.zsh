# Use uutils coreutils
# uutils coreutils is a cross-platform reimplementation of the GNU coreutils in Rust.
# While all programs have been implemented, some options might be missing or different behavior might be experienced.
if (( $+commands[uu-coreutils] )); then
  source "${ZSH_CONFIG_PATH}/aliases-uutils-coreutils.zsh"
fi

# Custom axel
alias axel="axel -n 2"

# Use bat and bat-extra to replace bat, cat, man
if (( $+commands[batman] )); then
  alias bat="prettybat"
  alias cat="prettybat"
  alias man="batman"
  alias rg="batgrep"
fi

# Use curl-rustls to replace curl, because it's safer
if (( $+commands[curl-rustls] )); then
  alias curl="curl-rustls"
fi

# Custom HIST_STAMPS
alias history="history -i"

# Use lsd to replace ls
if (( $+commands[lsd] )); then
  alias ls="lsd -a --long --group-directories-first --color=always --icon=always"
  alias la="lsd -a        --group-directories-first --color=always --icon=always"
  alias ll="lsd -l        --group-directories-first --color=always --icon=always"
  alias lt="lsd -a --tree --group-directories-first --color=always --icon=always"
fi

# Start kate always silent
alias kate="kate > /dev/null 2>&1"

#Make subversion comply with XDG Base Directory Specification
alias svn="svn --config-dir ${XDG_CONFIG_HOME:-$HOME/.config}/subversion"

# Make wget comply with XDG Base Directory Specification
alias wget="wget --hsts-file=${XDG_CACHE_HOME:-$HOME/.cache}/wget-hsts"

# Make yarn comply with XDG Base Directory Specification
alias yarn="yarn --use-yarnrc ${XDG_CONFIG_HOME:-$HOME/.config}/yarn/config"

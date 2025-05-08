# Use uutils coreutils
# uutils coreutils is a cross-platform reimplementation of the GNU coreutils in Rust.
# While all programs have been implemented, some options might be missing or different behavior might be experienced.
if (( $+commands[uu-coreutils] )); then
  declare -a uutils=(/usr/bin/uu-*)
  export deleteuu="/usr/bin/uu-"
  uutils=("${(@)uutils:#$deleteuu\[}")   # "alias [=uu-[" will cause errors, delete it.
  for _command in "${uutils[@]}"; do
    commanduu=${_command#$deleteuu}
    alias ${commanduu}="uu-${commanduu}"
  done
fi

# Use bat and bat-extra to replace bat, cat, man, rg
if (( $+commands[prettybat] )); then
  alias bat="prettybat"
  alias cat="prettybat"
  alias man="batman"
  alias rg="batgrep"
fi

# Use curl-rustls to replace curl, because it's safer
if (( $+commands[curl-rustls] )); then
  alias curl="curl-rustls"
fi

# Use sudo-rs to replace sudo
if (( $+commands[sudo-rs] )); then
  alias su="su-rs"
  alias sudo="sudo-rs"
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

# Always show details for these commands
alias cp="cp -v"
alias mv="mv -v"
alias rm="rm -v"
alias mkdir="mkdir -v"

# Fast return to directory
alias ..="cd ../"
alias ...="cd ../../"
alias ....="cd ../../../"
alias .....="cd ../../../../"

# Custom Axel
alias axel="axel -n 2"

# Show Kwin DebugConsole
alias kwinsdc="qdbus6 org.kde.KWin /KWin org.kde.KWin.showDebugConsole"

# Start kate always silent
alias kate="kate > /dev/null 2>&1"

# Update zinit completions
alias zinit-updatecompletions="zinit cclear -q && zinit creinstall -q /usr/share/zsh/site-functions"

# Make subversion comply with XDG Base Directory Specification
alias svn="svn --config-dir ${XDG_CONFIG_HOME:-$HOME/.config}/subversion"

# Make wget comply with XDG Base Directory Specification
alias wget="wget --hsts-file=${XDG_CACHE_HOME:-$HOME/.cache}/wget-hsts"

# Make yarn comply with XDG Base Directory Specification
alias yarn="yarn --use-yarnrc ${XDG_CONFIG_HOME:-$HOME/.config}/yarn/config"

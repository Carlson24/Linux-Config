# Use uutils coreutils
# uutils coreutils is a cross-platform reimplementation of the GNU coreutils in Rust.
# While all programs have been implemented, some options might be missing or different behavior might be experienced.
source $ZSH_CUSTOM/uutils-coreutils.zsh

# Custom alex
alias alex="axel -n 2 -v -a"

# Use bat and bat-extra to replace bat, cat, man
alias bat="prettybat"
alias cat="prettybat"
alias man="batman"

# Use curl-rustls to replace curl, because it's safer
alias curl="curl-rustls --progress-bar"

# Use lsd to replace ls
alias ls="lsd -al"

# Make wget comply with XDG Base Directory Specification
alias wget="wget --hsts-file=\"$XDG_CACHE_HOME\"/wget-hsts"

# Make yarn comply with XDG Base Directory Specification
alias yarn="yarn --use-yarnrc \"$XDG_CONFIG_HOME\"/yarn/config"

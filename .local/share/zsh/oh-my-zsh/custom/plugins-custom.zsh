# Plugins Custom Setting

# auto-notify
export AUTO_NOTIFY_THRESHOLD=10
export AUTO_NOTIFY_EXPIRE_TIME=15000
export AUTO_NOTIFY_IGNORE=("man" "sleep")
export AUTO_NOTIFY_TITLE="喵~命令 %command 已结束!"
export AUTO_NOTIFY_BODY="命令持续 %elapsed 秒，退出代码为：%exit_code"
export AUTO_NOTIFY_ICON_SUCCESS="$ZSH/../command-ok.png"
export AUTO_NOTIFY_ICON_FAILURE="$ZSH/../command-error.png"

# autoupdate
export UPDATE_ZSH_DAYS=8
ZSH_CUSTOM_AUTOUPDATE_QUIET=true
ZSH_CUSTOM_AUTOUPDATE_NUM_WORKERS=4

# shell-proxy
export SHELLPROXY_URL="http://127.0.0.1:2080"
export SHELLPROXY_NO_PROXY="localhost,127.0.0.1"

# timer
export TIMER_FORMAT="\n==>\033[1;32m [%d]\033[0m"
export TIMER_PRECISION=3
export TIMER_THRESHOLD=1

# zsh-completions
autoload -Uz compinit
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete
zstyle ':completion:*' format 'Completion: %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' list-prompt %S当前位于 %p: 使用 TAB 查看更多内容，或按下任意键退出%s
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' rehash true
zstyle ':completion:*' select-prompt %S循环选择模式：当前位于 %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

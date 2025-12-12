#!/usr/bin/zsh

# 更美观的 bat
if (( $+commands[prettybat] )); then
  alias bat="prettybat"
  alias cat="prettybat"
  alias man="batman"
  alias rg="batgrep"
fi

# 详细的历史命令
alias history="history -i"

# 这些命令始终显示详细信息
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -iv"
alias mkdir="mkdir -v"

# 快速返回
alias ..="cd ../"
alias ...="cd ../../"
alias ....="cd ../../../"
alias .....="cd ../../../../"

# fd 找到一个目录，ff 找到一个文件
(( $+commands[fd] )) || alias fd="find . -type d -name"
(( $+commands[ff] )) || alias ff="find . -type f -name"

# 使用 eza 代替 ls
alias ls="eza -hla --icons=always --group-directories-first"

# 快速重启 dae
alias redae="sudo systemctl restart dae.service"

# 简化 ping 命令
alias ping="ping -c 5"
alias ping6="ping6 -c 5"

# 自动临时目录
if [[ -d "/tmp/carlson" ]]; then
  function tmpdir() {
    TEMPWORKDIR=$(mktemp -d "/tmp/carlson/TMP-XXXXXX")
    cd "$TEMPWORKDIR"
  }
fi

# clear 命令提示
alias clr="clear; echo 当前作为用户 $USERNAME 登录于 $TTY ，位于目录 $PWD 。"

# 显示 KWin 调试窗口
alias kwinsdc="qdbus6 org.kde.KWin /KWin org.kde.KWin.showDebugConsole"

# 更新 zinit completions
alias zinit-updatecompletions="zinit cclear -q && zinit creinstall -q /usr/share/zsh/site-functions"

# 移走 wget 日志文件
alias wget="wget --hsts-file=${XDG_CACHE_HOME:-$HOME/.cache}/wget-hsts"

# 移走 yarn 配置
alias yarn="yarn --use-yarnrc ${XDG_CONFIG_HOME:-$HOME/.config}/yarn/config"

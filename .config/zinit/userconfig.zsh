#!/usr/bin/zsh

# 语言环境
export LANG="zh_CN.UTF-8"
export LANGUAGE="zh_CN.UTF-8"

# 默认终端编辑器
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR="vim"
else
  export EDITOR="helix"
fi

# Rust 工具镜像
export RUSTUP_DIST_SERVER="https://mirrors.ustc.edu.cn/rust-static"
export RUSTUP_UPDATE_ROOT="https://mirrors.ustc.edu.cn/rust-static/rustup"

# bat 主题
export BAT_THEME="Catppuccin Mocha"

# fzf 主题+设置
export FZF_DEFAULT_OPTS=" --height=~80% --border=vertical \
  --color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
  --color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
  --color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
  --color=selected-bg:#45475A --color=border:#6C7086,label:#CDD6F4"

# micro 使用真彩色
export MICRO_TRUECOLOR=1

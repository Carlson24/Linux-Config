#!/usr/bin/zsh

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

# micro 使用真彩色
export MICRO_TRUECOLOR=1

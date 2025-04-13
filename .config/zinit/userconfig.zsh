# Fix "no matches found"
setopt no_nomatch

# Enable Command Auto-Correction
setopt correct

# Set Language Environment
export LANG="zh_CN.UTF-8"
export LANGUAGE="zh_CN.UTF-8"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR="vim"
else
  export EDITOR="helix"
fi

# Rust Toolchain Mirrors
export RUSTUP_DIST_SERVER="https://mirrors.ustc.edu.cn/rust-static"
export RUSTUP_UPDATE_ROOT="https://mirrors.ustc.edu.cn/rust-static/rustup"

# bat theme
export BAT_THEME="Catppuccin Mocha"

# fzf theme
export FZF_DEFAULT_OPTS=" --height=~80% --border=vertical \
  --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
  --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
  --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
  --color=selected-bg:#45475a --color=border:#313244,label:#cdd6f4"

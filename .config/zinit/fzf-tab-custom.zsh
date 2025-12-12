#!/usr/bin/zsh

# 不要对 git checkout 命令排序
zstyle ':completion:*:git-checkout:*' sort false
# 启用分组支持
zstyle ':completion:*:descriptions' format '[%d]'
# 文件名彩色输出
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# 由 fzf-tab 接管补全菜单
zstyle ':completion:*' menu no
# 自动重新生成补全
zstyle ':completion:*' rehash true
# 使用 "<" ">" 切换分组
zstyle ':fzf-tab:*' switch-group '<' '>'
# fzf-tab 默认不使用全局 fzf flags，在此重定义。配色为 Catppuccin Mocha
zstyle ':fzf-tab:*' fzf-flags --bind=tab:accept --height=10 --preview-window=65% --border=vertical \
                              --color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
                              --color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
                              --color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
                              --color=selected-bg:#45475A --color=border:#6C7086,label:#CDD6F4

# 当使用 cd 时，使用 eza 预览目录
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1a --color=always --group-directories-first "$realpath"'
# 显示 systemd 单元状态
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status "$word"'
# 预览环境变量
zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' fzf-preview 'echo "${(P)word}"'
# 文件预览
zstyle ':fzf-tab:complete:*:*' fzf-preview 'less "${(Q)realpath}"'
# 配合拼音模糊搜索
zstyle ':fzf-tab:user-expand:*' fzf-preview 'less "${(Q)word}"'
# 预览 git 操作
zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview 'git diff "$word" | delta'

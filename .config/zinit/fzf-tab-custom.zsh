#!/usr/bin/zsh

# fzf 主题配色 Catppuccin Mocha
# 不要在这里定义任何设置，可能破坏 fzf-tab
export FZF_DEFAULT_OPTS="--border=vertical \
  --color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
  --color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
  --color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
  --color=selected-bg:#45475A --color=border:#6C7086,label:#CDD6F4"

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
# 使用默认 fzf 选项
zstyle ':fzf-tab:*' use-fzf-default-opts yes
# fzf-tab 附加选项
zstyle ':fzf-tab:*' fzf-flags --bind=tab:accept --height=15 --preview-window=60%


# 当预览类型为选项时，不要预览
zstyle ':fzf-tab:complete:*:options' fzf-preview
zstyle ':fzf-tab:complete:*:argument-1' fzf-preview
# 预览你要 kill 掉的程序究竟在干什么
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview \
  '[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap
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
zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview \
  'case "$group" in
    "[modified file]") git diff "$word" | delta ;;
    "[recent commit object name]") git show --color=always "$word" | delta ;;
    "[*]") git log --color=always "$word" ;;
  esac'
# 处理 pacman 查找
zstyle ':fzf-tab:complete:(\\|*/|)(pacman|paru):(argument-(rest|1)|option-l-1)' fzf-preview \
  'case "$group" in
    "[package file]") less "$realpath" ;;
    "[installed package]"|"[package]"|"[local packages]") pacman -Qi "$word" | bat -lyaml ;;
    "[packages]") (( $+commands[paru] )) && paru -Si "$word" || pacman -Si "$word" | bat -lyaml ;;
  esac'
# 显示命令帮助，tldr -> man -> which -> alias -> input
zstyle ':fzf-tab:complete:-command-:*' fzf-preview \
  '(out=$(tldr --color always "$word") 2>/dev/null && echo "$out") || \
   (out=$(MANWIDTH=$FZF_PREVIEW_COLUMNS man "$word") 2>/dev/null && echo "$out") || \
   (out=$(which "$word") && echo "$out") || echo "${(P)word}"'
# journalctl 日志
zstyle ':fzf-tab:complete:(\\|*/|)journalctl:*' fzf-preview \
  'case "$group" in
    "[boot offsets]"|"[boot ids]") journalctl -b "$word" | bat -llog ;;
    "[/dev files]") journalctl -b "/dev/$word" | bat -llog ;;
    "[commands]") journalctl "$word" | bat -llog ;;
    "[possible values]") journalctl -u "$word" | bat -llog ;;
  esac'

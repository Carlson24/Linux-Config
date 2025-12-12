#!/usr/bin/zsh

# 加载插件
zinit wait lucid light-mode for \
  atinit"zicompinit; zicdreplay" hlissner/zsh-autopair \
  atinit"zicompinit; zicdreplay" petronny/pinyin-completion \
  atinit"zicompinit; zicdreplay" Aloxaf/fzf-tab \
  atinit"zicompinit; zicdreplay" zdharma-continuum/fast-syntax-highlighting \
  atload"_zsh_autosuggest_start" zsh-users/zsh-autosuggestions \
  MichaelAquilina/zsh-you-should-use \
  MichaelAquilina/zsh-auto-notify

# Wakatime
if (( $+commands[wakatime] )); then
  zinit wait lucid light-mode for wbingli/zsh-wakatime
fi

# 来自 Oh my zsh 的一些插件
declare -a omzp=(
  extract
  systemd
  encode64
  gpg-agent
  safe-paste
  web-search
)
for _omzp in ${omzp[@]}; do
  zinit ice wait lucid
  zinit snippet OMZP::"${_omzp}"
done

# Zoxide
if (( $+commands[zoxide] )); then
  export ZOXIDE_CMD_OVERRIDE=cd # 使用 Zoxide 替换 cd
  zinit ice wait lucid
  zinit snippet OMZP::zoxide
fi

# 来自 Oh my zsh 的一些补全
declare -a omzc=(
  extract
)
for _omzc in ${omzc[@]}; do
  zinit ice wait lucid as"completion"
  zinit snippet OMZP::"${_omzc}/_${_omzc}"
done

# 自己写的小插件
export CUSTOM_SNIPPETS="${XDG_CONFIG_HOME:-$HOME/.config}/zinit/snippets"
if (( $+commands[ip] )); then
  zinit ice wait lucid
  zinit snippet "$CUSTOM_SNIPPETS/getip.zsh"
fi

# Command not Found
if (( $+commands[pkgfile] )); then
  if [[ ! -f "$CUSTOM_SNIPPETS/command-not-found.zsh" ]]; then
    ln -s "/usr/share/doc/pkgfile/command-not-found.zsh" "$CUSTOM_SNIPPETS/command-not-found.zsh"
  fi
  zinit ice wait lucid
  zinit snippet "$CUSTOM_SNIPPETS/command-not-found.zsh"
fi

# Rbenv
if (( $+commands[rbenv] )); then
  zinit ice wait lucid
  zinit snippet "$CUSTOM_SNIPPETS/rbenv.zsh"
fi

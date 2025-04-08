# Add in zsh plugins
zinit wait lucid light-mode for \
  zdharma-continuum/zinit-annex-as-monitor \
  zdharma-continuum/zinit-annex-bin-gem-node \
  zdharma-continuum/zinit-annex-patch-dl \
  zdharma-continuum/zinit-annex-rust \
  Aloxaf/fzf-tab \
  hlissner/zsh-autopair \
  Freed-Wu/fzf-tab-source \
  petronny/pinyin-completion \
  MichaelAquilina/zsh-auto-notify \
  MichaelAquilina/zsh-you-should-use \
  atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
  blockf \
    zsh-users/zsh-completions \
  atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions


# Add in snippets
zinit ice wait lucid as"completion"
zinit snippet OMZP::ufw/_ufw
zinit ice wait lucid as"completion"
zinit snippet OMZP::rust/_rustc
zinit ice wait lucid
zinit snippet OMZP::fzf
zinit ice wait lucid
zinit snippet OMZP::zoxide
zinit ice wait lucid
zinit snippet OMZP::thefuck
zinit ice wait lucid
zinit snippet OMZP::gpg-agent
zinit ice wait lucid
zinit snippet OMZP::command-not-found

# Auto Notify styling
export AUTO_NOTIFY_THRESHOLD=10
export AUTO_NOTIFY_EXPIRE_TIME=15000
export AUTO_NOTIFY_IGNORE=("man" "sleep")
export AUTO_NOTIFY_TITLE="喵~命令 %command 已结束!"
export AUTO_NOTIFY_BODY="命令持续 %elapsed 秒，退出代码为：%exit_code"
export AUTO_NOTIFY_ICON_SUCCESS="${ZSH_CONFIG_PATH}/command-ok.png"
export AUTO_NOTIFY_ICON_FAILURE="${ZSH_CONFIG_PATH}/command-error.png"

# Completion styling
zstyle ':completion:*' menu no
zstyle ':completion:*' rehash true
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors '${(s.:.)LS_COLORS}'
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':fzf-tab:*' use-fzf-default-opts yes

# You Should Use styling
export YSU_MESSAGE_FORMAT="$(tput setaf 5)杂鱼! 对于命令 %command, \
你忘记你设置了 %alias_type %alias=\"%command\" 吗!$(tput sgr0)"

# Zoxide replace cd
export ZOXIDE_CMD_OVERRIDE=cd

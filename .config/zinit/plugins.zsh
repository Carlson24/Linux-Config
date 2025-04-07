# Add in zsh plugins
zinit wait lucid for \
    atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
        zdharma-continuum/fast-syntax-highlighting \
    blockf zsh-users/zsh-completions \
    atload"!_zsh_autosuggest_start" \
        zsh-users/zsh-autosuggestions
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust \
    petronny/pinyin-completion \
    Aloxaf/fzf-tab \
    MichaelAquilina/zsh-auto-notify \
    Freed-Wu/fzf-tab-source

# Add in snippets
zinit snippet OMZP::command-not-found
zinit snippet OMZP::gpg-agent
zinit ice as"completion"
zinit snippet OMZP::ufw/_ufw
zinit ice as"completion"
zinit snippet OMZP::rust/_rustc
zinit ice wait lucid
zinit snippet OMZP::thefuck

# Auto Notify styling
export AUTO_NOTIFY_THRESHOLD=10
export AUTO_NOTIFY_EXPIRE_TIME=15000
export AUTO_NOTIFY_IGNORE=("man" "sleep")
export AUTO_NOTIFY_TITLE="喵~命令 %command 已结束!"
export AUTO_NOTIFY_BODY="命令持续 %elapsed 秒，退出代码为：%exit_code"
export AUTO_NOTIFY_ICON_SUCCESS="${ZSH_CONFIG_PATH}/command-ok.png"
export AUTO_NOTIFY_ICON_FAILURE="${ZSH_CONFIG_PATH}/command-error.png"

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors '${(s.:.)LS_COLORS}'
zstyle ':completion:*' rehash true
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' menu no
zstyle ':fzf-tab:*' use-fzf-default-opts yes

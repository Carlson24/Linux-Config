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
  atinit"zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
  atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions


# Add in snippets
declare -a omzp=(
  fzf
  sudo
  podman
  zoxide
  systemd
  thefuck
  gpg-agent
  safe-paste
  command-not-found
)
for _omzp in ${omzp[@]}; do
  zinit ice wait lucid
  zinit snippet OMZP::"${_omzp}"
done

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

# You Should Use
export YSU_HARDCORE=1
export YSU_MESSAGE_POSITION=after

# Zoxide replace cd
export ZOXIDE_CMD_OVERRIDE=cd

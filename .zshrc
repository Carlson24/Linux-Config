#!/usr/bin/zsh
## 这些内容用于追踪 zsh 启动
## 内容来自 https://blog.skk.moe/post/make-oh-my-zsh-fly
# zmodload zsh/datetime
# setopt PROMPT_SUBST
# PS4='+$EPOCHREALTIME %N:%i> '

# logfile=$(mktemp /tmp/carlson/zsh_profile.XXXXXXXX)
# export logfile
# echo "Logging to $logfile"
# exec 3>&2 2>$logfile

# setopt XTRACE
## 文件最后还有

# 加载主题，来自 starship
if (( $+commands[starship] )); then
  eval "$(starship init zsh)"
fi

# 拆分配置
export ZINIT_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/zinit"
declare -a CONFIG_NAME=(
  zinitload
  plugin
  pluginopt
  fzf-tab-custom
  customopt
  aliases
  userconfig
)

# 加载配置
for _config in "${CONFIG_NAME[@]}"; do
  source "$ZINIT_CONFIG_DIR/$_config.zsh"
done

## 与开头内容配合使用
# unsetopt XTRACE
# exec 2>&3 3>&-

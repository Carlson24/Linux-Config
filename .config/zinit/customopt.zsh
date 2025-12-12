#!/usr/bin/zsh

# 历史记录自定义
export HISTSIZE=10240
export SAVEHIST=10240
export HISTFILE="${XDG_CACHE_HOME:-${HOME}/.cache}/zinit/history"
setopt APPEND_HISTORY          # 使用追加历史记录而不是替换
setopt EXTENDED_HISTORY        # 拓展历史记录 :<beginning time>:<elapsed seconds>:<command>
setopt HIST_IGNORE_DUPS        # 连续重复命令只记录一个
setopt HIST_IGNORE_SPACE       # 不记录开头为空格的命令
setopt INC_APPEND_HISTORY_TIME # 多个实例即时共享历史记录

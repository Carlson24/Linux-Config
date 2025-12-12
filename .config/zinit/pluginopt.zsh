#!/usr/bin/zsh

# You Should Use 自定义
export YSU_HARDCORE=1               # “硬核模式”
export YSU_MESSAGE_POSITION="after" # 如果找到了别名，则提示

# Pinyin Completion 支持双拼
declare -A FUZZY=(
  [zh]=v
  [ch]=i
  [sh]=u
)

# Auto Notify 自定义
export AUTO_NOTIFY_THRESHOLD=10                                         # 超过 10 秒的命令显示通知
export AUTO_NOTIFY_EXPIRE_TIME=15000                                    # 通知持续 15 秒
export AUTO_NOTIFY_IGNORE=("man" "sleep")                               # 这些命令永不通知
export AUTO_NOTIFY_TITLE="喵~命令 %command 已结束!"                     # 通知标题
export AUTO_NOTIFY_BODY="命令持续 %elapsed 秒，退出代码为：%exit_code"  # 通知文本
export AUTO_NOTIFY_ICON_SUCCESS="${ZINIT_CONFIG_DIR}/command-ok.png"    # 成功图标
export AUTO_NOTIFY_ICON_FAILURE="${ZINIT_CONFIG_DIR}/command-error.png" # 失败图标


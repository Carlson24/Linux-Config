#!/ur/bin/zsh

# 彩色输出
log() {
  local red="\033[0;31m" green="\033[0;32m" yellow="\033[0;33m" nc="\033[0m"
  local level="$1" color="$nc"
  case "$level" in
    INFO) color="$green" ;;
    WARN) color="$yellow" ;;
    ERROR) color="$red" ;;
  esac
  shift
  printf "${color}[%s] %s${nc}\n" "$level" "$*"
}

# 获取当前 IPv4 & IPv6
# printf "%-10s %s\n" '10' 可以自行修改
function getip() {
  ip addr show | awk '
    /^[0-9]+:/ {
      gsub(/:/, "", $2)
      iface = $2
    }
    /^[[:space:]]*inet / || /^[[:space:]]*inet6 / {
      printf "%-10s %s\n", iface, $2
    }'
}

# 快速打包为 tar.zst
function tarzst() {
  if [[ -d "$1" ]]; then
    log ERROR "\"$1\" 是一个目录！"
    return 1
  elif [[ -f "$1" ]]; then
    log ERROR "文件 \"$1\" 已存在！继续操作将覆盖文件！"
    return 1
  else
    tar -I 'zstd -v -c -T0 --auto-threads=logical -9' -c -f "$@"
  fi
}

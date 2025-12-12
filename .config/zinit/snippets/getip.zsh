#!/usr/bin/zsh

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

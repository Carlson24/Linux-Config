#!/usr/bin/zsh

export RBENV_ROOT="${XDG_DATA_HOME:-${HOME}/.local/share}/rubyenv"
export PATH="$RBENV_ROOT/shims:$PATH"
export RBENV_SHELL=zsh
rbenv() {
  local command
  command="${1:-}"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  rehash|shell)
    eval "$(rbenv "sh-$command" "$@")";;
  *)
    command rbenv "$command" "$@";;
  esac
}

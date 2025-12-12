### Add local bin to PATH
[[ ! -d "$HOME/.local/bin" ]] || export PATH="$HOME/.local/bin:$PATH"

### XDG User directories
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"

### Consistent file dialog
export GDK_DEBUG=portals
export GTK_USE_PORTAL=1

### CUDA
export CUDA_CACHE_PATH="${XDG_CACHE_HOME:-${HOME}/.cache}/nvidia-cuda"

### EDITOR
export EDITOR=helix
export VISUAL=helix
export SUDO_EDITOR=helix

### Go
export GOPATH="${XDG_DATA_HOME:-${HOME}/.local/share}/go"
export GOMODCACHE="${XDG_CACHE_HOME:-${HOME}/.cache}/go/mod"

### GTK2
export GTK2_RC_FILES="${XDG_CONFIG_HOME:-${HOME}/.config}/gtk-2.0/settings.ini"

### Gradle
export GRADLE_USER_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/gradle"

### Hardware raytracing
export VKD3D_CONFIG="dxr11,dxr"
export PROTON_ENABLE_NVAPI=1
export PROTON_ENABLE_NGX_UPDATER=1

### Kwallet
export GIT_ASKPASS="/usr/bin/ksshaskpass"
export SSH_ASKPASS="/usr/bin/ksshaskpass"
export SSH_ASKPASS_REQUIRE=prefer

### LessPipe
export LESSOPEN="|lesspipe.sh %s"

### LFS
[[ ! -d "/mnt/lfs" ]] || export LFS="/mnt/lfs"

### Maven
export MAVEN_OPTS=-Dmaven.repo.local="${XDG_DATA_HOME:-${HOME}/.local/share}/maven/repository"

### MySQL
export MYSQL_HISTFILE="${XDG_DATA_HOME:-${HOME}/.local/share}/mysql_history"

### Npm
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME:-${HOME}/.config}/npm/npmrc"

### Nuget
export NUGET_PACKAGES="${XDG_CACHE_HOME:-${HOME}/.cache}/NuGetPackages"

### PostgreSQL
export PSQLRC="${XDG_CONFIG_HOME:-${HOME}/.config}/pg/psqlrc"
export PSQL_HISTORY="${XDG_STATE_HOME:-${HOME}/.local/state}/psql_history"
export PGPASSFILE="${XDG_CONFIG_HOME:-${HOME}/.config}/pg/pgpass"
export PGSERVICEFILE="${XDG_CONFIG_HOME:-${HOME}/.config}/pg/pg_service.conf"

### Proton
export PROTON_ENABLE_WAYLAND=1

### Python
export PYTHON_HISTORY="${XDG_STATE_HOME:-${HOME}/.local/state}/python_history"
export PYTHONPYCACHEPREFIX="${XDG_CACHE_HOME:-${HOME}/.cache}/python"
export PYTHONUSERBASE="${XDG_DATA_HOME:-${HOME}/.local/share}/python"

### Readline
export INPUTRC="${XDG_CONFIG_HOME:-${HOME}/.config}/readline/inputrc"

### Ruby-Bundler
export BUNDLE_USER_CACHE="${XDG_CACHE_HOME:-${HOME}/.cache}/bundle"
export BUNDLE_USER_CONFIG="${XDG_CONFIG_HOME:-${HOME}/.config}/bundle/config"
export BUNDLE_USER_PLUGIN="${XDG_DATA_HOME:-${HOME}/.local/share}/bundle"

### Rust
export CARGO_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/cargo"
export RUSTUP_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/rustup"

### SDL2
export SDL_VIDEODRIVER="wayland,x11"

### TeX Live
export TEXMFHOME="${XDG_DATA_HOME:-${HOME}/.local/share}/texmf"
export TEXMFVAR="${XDG_CACHE_HOME:-${HOME}/.cache}/texlive/texmf-var"
export TEXMFCONFIG="${XDG_CONFIG_HOME:-${HOME}/.config}/texlive/texmf-config"

### VSCode
export VSCODE_CLI_DATA_DIR="${XDG_DATA_HOME:-${HOME}/.local/share}/vscode/cli"
export VSCODE_PORTABLE="${XDG_DATA_HOME:-${HOME}/.local/share}/vscode"

### WakaTime
export WAKATIME_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}/wakatime"

### Wget
export WGETRC="${XDG_CONFIG_HOME:-${HOME}/.config}/wgetrc"

### Wine
export WINEPREFIX="${XDG_DATA_HOME:-${HOME}/.local/share}/wineprefixes/default"

### Zsh
export HISTFILE="${XDG_CACHE_HOME:-${HOME}/.cache}/zinit/history"

### Ramfs
if [[ ! -d "/tmp/carlson" ]]; then
  mkdir -p "/tmp/carlson"
  echo -e "[Desktop Entry]\nIcon=folder-recent" >"/tmp/carlson/.directory"
fi

### Sync All Environment to systemd
command -v dbus-update-activation-environment &>/dev/null &&
  dbus-update-activation-environment --systemd --all 2>/dev/null

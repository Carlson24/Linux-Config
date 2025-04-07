### Add local bin to PATH
typeset -U path PATH
path=($path ${HOME}/.local/bin)

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

### Fcitx5
export QT_IM_MODULES="wayland;fcitx;ibus"
export XMODIFIERS="@im=fcitx"

### GnuPG
export GNUPGHOME="${XDG_DATA_HOME:-${HOME}/.locale/share}/gnupg"

### Go
export GOPATH="${XDG_DATA_HOME:-${HOME}/.locale/share}/go"
export GOMODCACHE="${XDG_CACHE_HOME:-${HOME}/.cache}/go/mod"

### GTK2
export GTK2_RC_FILES="${XDG_CONFIG_HOME:-${HOME}/.config}/gtk-2.0/settings.ini"

### Gradle
export GRADLE_USER_HOME="${XDG_DATA_HOME:-${HOME}/.locale/share}/gradle"

### Hardware raytracing
export VKD3D_CONFIG="dxr11,dxr"
export PROTON_ENABLE_NVAPI=1
export PROTON_ENABLE_NGX_UPDATER=1

### Java
# export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="${XDG_CONFIG_HOME:-${HOME}/.config}/java"

### Kwallet
export GIT_ASKPASS="/usr/bin/ksshaskpass"
export SSH_ASKPASS="/usr/bin/ksshaskpass"
export SSH_ASKPASS_REQUIRE=prefer

### LFS
export LFS="/mnt/lfs"

### Maven
export MAVEN_OPTS=-Dmaven.repo.local="${XDG_DATA_HOME:-${HOME}/.locale/share}/maven/repository"

### MySQL
export MYSQL_HISTFILE="${XDG_DATA_HOME:-${HOME}/.locale/share}/mysql_history"

### Npm
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME:-${HOME}/.config}/npm/npmrc"

### Nuget
export NUGET_PACKAGES="${XDG_CACHE_HOME:-${HOME}/.cache}/NuGetPackages"

# PostgreSQL
export PSQLRC="${XDG_CONFIG_HOME:-${HOME}/.config}/pg/psqlrc"
export PSQL_HISTORY="${XDG_STATE_HOME:-${HOME}/.local/state}/psql_history"
export PGPASSFILE="${XDG_CONFIG_HOME:-${HOME}/.config}/pg/pgpass"
export PGSERVICEFILE="${XDG_CONFIG_HOME:-${HOME}/.config}/pg/pg_service.conf"

### Proton
export PROTON_ENABLE_WAYLAND=1

### Python
export PYTHON_HISTORY="${XDG_STATE_HOME:-${HOME}/.local/state}/python_history"
export PYTHONPYCACHEPREFIX="${XDG_CACHE_HOME:-${HOME}/.cache}/python"
export PYTHONUSERBASE="${XDG_DATA_HOME:-${HOME}/.locale/share}/python"

### Qt
# export QT_AUTO_SCREEN_SCALE_FACTOR=0
# export QT_ENABLE_HIGHDPI_SCALING=0

### Readline
export INPUTRC="${XDG_CONFIG_HOME:-${HOME}/.config}/readline/inputrc"

### Ruby-Bundler
export BUNDLE_USER_CACHE="${XDG_CACHE_HOME:-${HOME}/.cache}/bundle"
export BUNDLE_USER_CONFIG="${XDG_CONFIG_HOME:-${HOME}/.config}/bundle/config"
export BUNDLE_USER_PLUGIN="${XDG_DATA_HOME:-${HOME}/.locale/share}/bundle"

### Rust
export CARGO_HOME="${XDG_DATA_HOME:-${HOME}/.locale/share}/cargo"
export RUSTUP_HOME="${XDG_DATA_HOME:-${HOME}/.locale/share}/rustup"

### SDL2
export SDL_VIDEODRIVER="wayland,x11"

### VSCode
export VSCODE_CLI_DATA_DIR="${XDG_DATA_HOME:-${HOME}/.locale/share}/vscode/cli"
export VSCODE_PORTABLE="${XDG_DATA_HOME:-${HOME}/.locale/share}/vscode"

### Wget
export WGETRC="${XDG_CONFIG_HOME:-${HOME}/.config}/wgetrc"

### Wine
export WINEPREFIX="${XDG_DATA_HOME:-${HOME}/.locale/share}/wineprefixes/default"

### Zsh
export HISTFILE="${XDG_CACHE_HOME:-${HOME}/.cache}/zinit/history"

### Sync All Environment to systemd
command -v dbus-update-activation-environment &> /dev/null && \
    dbus-update-activation-environment --systemd --all 2> /dev/null

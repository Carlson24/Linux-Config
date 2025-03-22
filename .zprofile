### Add local bin to PATH
typeset -U path PATH
path=($path ~/.local/bin)

### XDG User directories
export XDG_CACHE_HOME=~/.cache
export XDG_CONFIG_HOME=~/.config
export XDG_DATA_HOME=~/.local/share
export XDG_STATE_HOME=~/.local/state

### Consistent file dialog
export GDK_DEBUG=portals
export GTK_USE_PORTAL=1

### CUDA
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nvidia-cuda

### Fcitx5
export QT_IM_MODULES="wayland;fcitx;ibus"
export XMODIFIERS="@im=fcitx"

### GnuPG
export GNUPGHOME="$XDG_DATA_HOME"/gnupg

### Go
export GOPATH="$XDG_DATA_HOME"/go
export GOMODCACHE="$XDG_CACHE_HOME"/go/mod

### GTK2
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/settings.ini

### Gradle
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle

### Hardware raytracing
export VKD3D_CONFIG="dxr11,dxr"
export PROTON_ENABLE_NVAPI=1
export PROTON_ENABLE_NGX_UPDATER=1

### Kwallet
export GIT_ASKPASS=/usr/bin/ksshaskpass
export SSH_ASKPASS=/usr/bin/ksshaskpass
export SSH_ASKPASS_REQUIRE=prefer

### LFS
export LFS=/mnt/lfs

### Maven
export MAVEN_OPTS=-Dmaven.repo.local="$XDG_DATA_HOME"/maven/repository

### Npm
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc

# PostgreSQL
export PSQLRC="$XDG_CONFIG_HOME"/pg/psqlrc
export PSQL_HISTORY="$XDG_STATE_HOME"/psql_history
export PGPASSFILE="$XDG_CONFIG_HOME"/pg/pgpass
export PGSERVICEFILE="$XDG_CONFIG_HOME"/pg/pg_service.conf

### Proton
export PROTON_ENABLE_WAYLAND=1

### Python
export PYTHON_HISTORY="$XDG_STATE_HOME"/python_history
export PYTHONPYCACHEPREFIX="$XDG_CACHE_HOME"/python
export PYTHONUSERBASE="$XDG_DATA_HOME"/python

### Qt
# export QT_AUTO_SCREEN_SCALE_FACTOR=0
# QT_ENABLE_HIGHDPI_SCALING=0

### Readline
export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc

### Rust
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup

### SDL2
export SDL_VIDEODRIVER="wayland,x11"

### VSCode
export VSCODE_CLI_DATA_DIR="$XDG_DATA_HOME"/vscode/cli
export VSCODE_PORTABLE="$XDG_DATA_HOME"/vscode

### Wget
export WGETRC="$XDG_CONFIG_HOME"/wgetrc

### Wine
export WINEPREFIX="$XDG_DATA_HOME"/wineprefixes/default

### Zsh
export HISTFILE="$XDG_DATA_HOME"/zsh/history
export ZSH="$XDG_DATA_HOME"/zsh/oh-my-zsh
export ZSH_CACHE_DIR="$XDG_CACHE_HOME"/zsh
export ZSH_COMPDUMP="$XDG_DATA_HOME"/zsh/zcompdump

### Sync All Environment to systemd
command -v dbus-update-activation-environment &> /dev/null && \
    dbus-update-activation-environment --systemd --all 2> /dev/null

### XDG 目录
export XDG_CONFIG_HOME=~/.config
export XDG_CACHE_HOME=~/.cache
export XDG_DATA_HOME=~/.data
export XDG_STATE_HOME=~/.state

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
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc

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

### Proton
export PROTON_ENABLE_WAYLAND=1

### Qt
export QT_AUTO_SCREEN_SCALE_FACTOR=0

### Rust
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup

### SDL2
export SDL_VIDEODRIVER="wayland,x11"

### VSCode
export VSCODE_CLI_DATA_DIR="$XDG_DATA_HOME"/vscode/cli
export VSCODE_PORTABLE="$XDG_DATA_HOME"/vscode

### Wine
export WINEPREFIX="$XDG_DATA_HOME"/wineprefixes/default

### Zsh
export HISTFILE="$XDG_DATA_HOME"/zsh/history
export ZSH="$XDG_DATA_HOME"/zsh/oh-my-zsh
export ZSH_COMPDUMP="$XDG_DATA_HOME"/zsh/zcompdump

# 同步所有环境变量到所有systemd将要启动的程序
command -v dbus-update-activation-environment &> /dev/null && \
    dbus-update-activation-environment --systemd --all 2> /dev/null

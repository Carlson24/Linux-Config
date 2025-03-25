# Arch Linux 安装教程（With CachyOS）

- 该教程非常简易，写他的初衷只是为了记录我的安装过程，方便以后查看。

## 准备阶段

```bash
systemctl stop reflector.service
iwctl
ping -c 4 www.archlinux.org
timedatectl set-ntp true
timedatectl status
```

## 分区与格式化

```bash
wipefs -a /dev/nvme0n1
wipefs -a /dev/nvme1n1

parted /dev/nvme0n1
(parted)gpt
parted /dev/nvme1n1
(parted)gpt

cgdisk /dev/nvme0n1
(cgdisk)    boot    1826816     ef00    BOOT
(cgdisk)    rootfs  402657280   8304    cachyos
(cgdisk)    rootfs  67112960    8304    lfs
(cgdisk)    swap    16781312    8200    swap

cgdisk /dev/nvme1n1
(cgdisk)    data    "all"       8300    data

cryptsetup luksFormat --type luks2 --cipher aes-xts-plain64 --hash sha512 --iter-time 4096 --key-size 512 --pbkdf argon2id --use-urandom --sector-size=4096 --verify-passphrase --verbose --label=cachyos /dev/nvme0n1p2
cryptsetup luksFormat --type luks2 --cipher aes-xts-plain64 --hash sha512 --iter-time 4096 --key-size 512 --pbkdf argon2id --use-urandom --sector-size=4096 --verify-passphrase --verbose --label=lfs     /dev/nvme0n1p3
cryptsetup luksFormat --type luks2 --cipher aes-xts-plain64 --hash sha512 --iter-time 4096 --key-size 512 --pbkdf argon2id --use-urandom --sector-size=4096 --verify-passphrase --verbose --label=swap    /dev/nvme0n1p4
cryptsetup luksFormat --type luks2 --cipher aes-xts-plain64 --hash sha512 --iter-time 4096 --key-size 512 --pbkdf argon2id --use-urandom --sector-size=4096 --verify-passphrase --verbose --label=data    /dev/nvme1n1p1

cryptsetup open /dev/nvme0n1p2 cachyos
cryptsetup open /dev/nvme0n1p3 lfs
cryptsetup open /dev/nvme0n1p4 swap
cryptsetup open /dev/nvme1n1p1 data

mkfs.fat -F 32   -S 4096 -n BOOT    /dev/nvme0n1p1
mkfs.btrfs -f -v -s 4096 -L cachyos /dev/mapper/cachyos
mkfs.btrfs -f -v -s 4096 -L data    /dev/mapper/data
mkfs.ext4 -v     -b 4096 -L lfs     /dev/mapper/lfs
mkswap --verbose -p 4096 -L swap    /dev/mapper/swap
```

## 建立子卷并挂载

```bash
mount -v -t btrfs --mkdir /dev/mapper/cachyos /mnt/btrfstmp -o defaults,noatime,ssd,discard=async,space_cache=v2,compress=zstd:3,commit=120

cd /mnt/btrfstmp
btrfs subvolume create @
btrfs subvolume create @home
btrfs subvolume create @snapshots
btrfs subvolume create @var_cache
btrfs subvolume create @var_log
btrfs subvolume list .
cd .. && umount -Rv /mnt/btrfstmp

mount -v -t btrfs --mkdir /dev/mapper/data    /mnt/btrfstmp -o defaults,noatime,ssd,discard=async,space_cache=v2,compress=zstd:3,commit=120

cd /mnt/btrfstmp
btrfs subvolume create @data
btrfs subvolume list .
cd .. && umount -Rv /mnt/btrfstmp

mount -v -t btrfs -o defaults,noatime,ssd,discard=async,space_cache=v2,compress=zstd:3,commit=120,subvol=/@          --mkdir /dev/mapper/cachyos /mnt/cachyos
mount -v -t btrfs -o defaults,noatime,ssd,discard=async,space_cache=v2,compress=zstd:3,commit=120,subvol=/@home      --mkdir /dev/mapper/cachyos /mnt/cachyos/home
mount -v -t btrfs -o defaults,noatime,ssd,discard=async,space_cache=v2,compress=zstd:3,commit=120,subvol=/@var_cache --mkdir /dev/mapper/cachyos /mnt/cachyos/var/cache
mount -v -t btrfs -o defaults,noatime,ssd,discard=async,space_cache=v2,compress=zstd:3,commit=120,subvol=/@var_log   --mkdir /dev/mapper/cachyos /mnt/cachyos/var/log
mount -v -t btrfs -o defaults,noatime,ssd,discard=async,space_cache=v2,compress=zstd:3,commit=120,subvol=/@snapshots --mkdir /dev/mapper/cachyos /mnt/cachyos/.snapshots
mount -v -t btrfs -o defaults,noatime,ssd,discard=async,space_cache=v2,compress=zstd:3,commit=120,subvol=/@data      --mkdir /dev/mapper/data    /mnt/cachyos/mnt/data
mount -v -t ext4  -o defaults,noatime            --mkdir /dev/mapper/lfs /mnt/cachyos/mnt/lfs
mount -v -t vfat  -o defaults,noatime,umask=0027 --mkdir /dev/nvme0n1p1  /mnt/cachyos/boot
swapon /dev/mapper/swap
```

## 安装前准备

```bash
mkdir -pv /mnt/cachyos/etc/pacman.d
cat << "EOF" > /mnt/cachyos/etc/pacman.d/mirrorlist
######################################################
####                                              ####
####       ArchLinux Repository Mirrorlist        ####
####                                              ####
######################################################

## China
Server = https://mirror.nju.edu.cn/archlinux/$repo/os/$arch
Server = https://mirrors.ustc.edu.cn/archlinux/$repo/os/$arch
#Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch

## CachyOS
Server = https://archlinux.cachyos.org/repo/$repo/os/$arch
Server = https://build-1.cachyos.org/archlinux/$repo/os/$arch

## Worldwide
Server = https://geo.mirror.pkgbuild.com/$repo/os/$arch
Server = https://ftpmirror.infania.net/mirror/archlinux/$repo/os/$arch

## Rackspace
Server = https://mirror.rackspace.com/archlinux/$repo/os/$arch
Server = https://dfw.mirror.rackspace.com/archlinux/$repo/os/$arch
Server = https://hkg.mirror.rackspace.com/archlinux/$repo/os/$arch
Server = https://iad.mirror.rackspace.com/archlinux/$repo/os/$arch
Server = https://lon.mirror.rackspace.com/archlinux/$repo/os/$arch
Server = https://ord.mirror.rackspace.com/archlinux/$repo/os/$arch
Server = https://syd.mirror.rackspace.com/archlinux/$repo/os/$arch
EOF

cat << "EOF" > /mnt/cachyos/etc/pacman.d/cachyos-mirrorlist
######################################################
####                                              ####
####        CachyOS Repository Mirrorlist         ####
####                                              ####
######################################################

## China
Server = https://mirror.nju.edu.cn/cachyos/repo/$arch/$repo
Server = https://mirrors.ustc.edu.cn/cachyos/repo/$arch/$repo
#Server = https://mirrors.tuna.tsinghua.edu.cn/cachyos/repo/$arch/$repo

## CDN77 (World Wide Datacenters)
Server = https://cdn77.cachyos.org/repo/$arch/$repo

## Tebi CDN (Germany, USA, SG)
Server = https://cdn-1.cachyos.org/$arch/$repo

## Cloudflare R2
Server = https://cdn.cachyos.org/repo/$arch/$repo

## Germany
Server = https://aur.cachyos.org/repo/$arch/$repo
Server = https://mirror.cachyos.org/repo/$arch/$repo

## USA
Server = https://us.cachyos.org/repo/$arch/$repo

## Austria
Server = https://at.cachyos.org/repo/$arch/$repo
EOF

cp -v /mnt/cachyos/etc/pacman.d/cachyos-mirrorlist /mnt/cachyos/etc/pacman.d/cachyos-v3-mirrorlist
cp -v /mnt/cachyos/etc/pacman.d/cachyos-mirrorlist /mnt/cachyos/etc/pacman.d/cachyos-v4-mirrorlist

sed -i 's|/$arch/|/$arch_v3/|g' "/mnt/cachyos/etc/pacman.d/cachyos-v3-mirrorlist"
sed -i 's|/$arch/|/$arch_v4/|g' "/mnt/cachyos/etc/pacman.d/cachyos-v4-mirrorlist"

chattr +i /mnt/cachyos/etc/pacman.d/* && lsattr /mnt/cachyos/etc/pacman.d/*
```

## 安装并配置系统

```bash
pacstrap -K /mnt/cachyos base base-devel multilib-devel linux-cachyos linux-cachyos-dbg linux-cachyos-headers linux-cachyos-nvidia-open linux-cachyos-zfs mkinitcpio-firmware intel-ucode alsa-firmware sof-firmware chwd archlinux-keyring cachyos-keyring pacman-mirrorlist cachyos-mirrorlist cachyos-v3-mirrorlist cachyos-v4-mirrorlist helix gcc mkinitcpio iptables-nft btrfs-progs bash-completion

genfstab -U /mnt/cachyos >> /mnt/cachyos/etc/fstab

arch-chroot /mnt/cachyos

sed '/# The testing repositories are disabled by default./i\# cachyos repos\n\n#<disabled_v4>[cachyos-v4]\n#<disabled_v4>Include = \/etc\/pacman.d\/cachyos-v4-mirrorlist\n\n#<disabled_v4>[cachyos-core-v4]\n#<disabled_v4>Include = \/etc\/pacman.d\/cachyos-v4-mirrorlist\n\n#<disabled_v4>[cachyos-extra-v4]\n#<disabled_v4>Include = \/etc\/pacman.d\/cachyos-v4-mirrorlist\n\n#<disabled_v3>[cachyos-v3]\n#<disabled_v3>Include = \/etc\/pacman.d\/cachyos-v3-mirrorlist\n\n#<disabled_v3>[cachyos-core-v3]\n#<disabled_v3>Include = \/etc\/pacman.d\/cachyos-v3-mirrorlist\n\n#<disabled_v3>[cachyos-extra-v3]\n#<disabled_v3>Include = \/etc\/pacman.d\/cachyos-v3-mirrorlist\n\n[cachyos]\nInclude = \/etc\/pacman.d\/cachyos-mirrorlist\n' -i /etc/pacman.conf

sed 's/#Color/Color/g'                                                     -i /etc/pacman.conf
sed 's/#ILoveCandy/ILoveCandy/g'                                           -i /etc/pacman.conf
sed 's/#CheckSpace/CheckSpace/g'                                           -i /etc/pacman.conf
sed 's/#VerbosePkgLists/VerbosePkgLists/g'                                 -i /etc/pacman.conf
sed 's/ParallelDownloads = 5/ParallelDownloads = 4/g'                      -i /etc/pacman.conf
sed 's/LocalFileSigLevel = Optional/LocalFileSigLevel = Required/g'        -i /etc/pacman.conf
sed 's/#RemoteFileSigLevel = Required/RemoteFileSigLevel = Required/g'     -i /etc/pacman.conf
sed '/#\[multilib\]/{n;d}'                                                 -i /etc/pacman.conf
sed 's/#\[multilib\]/\[multilib]\nInclude = \/etc\/pacman.d\/mirrorlist/g' -i /etc/pacman.conf

pacman -Sy --asdeps --needed cachyos-fish-config cachyos-hooks cachyos-rate-mirrors cachyos-settings dosfstools efibootmgr exfatprogs f2fs-tools inetutils jfsutils less logrotate lsb-release lvm2 man-db man-pages mdadm netctl python s-nail sysfsutils usbutils xfsprogs plymouth cachyos-plymouth-theme snapper systemd-boot-manager

rm -rf /etc/machine-id && systemd-machine-id-setup && ln -svf /etc/machine-id /var/lib/dbus/machine-id
ln -svf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && hwclock --systohc --utc

cat << "EOF" >> /etc/locale.gen
## CachyOS
# EngLish
en_GB.UTF-8 UTF-8
en_SG.UTF-8 UTF-8
en_US.UTF-8 UTF-8
# Chinese
zh_CN.UTF-8 UTF-8
zh_SG.UTF-8 UTF-8
zh_TW.UTF-8 UTF-8
EOF

locale-gen

cat << "EOF" > /etc/locale.conf
LANG=en_GB.UTF-8
EOF

cat << "EOF" > /etc/hostname
Carlson-Laptop
EOF

cat << "EOF" >> /etc/hosts

# The following lines are desirable for IPv4 capable hosts
127.0.0.1   localhost

# 127.0.1.1 is often used for the FQDN of the machine
127.0.1.1   Carlson-Laptop.localdomain  Carlson-Laptop

# The following lines are desirable for IPv6 capable hosts
::1         localhost   ip6-localhost   ip6-loopback
ff02::1     ip6-allnodes
ff02::2     ip6-allrouters
EOF

cat << "EOF" > /etc/vconsole.conf
# Written by systemd-localed(8) or systemd-firstboot(1), read by systemd-localed
# and systemd-vconsole-setup(8). Use localectl(1) to update this file.
FONT=ter-v32b
KEYMAP=us
XKBLAYOUT=us
XKBMODEL=pc104
XKBOPTIONS=terminate:ctrl_alt_bksp
EOF

mkdir -pv /etc/X11/xorg.conf.d
cat << "EOF" > /etc/X11/xorg.conf.d/00-keyboard.conf
# Written by systemd-localed(8), read by systemd-localed and Xorg. It's
# probably wise not to edit this file manually. Use localectl(1) to
# update this file.
Section "InputClass"
        Identifier "system-keyboard"
        MatchIsKeyboard "on"
        Option "XkbLayout" "us"
        Option "XkbModel" "pc104"
        Option "XkbOptions" "terminate:ctrl_alt_bksp"
EndSection
EOF

cat << "EOF" > /etc/default/keyboard
# KEYBOARD CONFIGURATION FILE

# Consult the keyboard(5) manual page.

XKBMODEL="pc104"
XKBLAYOUT="us"
XKBOPTIONS="terminate:ctrl_alt_bksp"
BACKSPACE="guess"
EOF

pacman -Sy mesa lib32-mesa libva-intel-driver lib32-libva-intel-driver vulkan-intel lib32-vulkan-intel intel-media-driver opencl-rusticl-mesa lib32-opencl-rusticl-mesa
pacman -Sy nvidia-utils egl-wayland nvidia-settings opencl-nvidia lib32-opencl-nvidia lib32-nvidia-utils libva-nvidia-driver vulkan-icd-loader lib32-vulkan-icd-loader nvidia-prime switcheroo-control

cat << "EOF" > /etc/mkinitcpio.conf.d/10-chwd.conf
# This file is automatically generated by chwd. PLEASE DO NOT EDIT IT.
MODULES+=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)
EOF

cat << "EOF" > /etc/profile.d/nvidia-rtd3-workaround.sh
# This file is automatically generated by chwd. PLEASE DO NOT EDIT IT.
if [ -n "$(lspci -d "10de:*:0302")" ]; then
    export __EGL_VENDOR_LIBRARY_FILENAMES=/usr/share/glvnd/egl_vendor.d/50_mesa.json
fi
EOF

cat << "EOF" | install -Dm755 /dev/stdin /usr/lib/systemd/user-environment-generators/20-nvidia-rtd3-workaround
#!/usr/bin/env sh
# This file is automatically generated by chwd. PLEASE DO NOT EDIT IT.
if [ -n "$(lspci -d "10de:*:0302")" ]; then
    echo "__EGL_VENDOR_LIBRARY_FILENAMES=/usr/share/glvnd/egl_vendor.d/50_mesa.json"
fi
EOF

systemctl enable nvidia-powerd.service
systemctl enable switcheroo-control.service
chwd --autoconfigure
sed 's/#<disabled_v4>//g' -i /etc/pacman.conf
sed 's/#<disabled_v3>//g' -i /etc/pacman.conf
pacman -Syy && pacman -Suu

pacman -Sy adobe-source-code-pro-fonts adobe-source-han-sans-cn-fonts adobe-source-han-sans-hk-fonts adobe-source-han-sans-jp-fonts adobe-source-han-sans-kr-fonts adobe-source-han-sans-tw-fonts adobe-source-han-serif-cn-fonts adobe-source-han-serif-hk-fonts adobe-source-han-serif-jp-fonts adobe-source-han-serif-kr-fonts adobe-source-han-serif-tw-fonts awesome-terminal-fonts cantarell-fonts gnu-free-fonts noto-color-emoji-fontconfig noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra opendesktop-fonts otf-monaspace powerline-fonts terminus-font ttc-iosevka ttc-iosevka-aile ttc-iosevka-curly ttc-iosevka-curly-slab ttc-iosevka-etoile ttc-iosevka-slab ttf-bitstream-vera ttf-carlito ttf-cascadia-code ttf-dejavu ttf-fantasque-nerd ttf-fira-code ttf-fira-mono ttf-fira-sans ttf-hack ttf-input ttf-intel-one-mono ttf-jetbrains-mono ttf-joypixels ttf-liberation ttf-meslo-nerd ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-mono ttf-opensans ttf-roboto ttf-roboto-mono ttf-sarasa-gothic ttf-ubuntu-font-family wqy-zenhei
pacman -Sy plasma-meta
pacman -Sy profile-sync-daemon firefox-developer-edition firefox-developer-edition-i18n-zh-cn
pacman -Sy --asdeps --needed cachyos-fish-config cachyos-ananicy-rules cachyos-hello cachyos-kernel-manager cachyos-packageinstaller cachyos-settings cachyos-zsh-config cachyos-wallpapers
pacman -Sy --asdeps --needed libwnck3 mesa-utils xf86-input-libinput xorg-xdpyinfo xorg-server xorg-xinit xorg-xinput xorg-xkill xorg-xrandr
pacman -Sy --asdeps --needed dhclient dnsmasq dnsutils ethtool iwd modemmanager networkmanager networkmanager-openvpn nss-mdns usb_modeswitch wpa_supplicant wireless-regdb xl2tpd dhcpcd
pacman -Sy --asdeps --needed ufw
pacman -Sy --asdeps --needed bluez bluez-hid2hci bluez-libs bluez-utils
pacman -Sy --asdeps --needed pacman-contrib pkgfile rebuild-detector reflector paru octopi
pacman -Sy --asdeps --needed accountsservice bash-completion ffmpegthumbnailer gst-libav gst-plugin-pipewire gst-plugins-bad gst-plugins-ugly libdvdcss libgsf libopenraw mlocate poppler-glib xdg-user-dirs xdg-utils
pacman -Sy --asdeps --needed efitools haveged nfs-utils nilfs-utils ntp smartmontools unrar unzip xz btrfs-assistant systemd-ukify
pacman -Sy --asdeps --needed alsa-firmware alsa-plugins alsa-utils pipewire-pulse wireplumber pipewire-alsa rtkit pipewire-jack
pacman -Sy --asdeps --needed dmidecode dmraid hdparm hwdetect lsscsi mtools sg3_utils sof-firmware linux-firmware
pacman -Sy --asdeps --needed cpupower upower tuned tuned-ppd
pacman -Sy --asdeps --needed alacritty btop duf findutils fsarchiver git glances hwinfo inxi nano-syntax-highlighting fastfetch pv python-defusedxml python-packaging rsync sed wget ripgrep nano vim openssh
pacman -Sy --asdeps --needed cachyos-nord-kde-theme-git cachyos-kde-settings cachyos-themes-sddm ark bluedevil breeze-gtk char-white dolphin egl-wayland gwenview konsole kate kdeconnect kde-gtk-config kdegraphics-thumbnailers kdeplasma-addons ffmpegthumbs kinfocenter kinit kscreen kwallet-pam kwalletmanager plasma-desktop libplasma plasma-nm plasma-pa plasma-workspace plasma-integration plasma-firewall plasma-browser-integration plasma-systemmonitor plasma-thunderbolt powerdevil spectacle sddm sddm-kcm qt6-wayland xsettingsd xdg-desktop-portal xdg-desktop-portal-kde phonon-qt6-vlc
pacman -Sy --asdeps --needed cups cups-filters cups-pdf foomatic-db foomatic-db-engine foomatic-db-gutenprint-ppds foomatic-db-nonfree foomatic-db-nonfree-ppds foomatic-db-ppds ghostscript gsfonts gutenprint splix system-config-printer
pacman -Sy --asdeps --needed hplip python-pyqt5 python-reportlab cups cups-filters cups-pdf
pacman -Sy --asdeps --needed espeak-ng mousetweaks orca

helix /etc/fstab
plymouth-set-default-theme cachyos

useradd -m -U -s /bin/zsh -c "Aubrey Carlson" -K UMASK=077 carlson
usermod -aG wheel,rfkill,sys,users,lp,video,network,storage,audio,brlapi carlson
chown -R carlson:carlson /home/carlson
passwd root
passwd carlson

cat << "EOF" | install -Dm640 /dev/stdin /etc/sudoers.d/carlson
Defaults    env_keep += "ftp_proxy http_proxy https_proxy no_proxy"
Defaults    env_keep += "EDITOR SUDO_EDITOR"
Defaults    env_keep += "LFS"

Defaults    insults
Defaults    pwfeedback

carlson     ALL=(ALL:ALL)   ALL
carlson     ALL=(ALL)       NOPASSWD:   /usr/bin/psd-overlay-helper
EOF

efibootmgr
bootctl install

systemctl enable NetworkManager.service
systemctl enable cups.service
systemctl enable avahi-daemon.service
systemctl enable systemd-timesyncd.service
systemctl enable ufw.service
systemctl enable sshd.service
systemctl enable bluetooth.service
systemctl enable sddm.service
systemctl enable tuned.service
systemctl enable tuned-ppd.service
systemctl enable systemd-boot-update.service
systemctl enable fstrim.timer
systemctl enable paccache.timer
systemctl enable pacman-filesdb-refresh.timer
systemctl enable pkgfile-update.timer
systemctl disable systemd-resolved.service
systemctl disable ananicy-cpp.service

runuser carlson -c "cp -v -rf /etc/skel/. /home/carlson/."
runuser carlson -c "rm -rvf /home/carlson/{.xsession,.xprofile,.xinitrc}"

ufw default deny incoming
ufw default allow outgoing
ufw default allow FORWARD
ufw enable

echo "Device not available" > /usr/lib/firmware/qat_420xx.bin
echo "Device not available" > /usr/lib/firmware/qat_420xx_mmp.bin

cat << "EOF" > /etc/mkinitcpio.conf.d/00-base_hooks.conf
HOOKS=(base systemd autodetect microcode modconf kms keyboard)
EOF
cat << "EOF" > /etc/mkinitcpio.conf.d/20-btrfs.conf
MODULES+=(btrfs crc32c-intel)
EOF
cat << "EOF" > /etc/mkinitcpio.conf.d/20-numlock.conf
#HOOKS+=(numlock)
EOF
cat << "EOF" > /etc/mkinitcpio.conf.d/20-plymouth.conf
HOOKS+=(plymouth)
EOF
cat << "EOF" > /etc/mkinitcpio.conf.d/20-systemd.conf
HOOKS+=(sd-vconsole sd-encrypt block filesystems fsck)
EOF
cat << "EOF" > /etc/mkinitcpio.conf.d/20-usb3hub.conf
MODULES+=(usbhid xhci_hcd)
EOF
cat << "EOF" > /etc/mkinitcpio.conf.d/30-compression.conf
COMPRESSION="zstd"
COMPRESSION_OPTIONS=(-v -c -T0 -9)
MODULES_DECOMPRESS="yes"
EOF

cat << "EOF" > /etc/sdboot-manage.conf.d/00-override_default.conf
LINUX_OPTIONS=""
EOF
cat << "EOF" > /etc/sdboot-manage.conf.d/10-luks.conf
LINUX_OPTIONS+="\
rd.luks.name=UUID=data \
rd.luks.name=UUID=lfs \
rd.luks.name=UUID=swap"
EOF
cat << "EOF" > /etc/sdboot-manage.conf.d/20-apparmor.conf
LINUX_OPTIONS+=" lsm=landlock,lockdown,yama,integrity,apparmor,bpf"
EOF
cat << "EOF" > /etc/sdboot-manage.conf.d/20-i915.conf
LINUX_OPTIONS+=" intel_iommu=on iommu=pt i915.enable_guc=3 i915.max_vfs=7 module_blacklist=xe"
EOF
cat << "EOF" > /etc/sdboot-manage.conf.d/20-resume.conf
LINUX_OPTIONS+=" resume=UUID=UUID zswap.enabled=0"
EOF
cat << "EOF" > /etc/sdboot-manage.conf.d/30-kdump.conf
LINUX_OPTIONS+=" crashkernel=512M"
EOF
cat << "EOF" > /etc/sdboot-manage.conf.d/30-plymouth.conf
LINUX_OPTIONS+=" splash plymouth.use-simpledrm"
EOF
cat << "EOF" > /etc/sdboot-manage.conf.d/30-silent_boot.conf
LINUX_OPTIONS+=" nowatchdog quiet loglevel=3 systemd.show_status=auto rd.udev.log_level=3"
EOF
cat << "EOF" > /etc/sdboot-manage.conf.d/30-tty_theme.conf
LINUX_OPTIONS+=" \
vt.default_red=30,243,166,249,137,245,148,186,88,243,166,249,137,245,148,166 \
vt.default_grn=30,139,227,226,180,194,226,194,91,139,227,226,180,194,226,173 \
vt.default_blu=46,168,161,175,250,231,213,222,112,168,161,175,250,231,213,200"
EOF

cat << "EOF" > /etc/NetworkManager/conf.d/dhcp-client.conf
[main]
dhcp=dhcpcd
EOF
cat << "EOF" > /etc/NetworkManager/conf.d/dns.conf
[main]
dns=dnsmasq
EOF
cat << "EOF" > /etc/NetworkManager/conf.d/duid.conf
[connection]
ipv6.dhcp-duid=stable-uuid
EOF
cat << "EOF" > /etc/NetworkManager/conf.d/wifi_backend.conf
[device]
wifi.backend=iwd
EOF
cat << "EOF" > /etc/NetworkManager/conf.d/wifi_rand_mac.conf
[device-mac-randomization]
# "yes" is already the default for scanning
wifi.scan-rand-mac-address=yes

[connection-mac-randomization]
# Randomize MAC for every ethernet connection
ethernet.cloned-mac-address=stable
# Generate a random MAC for each Wi-Fi and associate the two permanently.
wifi.cloned-mac-address=stable
EOF

cat << "EOF" > /etc/NetworkManager/dnsmasq.d/cache.conf
cache-size=4096
EOF
cat << "EOF" > /etc/NetworkManager/dnsmasq.d/listen.conf
listen-address=::1,127.0.0.1
EOF
cat << "EOF" > /etc/NetworkManager/dnsmasq.d/alidns-server.conf
# AliDNS Service Addresses & Features
# DOH https://dns.alidns.com/dns-query
# DOT tls://dns.alidns.com

# DNS Server
server=223.5.5.5
server=2400:3200::1

# DNS Server Fallback
server=223.6.6.6
server=2400:3200:baba::1
EOF

sed 's/#default_uki=\"\/efi\/EFI\/Linux\/arch-linux-cachyos.efi\"/default_uki=\"\/boot\/EFI\/Linux\/arch-linux-cachyos.efi.nouse\"/g' -i /etc/mkinitcpio.d/linux-cachyos.preset
sed 's/#default_options=\"--splash \/usr\/share\/systemd\/bootctl\/splash-arch.bmp\"/default_options=\"--splash \/usr\/share\/systemd\/bootctl\/splash-arch.bmp\"/g' -i /etc/mkinitcpio.d/linux-cachyos.preset
sed 's/#fallback_uki=\"\/efi\/EFI\/Linux\/arch-linux-cachyos-fallback.efi\"/fallback_uki=\"\/boot\/EFI\/Linux\/arch-linux-cachyos-fallback.efi.nouse\"/g' -i /etc/mkinitcpio.d/linux-cachyos.preset

sdboot-manage gen && mkinitcpio -P
```

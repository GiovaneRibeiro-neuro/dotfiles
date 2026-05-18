#!/bin/bash

## Install system packages
pacman -Syy alacritty hyprland fnott pipewire wireplumber \
    xdg-desktop-portal-hyprland hyprpolkitagent unzip pipewire-jack \
    ttf-input-nerd firefox docker docker-buildx docker-compose wget \
    the_silver_searcher tmux otf-font-awesome waybar noto-fonts \
    ttf-liberation bash-preexec ninja meson cmake nlohmann-json \
    qt6-base ffmpeg layer-shell-qt pkg-config

echo "Enable docker"
sudo systemctl enable docker.service
YOUR_USER=$USER
sudo usermod -aG docker $YOUR_USER

echo "Enable hyprland plugins"
hyprpm update
hyprpm add https://github.com/gfhdhytghd/HyprCapture
hyprpm enable hyprcapture
hyprpm reload

echo "Install AUR packages"
BASEDIR=$PWD
AUR_PACKAGES=(oguri-git informant) # informant deve ser o último elemento do array.
[ ! -d $HOME/.aur ] && mkdir -p $HOME/.aur
for item in "${AUR_PACKAGES[@]}"; do
    echo "Install: $item"
    if [ ! -d $HOME/.aur/$item ]; then
        git clone https://aur.archlinux.org/$item.git $HOME/.aur/$item
    fi
    cd $HOME/.aur/$item
    makepkg -s -i -r -c
    sudo pacman -U *.zst
done
cd $BASEDIR

# install common stuff
#common-setup.sh


#echo "Install arch dependencies"
#pgrep -x pacman > /dev/null && sudo pacman -Sy \
#    alacritty \                                                             # * alacritty: Terminal
#    bspwm sxhkd \                                                           # * bspwm/sxhkd: A window manager / keybindings
#    polybar \                                                               # * polybar: A top bar
#    feh \                                                                   # * feh: Handle wallpapers
#    autorandr \                                                             # * autorandr: Save multiple monitors configurations
#    xorg-xrandr \                                                           # * xorg-xrandr: makes possible multiple monitors
#    unzip \                                                                 # * unzip: unzip .zip packages
#    arandr \                                                                # * arandr: GUI for xrandr
#    blueman \                                                               # * blueman: GUI + applet for bluetooth service
#    gvim \                                                                  # * gvim : VIm with clipboard enabled
#    meld \                                                                  # * meld: winmerge-like tool
#    powerline \                                                             # * powerline: better fonts and emojis
#    tmux \                                                                  # * tmux: terminal sessions
#    xclip \                                                                 # * xclip: clipboard tool
#    qt5-base qt5-declarative qt5-tools \                                    # * dbus dependencies
#    gnupg \                                                                 # * encription keys
#    gnome-keyring libsecret seahorse \                                      # * Manage passwords
#    docker docker-buildx docker-compose \                                   # * container engine
#    rclone \                                                                # * cloud sync
#    vifm \                                                                  # * a vim-like file manager
#    cronie \                                                                # * cron
#    wget \
#    boinc \                                                                 # * Help scientific processing
#    rofi \                                                                  # * a powerful menu
#    ntfs-3g dosfstools exfatprogs \                                         # * drivers para gparted
#    gparted \                                                               # * GUI para gerenciamento de discos
#    the_silver_searcher \                                                   # * Better grep
#    # 
#
##
## OBS 
##
## 1) ao instalar o gnome-keyring, editar o serviço para adicionar os parametros ssh e gpg ao daemon. O arquivo a ser editado é: /usr/lib/systemd/user/gnome-keyring-daemon.service. Após isso, reiniciar
## o systemd e reiniciar o serviço ($ systemctl start --user gnome-keyring-daemon)
## 
#

#

#
#wget https://raw.githubusercontent.com/fiskhest/sxhkd-helper-menu/master/sxhkhm/__init__.py -O ${HOME}/.local/bin/hkhelper.py
#chmod +x .local/bin/hkhelper.py
#
#echo "Load systemctl scripts"
## according to this link, https://stackoverflow.com/questions/78422507/vs-code-github-auth-not-working-on-linux-due-to-gnome-environment-os-keyring-err, edit gnome-keyring-daemon.service file to add
## ssh and gpg components in ExecStart line:
#systemctl --user status gnome-keyring-daemon.service
#systemctl --user daemon-reexec
##systemctl --user enable --now rclone-sync@songbook.timer
##systemctl --user start --now rclone-sync@songbook.timer
#systemctl --user restart gnome-keyring-daemon.service
#sudo systemctl start cronie
#sudo systemctl enable cronie


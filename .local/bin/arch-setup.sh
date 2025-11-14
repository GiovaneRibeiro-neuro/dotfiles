#!/bin/bash

echo "Install arch dependencies"
pgrep -x pacman > /dev/null && sudo pacman -Sy \
    llvm-libs \                                                             # * llvm-utils: OpenCL libraries
    mesa \                                                                  # * mesa: Video driver
    alacritty \                                                             # * alacritty: Terminal
    bspwm sxhkd \                                                           # * bspwm/sxhkd: A window manager / keybindings
    polybar \                                                               # * polybar: A top bar
    feh \                                                                   # * feh: Handle wallpapers
    autorandr \                                                             # * autorandr: Save multiple monitors configurations
    xorg-xrandr \                                                           # * xorg-xrandr: makes possible multiple monitors
    unzip \                                                                 # * unzip: unzip .zip packages
    arandr \                                                                # * arandr: GUI for xrandr
    blueman \                                                               # * blueman: GUI + applet for bluetooth service
    gvim \                                                                  # * gvim : VIm with clipboard enabled
    meld \                                                                  # * meld: winmerge-like tool
    powerline \                                                             # * powerline: better fonts and emojis
    tmux \                                                                  # * tmux: terminal sessions
    xclip \                                                                 # * xclip: clipboard tool
    qt5-base qt5-declarative qt5-tools \                                    # * dbus dependencies
    gnupg \                                                                 # * encription keys
    gnome-keyring libsecret seahorse \                                      # * Manage passwords
    docker docker-buildx docker-compose \                                   # * container engine
    rclone \                                                                # * cloud sync
    vifm \                                                                  # * a vim-like file manager
    cronie \                                                                # * cron
    wget \
    boinc \                                                                 # * Help scientific processing
    rofi \                                                                  # * a powerful menu
    ntfs-3g dosfstools exfatprogs \                                         # * drivers para gparted
    gparted \                                                               # * GUI para gerenciamento de discos
    # 

#
# OBS 
#
# 1) ao instalar o gnome-keyring, editar o serviço para adicionar os parametros ssh e gpg ao daemon. O arquivo a ser editado é: /usr/lib/systemd/user/gnome-keyring-daemon.service. Após isso, reiniciar
# o systemd e reiniciar o serviço ($ systemctl start --user gnome-keyring-daemon)
# 

echo "Install AUR packages"
[ ! -d $HOME/.aur ] && mkdir -p $HOME/.aur
AUR_PACKAGES=(google-chrome informant iwgtk visual-studio-code-bin gridcoinresearch)

echo "Enable docker"
sudo systemctl enable docker.service
YOUR_USER=$USER
sudo usermod -aG docker $YOUR_USER

wget https://raw.githubusercontent.com/fiskhest/sxhkd-helper-menu/master/sxhkhm/__init__.py -O ${HOME}/.local/bin/hkhelper.py
chmod +x .local/bin/hkhelper.py

echo "Load systemctl scripts"
# according to this link, https://stackoverflow.com/questions/78422507/vs-code-github-auth-not-working-on-linux-due-to-gnome-environment-os-keyring-err, edit gnome-keyring-daemon.service file to add
# ssh and gpg components in ExecStart line:
systemctl --user status gnome-keyring-daemon.service
systemctl --user daemon-reexec
#systemctl --user enable --now rclone-sync@songbook.timer
#systemctl --user start --now rclone-sync@songbook.timer
systemctl --user restart gnome-keyring-daemon.service
sudo systemctl start cronie
sudo systemctl enable cronie

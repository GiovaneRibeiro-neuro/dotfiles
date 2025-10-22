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

echo "Install Vundle (vim plugin) and install vim plugins"
[ ! -d $HOME/.vim/sessions ] && mkdir -p $HOME/.vim/sessions
[ ! -d $HOME/.vim/bundle ] && mkdir -p $HOME/.vim/bundle
git clone https://github.com/gmarik/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim/
vim +PluginInstall +qall

echo "Install oh-my-tmux"
[ ! -d $HOME/.config/tmux ] && mkdir -p $HOME/.config/tmux
git clone https://github.com/gpakosz/.tmux $HOME/.config/tmux/
ln -sf $HOME/.config/tmux/.tmux.conf $HOME/.tmux.conf

echo "Enable docker"
sudo systemctl enable docker.service
YOUR_USER=$USER
sudo usermod -aG docker $YOUR_USER

wget https://raw.githubusercontent.com/fiskhest/sxhkd-helper-menu/master/sxhkhm/__init__.py -O ${HOME}/.local/bin/hkhelper.py
chmod +x .local/bin/hkhelper.py

echo "Restore rclone backup (first, import the correct GPG key)"
gpg -o $HOME/.config/rclone/rclone.conf -d $HOME/.config/rclone/rclone.conf.bkp

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

echo "Install frameworks"
nvm install 22
sdk install java


#echo "Install devcontainer cli"
#npm -g @devcontainers/cli
#
#echo "Install aws cli"
#curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
#unzip awscliv2.zip
#sudo ./aws/install
#rm -rf ./aws
#rm awscliv2.zip

echo "Install Github CLI"
(type -p wget >/dev/null || (sudo apt update && sudo apt install wget -y)) \
	&& sudo mkdir -p -m 755 /etc/apt/keyrings \
	&& out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
	&& cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
	&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
	&& sudo mkdir -p -m 755 /etc/apt/sources.list.d \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& sudo apt update \
	&& sudo apt install gh -y

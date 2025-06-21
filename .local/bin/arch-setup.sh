#!/bin/bash

echo "Install arch dependencies"
pgrep -x pacman > /dev/null && sudo pacman -Sy \
    llvm-libs \                             # * llvm-utils: OpenCL libraries
    mesa \                                  # * mesa: Video driver
    alacritty \                             # * alacritty: Terminal
    bspwm sxhkd \                           # * bspwm/sxhkd: A window manager / keybindings
    polybar \                               # * polybar: A top bar
    feh \                                   # * feh: Handle wallpapers
    autorandr \                             # * autorandr: Save multiple monitors configurations
    xorg-xrandr \                           # * xorg-xrandr: makes possible multiple monitors
    unzip \                                 # * unzip: unzip .zip packages
    arandr \                                # * arandr: GUI for xrandr
    blueman \                               # * blueman: GUI + applet for bluetooth service
    gvim \                                  # * gvim : VIm with clipboard enabled
    meld \                                  # * meld: winmerge-like tool
    powerline \                             # * powerline: better fonts and emojis
    tmux \                                  # * tmux: terminal sessions
    ttf-font-awesome \                      # * ttf-font-awesome: font awesome
    xclip \                                 # * xclip: clipboard tool
    qt5-base qt5-declarative qt5-tools \    # * dbus dependencies
    gnupg \                                 # * encription keys
    kwallet \                               # * Manage passwords
    ksshaskpass \                           # * credential helper for kwallet
    docker docker-buildx docker-compose \   # * container engine
    python-gpgme \                          # * needed for dropbox
    rclone \                                # * cloud sync
    # 

# import dropbox key
gpg --recv-keys FC918B335044912E

echo "Install AUR packages"
[ ! -d $HOME/.aur ] && mkdir -p $HOME/.aur
AUR_PACKAGES=(dropbox google-chrome informant iwgtk visual-studio-code-bin)

echo "Install Vundle (vim plugin) and install vim plugins"
[ ! -d $HOME/.vim/sessions ] && mkdir -p $HOME/.vim/sessions
[ ! -d $HOME/.vim/bundle ] && mkdir -p $HOME/.vim/bundle
git clone https://github.com/gmarik/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim/
vim +PluginInstall +qall

echo "Install oh-my-tmux"
[ ! -d $HOME/.config/tmux ] && mkdir -p $HOME/.config/tmux
git clone https://github.com/gpakosz/.tmux $HOME/.config/tmux/
ln -sf $HOME/.config/tmux/.tmux.conf $HOME/.tmux.conf

echo "Some extra configs"
sudo systemctl enable docker.service
YOUR_USER=$USER
sudo usermod -aG docker $YOUR_USER


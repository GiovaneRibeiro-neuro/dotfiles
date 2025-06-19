#!/bin/bash

echo "Install arch dependencies"
# * llvm-utils: OpenCL libraries
# * mesa: Video driver
# * alacritty: Terminal 
# * bspwm/sxhkd: A window manager / keybindings
# * polybar: A top bar
# * feh: Handle wallpapers
# * autorandr: Save multiple monitors configurations
# * xorg-xrandr: makes possible multiple monitors
# * unzip: unzip .zip packages  
# * arandr: GUI for xrandr
# * blueman: GUI + applet for bluetooth service 
# * gvim : VIm with clipboard enabled
# * meld: winmerge-like tool 
# * powerline: better fonts and emojis
# * tmux: terminal sessions
pgrep -x pacman > /dev/null && sudo pacman -Sy llvm-libs mesa rust alacritty bspwm sxhkd polybar feh autorandr xorg-xrandr unzip arandr blueman gvim meld powerline tmux

echo "Install Vundle (vim plugin) and install vim plugins"
[ ! -d $HOME/.vim/sessions ] && mkdir -p $HOME/.vim/sessions
[ ! -d $HOME/.vim/bundle ] && mkdir -p $HOME/.vim/bundle
git clone https://github.com/gmarik/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim/
vim +PluginInstall +qall

echo "Install oh-my-tmux"
[ ! -d $HOME/.config/tmux ] && mkdir -p $HOME/.config/tmux
git clone https://github.com/gpakosz/.tmux $HOME/.config/tmux/
ln -sf $HOME/.config/tmux/.tmux.conf $HOME/.tmux.conf

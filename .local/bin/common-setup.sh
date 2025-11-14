#!/bin/bash

echo "Install Vundle (vim plugin) and install vim plugins"
[ ! -d $HOME/.vim/sessions ] && mkdir -p $HOME/.vim/sessions
[ ! -d $HOME/.vim/bundle ] && mkdir -p $HOME/.vim/bundle
git clone https://github.com/gmarik/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim/
vim +PluginInstall +qall

echo "Install oh-my-tmux"
[ ! -d $HOME/.config/tmux ] && mkdir -p $HOME/.config/tmux
git clone https://github.com/gpakosz/.tmux $HOME/.config/tmux/
ln -sf $HOME/.config/tmux/.tmux.conf $HOME/.tmux.conf

echo "Restore rclone backup (first, import the correct GPG key)"
gpg -o $HOME/.config/rclone/rclone.conf.bkp -d $HOME/.config/rclone/rclone.conf

echo "Install frameworks"
nvm install 22
sdk install java

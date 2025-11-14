#!/bin/bash

echo "## Atualizando plugins do VIm"
vim +PluginUpdate +qall

echo "## Atualizando oh-my-tmux"
cd $HOME/.config/tmux
git pull

#!/bin/bash

echo "## Upgrade system"
sudo pacman -Syu

echo "## Checking for updates on AUR packages"
dir=$HOME/.aur

for file in $dir/*/ ; do
    filename=$(basename "$file")

    cd $dir/$filename
    git pull | grep "Already up to date" > /dev/null
    if [ "$?" == "0" ]; then
	    echo "* $filename... OK"
    else
	    echo "* Start $filename updates"
	    makepkg -sirc
    fi
    cd $dir
done

echo "## Atualizando plugins do VIm"
vim +PluginUpdate +qall

echo "## Atualizando oh-my-tmux"
cd $HOME/.config/tmux
git pull

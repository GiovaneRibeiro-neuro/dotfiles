#!/bin/bash

echo "Install ubuntu dependencies"

sudo apt update
sudo apt install -y vim-gtk3               # vim (com clipboard)
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install -y ca-certificates curl apt-transport-https gnupg
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo snap install alacritty --classic       # emulador de terminal
sudo snap install obsidian --classic        # obsidian
sudo apt install tmux                       # terminal session manager
#sudo apt install tesseract-ocr

echo "Install kubectl"
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
sudo chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo chmod 644 /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl

echo "Install Vundle (vim plugin) and install vim plugins"
[ ! -d $HOME/.vim/sessions ] && mkdir -p $HOME/.vim/sessions
[ ! -d $HOME/.vim/bundle ] && mkdir -p $HOME/.vim/bundle
git clone https://github.com/gmarik/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim/
vim +PluginInstall +qall

echo "Install oh-my-tmux"
[ ! -d $HOME/.config/tmux ] && mkdir -p $HOME/.config/tmux
git clone https://github.com/gpakosz/.tmux $HOME/.config/tmux/
ln -sf $HOME/.config/tmux/.tmux.conf $HOME/.tmux.conf

echo "Install frameworks"
nvm install 22
sdk install java

echo "Install other tools"
npm install -g @anthropic-ai/claude-code

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

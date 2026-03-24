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
sdk install maven
sudo apt install golang-go
curl -sSfL https://golangci-lint.run/install.sh | sh -s -- -b $(go env GOPATH)/bin v2.9.0

echo "Install other tools"
npm install -g @anthropic-ai/claude-code

#echo "Install kubectl"
#curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
#sudo chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg
#echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
#sudo chmod 644 /etc/apt/sources.list.d/kubernetes.list
#sudo apt-get update
#sudo apt-get install -y kubectl

echo "Install kind"
# For AMD64 / x86_64
[ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.31.0/kind-linux-amd64
# For ARM64
[ $(uname -m) = aarch64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.31.0/kind-linux-arm64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

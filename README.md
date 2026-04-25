# dotfiles
My dotfiles and scripts to make my life easier. Works on zsh or bash. Strongly inspired on [this](https://github.com/davidsonfellipe/dotfiles) project (Thanks Davidson!! :D) and [this](https://www.atlassian.com/git/tutorials/dotfiles) link. For the Claude Code part, I use many scripts, resources and agents adapted from [here](https://github.com/affaan-m/everything-claude-code/tree/main).

## Pre-requisites

* libc and other build libraries (build-essential in ubuntu or base-devel in arch)
* cURL
* go (`rm -rf /usr/local/go && tar -C /usr/local -xzf go1.26.2.linux-amd64.tar.gz`)

Just make sure that your ssh agent is configured correctly before start:

```bash
$ cat ~/.ssh/id_rsa # if not present, create one and import the public key on your github account
$ ls ~/.ssh # if key is present (something like id_ed25519), jump the next 3 commands
$ ssh-keygen -t ed25519 -C "seu_email@example.com"
$ eval "$(ssh-agent -s)"
$ ssh-add ~/.ssh/id_ed25519
#... and add the public key to your github account
```

## Some available configurations

* [alacritty](https://github.com/giovanebribeiro/dotfiles/tree/master/.config/alacritty/alacritty.toml)
* [polybar](https://github.com/giovanebribeiro/dotfiles/tree/master/.config/polybar/config.ini)
* [picom](https://github.com/giovanebribeiro/dotfiles/tree/master/.config/picom/config.ini)
* [bspwm](https://github.com/giovanebribeiro/dotfiles/tree/master/.config/bspwm/bspwmrc)/[sxhkd](https://github.com/giovanebribeiro/dotfiles/tree/master/.config/sxhkd/sxhkdrc)
* [rofi](https://github.com/giovanebribeiro/dotfiles/tree/master/.config/rofi/config.rasi)

## How can I use it?

Just run this line in your home folder:

```
curl -o- https://raw.githubusercontent.com/giovanebribeiro/dotfiles/master/cfg-install | /bin/bash
```

After the installation, reboot (or open a new terminal to load the correct .zshrc) and if you are on arch, run the setup script:

```
$ arch-setup.sh
```

If something changes, to save them on this repo, just type:
```bash
# if is a new file
$ cfg add $HOME/path/to/file
# commit changes
$ cfg commit -am "lorem ipsum"
# push to repo
$ cfg push
```

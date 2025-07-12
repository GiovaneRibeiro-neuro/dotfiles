# dotfiles
My dotfiles and scripts to make my life easier. Works on zsh or bash. Strongly inspired on [this](https://github.com/davidsonfellipe/dotfiles) project (Thanks Davidson!! :D) and [this](https://www.atlassian.com/git/tutorials/dotfiles) link.

## Pre-requisites

* rust (more specifically, cargo)
* nvm (and the most recent Node.JS)
* nerd-fonts (More specifically, ttf-font-awesome; ttf-jetbrains-mono-nerd; ttf-nerd-fonts-symbols)
* libc e outras bibliotecas de compilação (build-essential in ubuntu ou base-devel in arch)

## Available configurations

* [alacritty](https://github.com/giovanebribeiro/dotfiles/tree/master/.config/alacritty/alacritty.toml)
* [polybar](https://github.com/giovanebribeiro/dotfiles/tree/master/.config/polybar/config.ini)
* [picom](https://github.com/giovanebribeiro/dotfiles/tree/master/.config/picom/config.ini)
* [bspwm](https://github.com/giovanebribeiro/dotfiles/tree/master/.config/bspwm/bspwmrc)/[sxhkd](https://github.com/giovanebribeiro/dotfiles/tree/master/.config/sxhkd/sxhkdrc)

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



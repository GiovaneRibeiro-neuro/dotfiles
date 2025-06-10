# dotfiles
My dotfiles and scripts to make my life easier. Works on MacOSX and Linux. Strongly inspired on [this](https://github.com/davidsonfellipe/dotfiles) project (Thanks Davidson!! :D) and [this](https://www.atlassian.com/git/tutorials/dotfiles) link.

## How can I use it?

Just run this line (For now, only valid for Arch Linux):

```
$ curl -o- https://raw.githubusercontent.com/giovanebribeiro/dotfiles/v1.0.0/cfg-install | /bin/bash
```

```
$ ./dot -h
Usage: ./dot [options] <action> <module>

   <action> means: What do you want to do? (install or uninstall)
   <module> means: The folder to be installed/uninstalled

   Options:
   h      Print this help
   v      Enable verbose
```

## Available modules (install and configurations)

* git
* markdown
* polybar (dependency: papirus icon theme)
* rofi
* vim
* ctags
* node
* rust
* tmux


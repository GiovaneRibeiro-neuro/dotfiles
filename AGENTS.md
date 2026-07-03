# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repository is

This is a personal dotfiles repository for an Arch Linux / Hyprland desktop setup. Files are tracked using a **bare git repo** at `~/.cfg` with a `cfg` alias, not a conventional git repo. The working tree is `$HOME`.

## Managing dotfiles

All git operations use `cfg` instead of `git`:

```bash
cfg status
cfg add $HOME/path/to/file
cfg commit -m "chore: add new config"
cfg push
```

`cfg` is defined as:
```bash
/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME
```

Untracked files are hidden by default (`status.showUntrackedFiles no`). Use `cfg ls-files` to see what is tracked.

## Setup scripts

| Script | Purpose |
|--------|---------|
| `cfg-install` | Bootstrap: clones bare repo and installs dotshell |
| `~/.local/bin/arch-setup.sh` | Arch-specific: pacman packages, AUR, systemd services, hyprland plugins |
| `~/.local/bin/common-setup.sh` | Cross-distro: vim plugins (Vundle), oh-my-tmux, rclone GPG restore |
| `~/.local/bin/common-update.sh` | Update toolchain (nvm, sdkman, rust, etc.) |
| `~/.local/bin/upgrade.sh` | System upgrade wrapper |

## Key components tracked

- **Window manager**: Hyprland (`.config/hypr/`) — config split into `hyprland.lua`, `inputs.lua`, `outputs.lua`
- **Status bars**: Waybar (`.config/waybar/`) and Quickshell (`.config/quickshell/`) — Quickshell uses QML
- **Shell**: `.dotshell/` is a separate git repo cloned at install time; `.bashrc`/`.zshrc` are symlinks into it
- **Terminal**: Alacritty (`.config/alacritty/`)
- **Multiplexer**: oh-my-tmux cloned at `~/.config/tmux/`; local overrides in `.tmux.conf.local`
- **Editor**: Vim with Vundle (`.vimrc`, plugins installed via `vim +PluginInstall +qall`)
- **Cloud sync**: rclone — config is GPG-encrypted at `.config/rclone/rclone.conf.bkp`; decrypt before use
- **Sync service**: systemd user units at `.config/systemd/user/rclone-sync@*`

## Shell config architecture

`.dotshell/` (separate repo at `~/.dotshell`) provides `.bashrc`, `.zshrc`, and `.sh_common`. These are symlinked into `$HOME`. The file `~/.dotshellrc` stores the path to the cloned dotshell directory.

Changes to shell config belong in the dotshell repo, not this one. Changes to everything else belong here.

## Language runtimes

All runtimes are user-local, managed by:
- **Node.js**: nvm (`~/.nvm`)
- **Java/JVM**: sdkman (`~/.sdkman`)
- **Python**: uv (`~/.cargo/bin/uv`)
- **Rust**: rustup (`~/.rustup`)
- **Go**: system package + `~/go` workspace

## Claude Code configuration

`~/.claude/` is excluded from this repo (via `.claudeignore`). Global Claude conventions live in `~/.claude/CLAUDE.md`.

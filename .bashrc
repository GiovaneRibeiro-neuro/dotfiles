# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

## Useful variables
OS=`uname`
BIN_FOLDER=$HOME/.local/bin

# If not running interactively, don't do anything
case $- in
   *i*) ;;
     *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
   debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
   xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
   if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
   # We have color support; assume it's compliant with Ecma-48
   # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
   # a case would tend to support setf rather than setaf.)
   color_prompt=yes
   else
   color_prompt=
   fi
fi

if [ "$color_prompt" = yes ]; then
   PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
   PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
   PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
   ;;
*)
   ;;
esac



# Complements
# You may want to put all your additions into a separate file like
# ~/.my_bash_complements, instead of adding them here directly.
if [ -f /workspace/.devcontainer/my_bash_complements ]; then
   . /workspace/.devcontainer/my_bash_complements
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
 if [ -f /usr/share/bash-completion/bash_completion ]; then
   . /usr/share/bash-completion/bash_completion
 elif [ -f /etc/bash_completion ]; then
   . /etc/bash_completion
 fi
fi

############
### APPS ###
############

source "$HOME/.shell-apps"

#############
### ALIAS ###
#############

test alias f5 > /dev/null 2>&1 || alias f5='source $HOME/.bashrc'
source "$HOME/.shell-aliases"


###############
### EXPORTS ###
###############

source "$HOME/.shell-functions"

if [ -f /workspace/.devcontainer/.env ]; then
    set -a && source /workspace/.devcontainer/.env && set +a
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

#################
### FUNCTIONS ###
#################

source "$HOME/.shell-functions"


# bash theme - partly inspired by https://github.com/ohmyzsh/ohmyzsh/blob/master/themes/robbyrussell.zsh-theme
__bash_prompt() {
   local userpart='`export XIT=$? \
       && [ ! -z "${GITHUB_USER:-}" ] && echo -n "\[\033[0;32m\]@${GITHUB_USER:-} " || echo -n "\[\033[0;32m\]\u " \
       && [ "$XIT" -ne "0" ] && echo -n "\[\033[1;31m\]➜" || echo -n "\[\033[0m\]➜"`'
   local gitbranch='`\
       if [ "$(git config --get devcontainers-theme.hide-status 2>/dev/null)" != 1 ] && [ "$(git config --get codespaces-theme.hide-status 2>/dev/null)" != 1 ]; then \
           export BRANCH="$(git --no-optional-locks symbolic-ref --short HEAD 2>/dev/null || git --no-optional-locks rev-parse --short HEAD 2>/dev/null)"; \
           if [ "${BRANCH:-}" != "" ]; then \
               echo -n "\[\033[0;36m\](\[\033[1;31m\]${BRANCH:-}" \
               && if [ "$(git config --get devcontainers-theme.show-dirty 2>/dev/null)" = 1 ] && \
                   git --no-optional-locks ls-files --error-unmatch -m --directory --no-empty-directory -o --exclude-standard ":/*" > /dev/null 2>&1; then \
                       echo -n " \[\033[1;33m\]✗"; \
               fi \
               && echo -n "\[\033[0;36m\]) "; \
           fi; \
       fi`'
   local lightblue='\[\033[1;34m\]'
   local removecolor='\[\033[0m\]'
   PS1="${userpart} ${lightblue}\w ${gitbranch}${removecolor}\$ "
   unset -f __bash_prompt
}



__bash_prompt
export PROMPT_DIRTRIM=4




























autoload -Uz tetriscurses

## Useful variables
OS=`uname`
BIN_FOLDER=$HOME/.local/bin
# History
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh_history

# Load typewritten theme
if [ ! -d $HOME/.zsh/typewritten ]; then
   mkdir -p $HOME/.zsh
   git clone https://github.com/reobin/typewritten.git "$HOME/.zsh/typewritten"
fi
fpath+=$HOME/.zsh/typewritten
autoload -U promptinit; promptinit
prompt typewritten

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

##
# USEFUL APPS
##

# bottom - a better top
if [ ! -f $HOME/.cargo/bin/btm ]; then
    cargo install -f --git https://github.com/ClementTsang/bottom bottom
fi
test alias oldtop >/dev/null 2>&1 || alias oldtop='/usr/bin/top'
test alias top >/dev/null 2>&1 || alias top='btm --theme gruvbox'

# Use lf to switch directories and bind it to ctrl-o
# Source: https://gist.github.com/LukeSmithxyz/e62f26e55ea8b0ed41a65912fbebbe52
lfcd () {
    
    if [ ! -f "$BIN_FOLDER/lf" ]; then
        BASEDIR=`pwd`
        cd $BIN_FOLDER

        file=lf-linux-amd64.tar.gz
        if [ "$OS" = "Darwin" ]; then
            file=lf-darwin-amd64.tar.gz
        fi 

        wget https://github.com/gokcehan/lf/releases/download/r14/$file
        tar -zxvf $file
        rm $file
        mkdir -p ~/.config/lf
        curl https://raw.githubusercontent.com/gokcehan/lf/master/etc/lfrc.example -o ~/.config/lf/lfrc
        cd $BASEDIR
    fi

    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

# fetch (using treefetch, and change it to a christmas tree when time comes)
fetch() {

    if [ "$OS" = "Darwin" ]; then

        if [ ! -f "$BIN_FOLDER/pfetch"  ]; then
            BASEDIR=`pwd`
            cd /tmp

            wget https://github.com/dylanaraps/pfetch/archive/master.zip
            unzip master.zip
            install pfetch-master/pfetch $BIN_FOLDER/
            ls -l $BIN_FOLDER/pfetch

            cd $BASEDIR
        fi

        pfetch
        exit 0
    fi

    if ! which treefetch &>/dev/null; then
        cargo install -f --git https://github.com/angelofallars/treefetch treefetch
    fi

    advent.sh # run the script to check if we are in advent
    advent_file=/tmp/advento.txt

    if [ ! -f $advent_file ]; then
        treefetch --bonsai
    else
        treefetch --xmas
    fi

}

##
# FUNCTIONS
##

# For some themes which cursor is underline, when exit vim the cursor becomes a box. This function
# fix this error
_fix_cursor() {
  echo -ne '\e[3 q'
}
precmd_functions+=(_fix_cursor)

# test later
#changeMac(){
#  local mac=$(openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//')
#  sudo ifconfig en0 ether $mac
#  sudo ifconfig en0 down
#  sudo ifconfig en0 up
#  echo "Your new physical address is $mac"
#
#  #unlimited wi-fi?
#}

aws-login() {

    if ! which aws &>/dev/null; then
	    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip"
	    cd /tmp
	    unzip awscliv2.zip
	    sudo ./aws/install
	    cd $HOME
    fi
    
    SSO_SESSION_NAME=""
    [ -z $AWS_SSO_SESSION_NAME ] && SSO_SESSION_NAME="--sso-session $AWS_SSO_SESSION_NAME"

    PROFILE=default
    [ -n "$1" ] && PROFILE=$1

    if command -v aws >/dev/null 2>&1
    then
        aws sts get-caller-identity &> /dev/null
        EXIT_CODE="$?"
        if [ $EXIT_CODE != 0 ]; then
            aws sso login $SSO_SESSION_NAME
        fi

        aws configure export-credentials --profile $PROFILE --format env-no-export
    fi

}

#FUNCTIONS per OS
[ -f "$HOME/.functions" ] && source "$HOME/.functions" &>/dev/null

##
# ALIASES
##

# General Aliases
test alias cfg > /dev/null 2>&1 || alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias up='arch-update.sh'
alias tmux='tmux -u2'
alias ..='cd ..'
alias la='ls -la'
alias ll='ls -l'
alias clima='curl v2.wttr.in'
alias keygen='ssh-keygen -b 7168 -t rsa'
alias ps='ps aux'
alias f5='source $HOME/.zshrc'
alias tetris='tetriscurses'
alias bye='sudo shutdown -h now'
alias cal='cal -3'
alias myip='curl ipinfo.io/ip'
alias net='netstat -tlnp'
alias untar='tar -zxvf'
# Permite a extração do Dockerfile de uma determinada imagem
# exemplo de uso: dfimage -sV=1.36 nginx:latest
alias dfimage="docker run -v /var/run/docker.sock:/var/run/docker.sock --rm alpine/dfimage -sV=1.36"
test alias wiki >/dev/null 2>&1 || alias wiki='cd $HOME/workspace/wiki && git pull && obsidian && git commit -am "wiki updates (notebook)" && git push'

# ALIASES per OS
[ -f "$HOME/.aliases" ] && source "$HOME/.aliases" &>/dev/null

##
# EXPORTS
##

# General exports
export NODE_ENV="development"
export PATH="$HOME/.cargo/bin:$BIN_FOLDER:$PATH"
export EDITOR=vim
export TMPDIR=/tmp

#EXPORTS per OS
[ -f "$HOME/.exports" ] && source "$HOME/.exports" &>/dev/null

##
# OTHER USEFUL STUFF... OR NOT...
##

#EXPORTS per OS
[ -f "$HOME/.others" ] && source "$HOME/.others" &>/dev/null

flag_file="/tmp/flag_file"
if [ ! -f $flag_file ]
then
  command -v fetch >/dev/null 2>&1 && { fetch; echo ; touch $flag_file ; }
  # only works if informant is installed (installed via AUR)
  command -v informant > /dev/null 2>&1 && { informant list --unread --file $HOME/.cache/informant.dat; echo; }
fi

fpath+=${ZDOTDIR:-~}/.zsh_functions

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

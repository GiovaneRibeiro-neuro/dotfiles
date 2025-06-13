#!/bin/bash

echo "Install arch dependencies"
# * llvm-utils: OpenCL libraries
# * mesa: Video driver
# * alacritty: Terminal 
# * bspwm/sxhkd: A window manager / keybindings
# * polybar: A top bar
# * feh: Handle wallpapers
# * autorandr: Save multiple monitors configurations
# * xorg-xrandr: makes possible multiple monitors
# * unzip: unzip .zip packages  
# * arandr: GUI for xrandr
# * blueman: GUI + applet for bluetooth service 
pgrep -x pacman > /dev/null && sudo pacman -Sy llvm-libs mesa rust alacritty bspwm sxhkd polybar feh autorandr xorg-xrandr unzip arandr blueman

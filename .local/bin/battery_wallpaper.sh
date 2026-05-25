#!/bin/bash

#
# battery_wallpaper.sh
#
# Uses acpi to check battery status, and change wallpaper accordingly
#
# Dependencies: acpi, hyprpaper
# To use this script, create the following crontab line:
#
#

while true; do
    # if battery is full, set wp to full
    acpi -b | grep -P -o 'Full'
    if [ $? -eq 0 ]; then
        hyprctl hyprpaper wallpaper ', ~/.config/wallpapers/cup_dark/Full.png'
    else
        #notify-send "bat not full"
        acpi -b | grep -P -o 'Discharging'
        if [ $? -eq 0 ]; then
            #notify-send "bat discharging"
            bat_level=`acpi -b | grep -P -o '[0-9]+(?=%)'`
            ((bat_level >= 6 && bat_level <= 10)) && hyprctl hyprpaper wallpaper ', ~/.config/wallpapers/cup_dark/0.png'
            ((bat_level >= 11 && bat_level <= 25)) && hyprctl hyprpaper wallpaper ', ~/.config/wallpapers/cup_dark/2.png'
            ((bat_level >= 26 && bat_level <= 50)) && hyprctl hyprpaper wallpaper ', ~/.config/wallpapers/cup_dark/4.png'
            ((bat_level >= 51 && bat_level <= 75)) && hyprctl hyprpaper wallpaper ', ~/.config/wallpapers/cup_dark/6.png'
            ((bat_level >= 76 && bat_level <= 95)) && hyprctl hyprpaper wallpaper ', ~/.config/wallpapers/cup_dark/8.png'
            ((bat_level >= 96 && bat_level <= 100)) && hyprctl hyprpaper wallpaper ', ~/.config/wallpapers/cup_dark/Full.png'
        else
            #notify-send "bat charging"
            i=0
            while true
            do
                i=$(( (i + 1) % 10 ))
                if (( (i % 2) == 0 )); then
                    hyprctl hyprpaper wallpaper ", ~/.config/wallpapers/cup_dark/$i.png"
                fi
                acpi -b | grep -P -o 'Discharging'
                [ $? -eq 0 ] && break # if the state comeback to Discharging 
                acpi -b | grep -P -o 'Full'
                if [ $? -eq 0 ]; then
                    hyprctl hyprpaper wallpaper ', ~/.config/wallpapers/cup_dark/Full.png'; break # if the state returns to full
                fi
                sleep 0.5
            done
        fi
    fi
    
    sleep 60
done

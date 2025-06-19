#!/bin/bash

intern=LVDS1
extern=HDMI1

if xrandr | grep "$extern disconected"; then
	xrandr --output "$extern" --off --output "$intern" --auto
else
	xrandr --output "$intern" --off --output "$extern" --auto
	# To leave the default monitor enabled when external monitor is connected, use thos line instead
	#xrandr --output "$intern" --primary --auto --output "$extern" --left-of "$intern" --auto
fi

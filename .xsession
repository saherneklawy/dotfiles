#!/bin/bash
 
# Load resources
 
xrdb -merge .Xresources

xbindkeys
 
# Set up an icon tray
trayer --edge top --align right --SetDockType true --SetPartialStrut true  --expand true --width 5 --transparent true --tint 0x000000 --alpha 0 --height 19 --padding 5 &

nm-applet &

gnome-screensaver &

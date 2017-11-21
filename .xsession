#!/bin/bash
 
# Load resources
 
xrdb -merge .Xresources

xbindkeys
 
# Set up an icon tray
trayer --edge top --align right --SetDockType true --SetPartialStrut true  --expand true --width 5 --transparent true --tint 0x000000 --alpha 0 --height 19 --padding 5 &

nm-applet &

gnome-screensaver &

# source http://www.linuxquestions.org/questions/arch-29/screen-goes-blank-after-ten-minutes-in-lxde-how-to-change-this-769000/
# turn off default screensaver
xset s off

xrandr --newmode "1600x900_60.00"  118.25  1600 1696 1856 2112  900 903 908 934 -hsync +vsync
xrandr --addmode VGA1 1600x900_60.00
xrandr --addmode DP1 1600x900_60.00
xrandr --addmode HDMI1 1600x900_60.00

xrandr --newmode "2560x1600_60.00"  348.50  2560 2760 3032 3504  1600 1603 1609 1658 -hsync +vsync
xrandr --addmode DP1 2560x1600_60.00

xrandr --newmode "1920x1200_60.00"  193.25  1920 2056 2256 2592  1200 1203 1209 1245 -hsync +vsync
xrandr --addmode DP1 1920x1200_60.00

xrandr --newmode "2048x1536_75.00"  339.00  2048 2208 2432 2816  1536 1539 1543 1606 -hsync +vsync
xrandr --addmode VGA1 2048x1536_75.00

printf "brightness: $(xbacklight)\n"
pulseaudio-ctl

redshift-gtk &

#feh --bg-center --bg-fill /home/saher/Downloads/background.jpg &

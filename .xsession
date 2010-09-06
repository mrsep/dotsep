#!/bin/bash
 
# Load resources
 
xrdb -merge .Xresources
 
# Set up an icon tray
 

#trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 10 --transparent true --tint 0x191970 --height 10 --widthtype request --heighttype request &

# Set the background color
 
xsetroot -solid midnightblue
 
# Fire up apps
 
# gajim &
 
xscreensaver -no-splash &

xmonad &

trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 10 --transparent true --tint 0x191970 --height 12 &
update-notifier &
system-config-printer-applet &
nm-applet --sm-disable &
gnome-power-manager &
gnome-volume-control-applet &



#!/bin/sh

# Source Fedora's common xinitrc commands
. /etc/X11/xinit/xinitrc-common

source $HOME/.profile

# initialize X resource database (if file ~/.Xdefaults is present on the system)
xrdb -merge ~/.Xdefaults

feh --bg-scale /home/cgm/Pictures/wallpapers/forest.jpg

# start pulse audio
/usr/bin/start-pulseaudio-x11

exec i3

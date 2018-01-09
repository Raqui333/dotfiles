#!/bin/bash

# Exports
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
eval $(dircolors)

# Settings
xset -dpms
xset s off
xsetroot -cursor_name left_ptr

# Start Programs
#powerline-daemon --replace &
#dunst &
numlockx &
xrdb $HOME/.Xresources &
$HOME/.fehbg &

#[ -e $HOME/.moc/pid ] || mocp &
[ -e $HOME/.mpd/mpd.pid ] || mpd &

# Start WM/DE
sxhkd &
exec herbstluftwm

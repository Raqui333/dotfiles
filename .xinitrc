#!/bin/bash

# Exports
export LANG="pt_BR.UTF-8"
export LC_ALL="pt_BR.UTF-8"
export LANGUAGE="pt_BR.UTF-8"
export LC_CTYPE="pt_BR.UTF-8"
eval $(dircolors)

# Settings
xset -dpms
xset s off
xsetroot -cursor_name left_ptr

# Start Programs
numlockx &
powerline-daemon --replace &
dunst &
xrdb $HOME/.Xresources &
$HOME/.fehbg &

[ -e $HOME/.mpd/mpd.pid ] || mpd &

# Start WM/DE
sxhkd &
exec herbstluftwm

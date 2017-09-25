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

[ -e /usr/bin/mpd ] && mpd &
[ -e $HOME/.Xresources ] && xrdb $HOME/.Xresources &
[ -e $HOME/.fehbg ] && $HOME/.fehbg &

# Start WM/DE
sxhkd &
exec herbstluftwm

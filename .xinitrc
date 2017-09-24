#!/bin/bash

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

export LANG="pt_BR.UTF-8"
export LC_ALL="pt_BR.UTF-8"
export LANGUAGE="pt_BR.UTF-8"
export LC_CTYPE="pt_BR.UTF-8"
eval $(dircolors)

mpd
numlockx
xset -dpms
xset s off
xsetroot -cursor_name left_ptr
xrdb ~/.Xresources
powerline-daemon --replace
~/.fehbg

sxhkd &
exec herbstluftwm

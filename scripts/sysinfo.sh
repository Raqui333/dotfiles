#!/bin/bash
# By: https://github.com/UserUnavailable

# cor
FG="#3ab8c9"

# font bold e normal
bold="FantasqueSansMono:bold:size=9"
normal="FantasqueSansMono:size=9"

# variaveis das infos
user="$USER@$(uname -n)"
line=$(echo 100 | gdbar -h '2' -ss '2' -fg '#777777' -bg '#121212')

os="$(hostnamectl | awk -F': ' 'NR==6{print $2}NR==8{print $2}' ORS=' ')"
kernel=$(uname -r | sed 's/-[[:alpha:]]*$//')
uptime=$(awk '{printf("%i Hour(s), %i Minute(s)", ($1/60/60%24), ($1/60%60))}' /proc/uptime)
resolution=$(xrandr | awk '/*+/{print $1}')

packages=$(pacman -Qq | wc -l)
shell=$SHELL
cpu=$(awk -F': ' '/model name/{gsub(/\([[:alpha:]]+)|CPU([[:blank:]]{2,})?/,"");print $2}' /proc/cpuinfo)
mem=$(free -m | awk '/Mem/{print $3"MiB", $2"MiB"}' OFS=' / ')

wm=$(wmctrl -m | awk -F': ' '/Name/{print $NF}')
icon=$(awk -F'=' '/gtk-icon-theme-name/{print $NF}' ~/.config/gtk-3.0/settings.ini) 
font=$(awk -F'=' '/gtk-font-name/{print $NF}' ~/.config/gtk-3.0/settings.ini )
theme=$(awk -F'=' '/gtk-theme-name/{print $NF}' ~/.config/gtk-3.0/settings.ini)

(
echo "^fg($FG)Sysinfo"
echo
echo "^p(20)^fg($FG)$user"
echo "^p(20)^fn($normal)$line"
echo "^p(20)^fg($FG)OS^fg()^fn($normal) .........: $os"
echo "^p(20)^fg($FG)Kernel^fg()^fn($normal) .....: $kernel"
echo "^p(20)^fg($FG)Uptime^fg()^fn($normal) .....: $uptime"
echo "^p(20)^fg($FG)Resolution^fg()^fn($normal) .: $resolution"
echo
echo "^p(20)^fg($FG)Packages^fg()^fn($normal) ...: $packages"
echo "^p(20)^fg($FG)Shell^fg()^fn($normal) ......: $shell"
echo "^p(20)^fg($FG)Cpu^fg()^fn($normal) ........: $cpu"
echo "^p(20)^fg($FG)Mem^fg()^fn($normal) ........: $mem"
echo
echo "^p(20)^fg($FG)Wm^fg()^fn($normal) .........: $wm"
echo "^p(20)^fg($FG)Icon^fg()^fn($normal) .......: $icon"
echo "^p(20)^fg($FG)Font^fg()^fn($normal) .......: $font"
echo "^p(20)^fg($FG)Theme^fg()^fn($normal) ......: $theme"
) | dzen2 -p -fn "$bold" -bg "#080808" -fg "#777777" -x "10" -y "35" -h "14" -w "285" -l "19" -e "onstart=uncollapse;button3=exit"

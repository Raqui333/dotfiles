#!/bin/bash

TAB="\t\t\t\t\t"
PHOTO="/home/anonimo/Pictures/SORAWALL.png"
COLOR="\033[01;35m"

OS=$(uname -nm)
KERNEL=$(uname -r | sed 's/-[[:alpha:]]*$//')
RESOLUTION=$(xrandr | awk '/*+/{print $1}')
PACKAGES=$(ls -d /var/db/pkg/*/* | wc -l)

UPTIME=$(awk '{printf("%i Hour(s), %i Minute(s)", ($1/60/60%24), ($1/60%60))}' /proc/uptime)
CPU=$(awk -F': ' '/model name/{gsub(/\([[:alpha:]]+)|CPU([[:blank:]]{2,})?/,"");print $2}' /proc/cpuinfo)
MEM=$(free -m | awk '/Mem/{print $3"MiB", $2"MiB"}' OFS=' / ')

clear

echo
echo -e "${TAB} ${COLOR}$USER@$(uname -n)\033[0m"
echo -e "${TAB} ----------"
echo -e "${TAB} ${COLOR}OS\033[0m .........: $OS"
echo -e "${TAB} ${COLOR}Kernel\033[0m .....: $KERNEL"
echo -e "${TAB} ${COLOR}Resolution\033[0m .: $RESOLUTION"
echo -e "${TAB} ${COLOR}Packages\033[0m ...: $PACKAGES"
echo
echo -e "${TAB} ${COLOR}Uptime\033[0m .....: $UPTIME"
echo -e "${TAB} ${COLOR}Shell\033[0m ......: $SHELL"
echo -e "${TAB} ${COLOR}Cpu\033[0m ........: $CPU"
echo -e "${TAB} ${COLOR}Mem\033[0m ........: $MEM"
echo
echo -e "${TAB}  \033[1;31m███\033[1;32m███\033[1;33m███\033[1;34m███\033[1;35m███\033[1;36m███"
echo
echo;echo;echo

# Config Width, Height, X, Y
POS="38x65+0+3"
printf "\e]20;${PHOTO};${POS}\a"

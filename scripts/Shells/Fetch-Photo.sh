#!/bin/bash

TAB="\t\t\t\t\t\t"
PHOTO="/home/anonimo/Pictures/Asura.jpg"

clear

echo
echo -e "${TAB} \033[01;34m$USER@$(uname -n)\033[0m"
echo -e "${TAB} ----------"
echo -e "${TAB} \033[01;34mOS\033[0m: $(uname -nm)"
echo -e "${TAB} \033[01;34mKernel\033[0m: $(uname -r | sed 's/-[[:alpha:]]*$//')"
echo -e "${TAB} \033[01;34mResolution\033[0m: $(xrandr | awk '/*+/{print $1}')"
echo -e "${TAB} \033[01;34mPackages\033[0m: $(ls -d /var/db/pkg/*/* | wc -l)\n"
echo -e "${TAB} \033[01;34mUptime\033[0m: $(awk '{printf("%i Hour(s), %i Minute(s)", ($1/60/60%24), ($1/60%60))}' /proc/uptime)"
echo -e "${TAB} \033[01;34mShell\033[0m: $SHELL"
echo -e "${TAB} \033[01;34mCpu\033[0m: $(awk -F': ' '/model name/{gsub(/\([[:alpha:]]+)|CPU([[:blank:]]{2,})?/,"");print $2}' /proc/cpuinfo)"
echo -e "${TAB} \033[01;34mMem\033[0m: $(free -m | awk '/Mem/{print $3"MiB", $2"MiB"}' OFS=' / ')"
echo

# Config Width, Height, X, Y
POS="15x20+2+3"
printf "\e]20;${PHOTO};${POS}\a"

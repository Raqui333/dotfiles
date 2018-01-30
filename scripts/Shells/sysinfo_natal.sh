#!/bin/sh

echo
echo -e "\033[01;34m          \033[01;31m##          \033[01;31m$USER@$(hostnamectl | head -n1 | awk '{print $3}')"
echo -e "\033[01;34m         \033[01;31m####         \033[00m------------"
echo -e "\033[01;34m       \033[01;31m#######        \033[01;37mOS\033[00m: Arch Linux"
echo -e "\033[01;34m     \033[01;37m###########      \033[01;31mKernel\033[00m: $(uname -msr)"
echo -e "\033[01;34m     \033[01;37m###########      \033[01;37mWM\033[00m: bspwm"
echo -e "\033[01;34m     #########\033[01;31m##      \033[01;31mUptime\033[00m: $(uptime -p | awk '{print $2,$3,$4,$5}')"
echo -e "\033[01;34m    #####   ##\033[01;37m###     \033[01;37mPacotes\033[00m: $(pacman -Qq | wc -l)"
echo -e "\033[01;34m   #####     #\033[01;37m###\033[01;34m#    \033[01;31mShell\033[00m: $SHELL"
echo -e "\033[01;34m  ###           ###   \033[01;37mCpu\033[00m: $(cat /proc/cpuinfo | sed -n '5p' | awk '{print $4, $5, $6, $7, $8, $9}')"
echo -e "\033[01;34m ##               ##  \033[01;31mMem\033[00m: $(free --mebi | sed -n '2p' | awk '{print $3}')MiB / $(free --mebi | sed -n '2p' | awk '{print $2}')MiB"
echo
echo -e "\033[01;31m                       ███\033[01;32m███\033[01;33m███\033[01;34m███\033[01;35m███\033[01;36m███"
echo

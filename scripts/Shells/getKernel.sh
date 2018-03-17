#!/bin/bash

current=$(uname -r)
latest=$(curl -s "https://www.kernel.org/" | grep "<strong>" | sed -n 's/[^0-9.]//g;3p')
link=$(curl -s "https://www.kernel.org/" | grep "$latest" | sed -n '/tarball/s/.*href="\|".*//g;4p')

if [[ $latest = $current ]]
then
	echo -e "\033[1;32mUptaded"
	exit 0
fi

echo -e "\033[1;31mOutdated Version\033[00m: $current"
echo -e "\033[1;32mLatest Version\033[00m: $latest\n"

echo -e "\033[1;33m  [0] \033[00m-\033[1;33m quit"
echo -e "\033[1;33m  [1] \033[00m-\033[1;33m get tarball link"
echo -e "\033[1;33m  [2] \033[00m-\033[1;33m download latest version"
echo -e "\033[1;33m  [3] \033[00m-\033[1;33m download latest version and compile using current configuration\n\033[00m"

read -p "> " anwser

if [[ $anwser -eq 0 ]]
then
	exit 0
elif [[ $anwser -eq 1 ]]
then
	echo $link
elif [[ $anwser -eq 2 ]]
then
	echo -e "\033[1;32m Downloading kernel $latest tarball\n\033[00m"
	wget -q --show-progress $link
elif [[ $anwser -eq 3 ]]
then
	echo -e "\033[1;32m Downloading kernel $latest tarball\n\033[00m"
        wget -q --show-progress $link
        tar xvf 'linux-'$latest'.tar.xz'
        cd 'linux-'$latest
        if [[ -e /proc/config.gz ]]
        then
                cp /proc/config.gz .
                zcat config.gz > .config
        elif [[ -e '/boot/config-'$current ]]
                cp '/boot/config-'$current .config
        else
                echo "Configuration file not found, make sure you have at least /boot or /proc enabled"
                exit -1
        fi
        make
        make modules_install
        make install
fi

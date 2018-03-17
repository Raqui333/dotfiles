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
echo -e "\033[1;33m  [2] \033[00m-\033[1;33m download latest version\n\033[00m"

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
fi

#!/bin/bash

ps="\033[1;31mroot@$(uname -n)\033[00m: $(pwd) #"

clear

for i in P r m - r f v /
do
	if [[ $i =~ ^P ]]
	then
		i="$ps "
	fi

	if [[ $i =~ m$|v$|#$ ]]
	then
		i+=" "
	fi
	
	echo -ne "$i" && sleep .50
done && echo -e "\n"

for x in $(seq $(ls -ld /* | wc -l))
do
	echo -ne "removed directory "
	ls -ld /* | awk '{print $NF}' | head -$x | tail -1
	sleep .1
done

echo -e "\n\033[1;33mWarning\033[00m: all removed in ' / ' directory"

#!/bin/bash

ICONS="$HOME/scripts/icons"
SPACE="          "

window() {
	command=$(herbstclient layout | awk '/FOCUS/{gsub(/[^[:alpha:][:blank:]]/,"");print $1}')

	case $command in
		vertical)
			icon="$ICONS/Vertical.xbm"
			;;
		horizontal)
			icon="$ICONS/Horizontal.xbm"
			;;
		grid)
			icon="$ICONS/Grid.xbm"
			;;
		max)
			icon="$ICONS/Max.xbm"
			;;
	esac

	window_name=$(xdotool getactivewindow getwindowname)
	window_name_length=$(echo $window_name | wc -c)

	if [ "$window_name" ];then
		if [[ "$window_name" =~ ^emerge ]];then
			title="$(echo $window_name | awk '{print $2"/"$4, $5}' | sed 's/\(\/[[:alnum:]]*\)-.*/\1/;s/[()]//g')"
		elif [ "$window_name_length" -gt 21 ];then
			title=$(echo $window_name | head -c20 | sed 's/ $//;s/$/.../')
		else
			title=$window_name
		fi
	else
		title="None"
	fi

	echo "^fg(#cdcdcd)^i($icon)^fg() $title"
}

volume() {
	icon="$ICONS/Volume.xbm"
	command=$(amixer get Master | awk '/[0-9]%/{gsub(/[][]/,"");print $5}' | head -1 | gdbar -h "3" -bg "#242424" -fg "#aae929" -w "70")
	echo "^fg(#cdcdcd)^i($icon)^fg() $command"
}

kernel() {
        icon="$ICONS/Gentoo.xbm"
	current=$(uname -r)
	latest=$(curl -s "https://www.kernel.org/" | grep "<strong>" | sed -n 's/[^0-9.]//g;3p')
        
	if [[ $current = $latest ]]
	then
		command=$current
	else
		command="$latest -> $current"
	fi

	echo "^fg(#cdcdcd)^i($icon)^fg() $command"
}

packages() {
	icon="$ICONS/Packages.xbm"
	command=$(ls -d /var/db/pkg/*/* | wc -l)
	echo "^fg(#cdcdcd)^i($icon)^fg() $command"
}

dtime() {
          icon="$ICONS/Relogio.xbm"
          command=$(date +'%b %d/%y, %I:%M %P')
          echo "^fg(#cdcdcd)^i($icon)^fg() $command"
}

mem() {
	icon="$ICONS/Mem.xbm"
	command=$(free -h | awk '/Mem/{print $3, $2}' OFS=' / ')
	echo "^fg(#cdcdcd)^i($icon)^fg() $command"
}

temp() {
	icon="$ICONS/Temp.xbm"
	command=$(sensors | awk '/Core/{printf("%i°C\n", $3)}')
	echo "^fg(#cdcdcd)^i($icon)^fg() $command"
}

while :; do
          echo "$(window)$SPACE$(temp)$SPACE$(mem)$SPACE$(packages)$SPACE$(kernel)$SPACE$(dtime)"
          sleep 2
done | dzen2 -p -h 30 -fn fantasquesansmono-9 -fg #777777 &

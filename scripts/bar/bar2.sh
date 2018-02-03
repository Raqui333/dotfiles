#!/bin/bash

killall dzen2
ICONS="$HOME/scripts/icons"
COR="#6d2967"

Window() {
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
		if [ "$window_name_length" -gt 21 ];then
			title=$(echo $window_name | head -c20 | sed 's/ $//;s/$/.../')
		else
			title=$window_name
		fi
	else
		title="None"
	fi

	echo "^fg($COR)^i($icon)^fg() $title"
}

Mem() {
	icon="$ICONS/Mem.xbm"
	command=$(free -h | awk '/Mem/{print $3, $2}' OFS=' / ')
	echo "^fg($COR)^i($icon)^fg() $command"
}

Temp() {
	icon="$ICONS/Temp.xbm"
	command=$(sensors | awk '/Core/{printf("%i°C\n", $3)}')
	echo "^fg($COR)^i($icon)^fg() $command"
}

Pacotes() {
	icon="$ICONS/Packages.xbm"
	command=$(ls -d /var/db/pkg/*/* | wc -l)
	echo "^ca(1,~/scripts/Shells/sysinfo.sh)^fg($COR)^i($icon)^fg() $command^ca()"
}

Musica() {
	icon="$ICONS/Musica.xbm"
	title=$(mpc current -f %title%)
	title_length=$(echo $title | wc -c)

	if [ "$title" ];then
		if [ "$title_length" -gt 21 ];then
			command=$(echo $title | head -c20 | sed 's/ $//;s/$/.../')
		else
			command=$title
		fi
	else
		command="Paused"
	fi

	echo "^ca(1,~/scripts/Shells/mpd.sh)^ca(4,mpc volume +10)^ca(5,mpc volume -10)^fg($COR)^i($icon)^fg() $command^ca()^ca()^ca()"
}

Volume() {
	icon="$ICONS/Volume.xbm"
	command=$(amixer get Master | awk '/[0-9]%/{gsub(/[][]/,"");print $5}' | head -1 | gdbar -h "3" -bg "#242424" -fg "$COR" -w "70")
	echo "^ca(4,amixer set Master 5%+)^ca(5,amixer set Master 5%-)^fg($COR)^i($icon)^fg() $command^ca()^ca()"
}

Hora() {
	icon="$ICONS/Relogio.xbm"
	command=$(date +'%I:%M %p')
	echo "^ca(1,~/scripts/Shells/calendario.sh)^fg($COR)^i($icon)^fg() $command^ca()"
}

Works() {
        posWork="   "
        command=$(wmctrl -d | awk '/*/{print $NF}')
        if [[ $command =~ W[6-9] ]]
        then
                posWork="^bg($COR)^fg(#000000) ${command#W} ^bg()^fg()"
        fi

        works=$(wmctrl -d | awk '{print $2 $NF}' ORS=" " | head -c19 | sed \
                -e "s/\*W[0-5]/^bg($COR)^fg(#000000)  &  ^bg()^fg()/" \
                -e "s/\-W[0-5]/^bg(#777777)^fg(#000000)  &  ^bg()^fg()/g" \
                -e "s/\*\|\-//g" \
                -e "s/W1/TERM/" \
                -e "s/W2/MSG/" \
                -e "s/W3/WEB/" \
                -e "s/W4/CODE/" \
                -e "s/W5/OTHER/")
        
        echo "$works $posWork"
}

User() {
        icon="$ICONS/Gentoo.xbm"
        command=$(wmctrl -m | awk -F': ' '/Name/{print $NF}')
        echo "^fg($COR)^i($icon)^fg() $command"
}

dzen2 -p -bg "#080808" -h "30" -e "button3=" &

sleep 1

while true;do
    echo "$(Works)"
    sleep 2
done | dzen2 -p -ta "c" -bg "#080808" -fg "#777777" -fn "FantasqueSansMono-9" -h "14" -e "button3=" -y "8" &

sleep 1

while true;do
    echo " $(Window)     $(Pacotes)     $(Temp)     $(Mem)"
	sleep 2
done | dzen2 -p -ta "l" -bg "#080808" -fg "#777777" -fn "FantasqueSansMono-9" -h "30" -e "button3=" -w "430" &

sleep 1

while true;do
    echo "$(User)     $(Musica)     $(Volume)     $(Hora) "
	sleep 2
done | dzen2 -p -ta "r" -bg "#080808" -fg "#777777" -fn "FantasqueSansMono-9" -h "30" -e "button3=" -x "868" &

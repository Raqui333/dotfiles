#!/bin/bash
# By: https://github.com/UserUnavailable

## matar o dzen2
killall dzen2

## variavel para a cor
COR="#3ab8c9"

## diretorio dos icons
ICONS="/home/anonimo/scripts/icons"

## font de icons, so para o icon do telegram mesmo
IconFont="FontAwesome-9"

## funções
Works() {
	wmctrl -d | awk '{gsub(/^/,"W");print $2 $1}' ORS='' | sed "s/*[[:alnum:]]*/^bg(#303030)^fg($COR)  & ^fg()^bg()/;s/-[[:alnum:]]*/^bg(#303030)^fg(#777777)  & ^fg()^bg()/g;s/*\|-//g;\
	s:W0:^i($ICONS/Term.xbm):;\
	s:W1:^fn($IconFont)^fn():;\
	s:W2:^i($ICONS/Web.xbm):;\
	s:W3:^i($ICONS/Arq.xbm):;\
	s:W4:^i($ICONS/Code.xbm):;\
	s:W5:^i($ICONS/Img.xbm):;\
	s:W6:^i($ICONS/Game.xbm):;\
	s:W7:^i($ICONS/Video.xbm):;\
	s:W8:^i($ICONS/Arch.xbm):"
}

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
		if [ "$window_name_length" -gt 29 ];then
			title=$(echo $window_name | head -c28 | sed 's/ $//;s/$/.../')
		else
			title=$window_name
		fi
	else
		title="None"
	fi
	
	echo " ^i($icon)  $title"
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
	icon="$ICONS/Pacman.xbm"
	command=$(pacman -Qq | wc -l)
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
	command=$(amixer get Master | awk '/[0-9]%/{gsub(/[][]/,"");print $4}')
	echo "^ca(4,amixer set Master 5%+)^ca(5,amixer set Master 5%-)^fg($COR)^i($icon)^fg() $command^ca()^ca()"
}

Hora() {
	icon="$ICONS/Relogio.xbm"
	command=$(date +'%H:%M')
	echo "^ca(1,~/scripts/Shells/calendario.sh)^i($icon) $command^ca()"
}


## dzen bar de fundo
dzen2 -p -h "26" -bg "$COR" -e "button3=" &

sleep 1

## menu
(
echo "^i($ICONS/Menu.xbm)Menu"
echo "^ca(1,poweroff)^p(5)^i($ICONS/Poweroff.xbm) Poweroff^ca()"
echo "^ca(1,reboot)^p(5)^i($ICONS/Reboot.xbm) Reboot^ca()"
echo "^ca(1,~/scripts/Shells/lock.sh)^p(5)^i($ICONS/Lock.xbm) Lock^ca()"
echo "^ca(1,herbstclient quit)^p(5)^i($ICONS/Exit.xbm) Exit^ca()"
) | dzen2 -p -fn "FantasqueSansMono-10" -x "0" -y "4" -h "22" -fg "#000000" -bg "$COR" -tw "60" -w "100" -l "4" -m -e "button3=;button1=uncollapse;leaveslave=collapse" &

## dzen bar esquerda
while true; do
	echo "^bg(#303030)^fg($COR)^i($ICONS/SD.xbm)^ca()^fg()^bg()$(Works)^fg(#303030)^i($ICONS/SD.xbm)^fg() $(Window)"
	sleep 1
done | dzen2 -p -fn "FantasqueSansMono-10" -x "60" -y "4" -h "22" -fg "#777777" -bg "#121213" -ta "l" -e "button3=" &

sleep 1

## dzen bar direita
while true; do
	echo "^fg(#303030)^i($ICONS/SE.xbm)^fg()^bg(#303030) $(Mem)    $(Temp)    $(Pacotes)    $(Musica)    $(Volume)  ^fg($COR)^i($ICONS/SE.xbm)^fg(#000000)^bg($COR) $(Hora)  ^bg()"
	sleep 1
done | dzen2 -p -fn "FantasqueSansMono-10" -x "700" -y "4" -h "22" -fg "#777777" -bg "#121212" -ta "r" -e "button3=" &

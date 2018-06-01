#!/bin/bash
# Based By: https://github.com/Morgareth99
# Modified By: https://github.com/UserUnavailable

# função
Music() {
	title=$(mpc current -f %title%)
	title_lenght=$(echo $title | wc -c)
	if [ "$title_lenght" -gt 21 ];then
		echo $title | head -c20 | sed 's/ $//;s/$/.../'
	else
		echo $title
	fi
}

# font bold
BOLD="FantasqueSansMono:bold:size=8"

# diretorio dos icons
icon="$HOME/scripts/icons"

# botões do player
player="^ca(1,mpc prev)^i($icon/Prev.xbm)^ca()   ^ca(1,mpc play)^i($icon/Play.xbm)^ca()   ^ca(1,mpc stop)^i($icon/Stop.xbm)^ca()  ^ca(1,mpc next)^i($icon/Next.xbm)^ca()"

while true; do
echo "^p(80)^fg(#3e7bc0)^fn($BOLD)Mpd^fn()^fg()

^p(20)$([ -z "$(mpc current -f %artist%)" ] \
	&& echo "Paused" \
	|| mpc current -f %artist%)
^p(20)$([ -z "$(Music)" ] \
	&& echo "Paused" \
	|| echo $(Music))

^p(41) $player
$(mpc | awk 'NR==2{gsub(/[()]/,"");print $NF}' | gdbar -w 190 -h 3 -fg '#3e7bc0' -bg '#303030')"
sleep 1
done | dzen2 -p -y '35' -x '1000' -l '6' -w '185' -ta 'l' -fg '#777777' -bg '#050505' -fn "FantasqueSansMono:size=8" -e 'onstart=uncollapse;button3=exit'

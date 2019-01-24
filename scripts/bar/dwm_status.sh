#!/bin/bash

LATEST_KERNEL=$(curl -s "https://www.kernel.org/" | awk '/<strong>/{gsub(/[^0-9.]/,"");if (NR==92) print}')
SPACE="  |  "

volume() {
	icon="$ICONS/Volume.xbm"
	command=$(amixer get Master | awk '{gsub(/[][%]/,"")}; /Front Left:/{lf=$5}; /Front Right:/{rf=$5}; END{printf("%i%\n", lf+rf)}')
	echo "$command"
}

kernel() {
        icon="$ICONS/Gentoo.xbm"
	current=$(uname -r)
	latest=$LATEST_KERNEL
        
	if [[ $current = $latest ]]
	then
		command=$current
	else
		command="$latest -> $current"
	fi

	echo "$command"
}

packages() {
	icon="$ICONS/Packages.xbm"
	command=$(ls -d /var/db/pkg/*/* | wc -l)
	echo "$command"
}

dtime() {
          icon="$ICONS/Relogio.xbm"
          command=$(date +'%b %d, %a %I:%M %P')
          echo "$command"
}

mem() {
	icon="$ICONS/Mem.xbm"
	command=$(free -h | awk '/Mem/{print $3, $2}' OFS=' / ')
	echo "$command"
}

temp() {
	icon="$ICONS/Temp.xbm"
	command=$(sensors | awk '/Core/{printf("%i°C\n", $3)}')
	echo "$command"
}

echo "$(temp)$SPACE$(mem)$SPACE$(packages)$SPACE$(kernel)$SPACE$(volume)$SPACE$(dtime)"

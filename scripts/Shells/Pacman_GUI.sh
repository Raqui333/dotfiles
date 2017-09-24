#!/bin/bash

root=$([ $(id -u) -eq 0 ] && echo "root" || echo "no root")

search=$(zenity --title="Instalador ($root)" --entry --text="Procure um pacote:" --ok-label="Procurar")

if [ $? -eq 0 ];then
	list=$(pacman -Ssq $search)
	install=$(zenity --title="Instalador ($root)" --width=800 --height=500 --list --text="Procurar" --column="Busca para: $search" $list --ok-label="Instalar")
	if [ $? -eq 0 ];then
		if [ "$root" != "root" ];then
			zenity --title="Instalador ($root)" --error --text="Você não pode instalar programas a menos que seja root"
			exit 0
		fi
		pacman -S --noconfirm $install | zenity --title="Instalador ($root)" --width=800 --height=500 --text-info --auto-scroll
	fi
fi

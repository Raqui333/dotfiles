#!/bin/bash

# Tema GTK+ atualmente setado
theme_name_seted_GTK2=$(awk -F'=' '/gtk-theme-name/{gsub(/"/,"");print $2}' $HOME/.gtkrc-2.0)
theme_name_seted_GTK3=$(awk -F'=' '/gtk-theme-name/{gsub(/"/,"");print $2}' $HOME/.config/gtk-3.0/settings.ini)

# Tema dos icones atualmente setado
icon_theme_seted_GTK2=$(awk -F'=' '/gtk-icon-theme-name/{gsub(/"/,"");print $2}' $HOME/.gtkrc-2.0)
icon_theme_seted_GTK3=$(awk -F'=' '/gtk-icon-theme-name/{gsub(/"/,"");print $2}' $HOME/.config/gtk-3.0/settings.ini)

# Menu
echo -e "Oque que mudar?\n"

# Alternativas do menu
echo -e "1. Tema das Janelas"
echo -e "2. Tema dos Icones"
echo -e "0. Sair"

# Pegar RESP do Menu
read -p "> " RESP

# Ações de cada alternativa
case $RESP in
	1)
		# THEME
		echo -e "\n[THEME]"
		echo -e "digite o nome do tema abaixo, Q para sair"
		echo -e "'ls /usr/share/themes' para ver o nome dos temas"
		echo -e "atualmente setado \"$theme_name_seted_GTK3\""

		# Pegar nome do tema (THEME)
		read -p "> " new_theme

		if [ "$new_theme" = "Q" -o "$new_theme" = "q" ];then
			exit 0
		fi
		
		# Mudar tema (THEME)
		sed -i "/gtk-theme-name/s/$theme_name_seted_GTK2/$new_theme/" $HOME/.gtkrc-2.0
		sed -i "/gtk-theme-name/s/$theme_name_seted_GTK3/$new_theme/" $HOME/.config/gtk-3.0/settings.ini

		exit 0
		;;
	2)
		# ICONS
		echo -e "\n[ICONS]"
		echo -e "digite o nome do tema abaixo, Q para sair"
		echo -e "'ls /usr/share/icons' para ver o nome dos temas"
		echo -e "atualmente setado \"$icon_theme_seted_GTK3\""

		# Pegar nome do tema (ICONS)
		read -p "> " new_icon_theme

		if [ "$new_icon_theme" = "Q" -o "$new_icon_theme" = "q" ];then
			exit 0
		fi
		
		# Mudar tema (ICONS)
		sed -i "/gtk-icon-theme-name/s/$icon_theme_seted_GTK2/$new_icon_theme/" $HOME/.gtkrc-2.0
                sed -i "/gtk-icon-theme-name/s/$icon_theme_seted_GTK3/$new_icon_theme/" $HOME/.config/gtk-3.0/settings.ini

		exit 0
		;;
	0)
		echo -e "Saindo..."
		sleep 1
		
		exit 0
		;;
	*)
		echo "$(basename -s ".sh" $0): '$RESP' não e uma opção"
		exit 0
		;;
esac

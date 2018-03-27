#!/bin/bash

echo -e "\033[1;32mTraslate english -> portuguese\033[00m"
echo
read -p "word to translate: " wordToT

site=$(curl -s "https://pt.bab.la/dicionario/ingles-portugues/${wordToT}" | grep -o "title=\"&quot;.*&quot; em inglês\">[[:alnum:][:space:]]*" | awk '!/.*>$/{gsub(/.*>/,"");print}' ORS=", ")

if [[ -n ${site} ]]
then
	echo -e "\n\033[1;32m Traslates to \033[4m${wordToT}\033[00m"
	echo ${site} | sed "s/^/  └> /g;s/,$/\n/"
else
	echo -e "\033[1;31m No translate to \033[4m${wordToT}\033[00m"
fi

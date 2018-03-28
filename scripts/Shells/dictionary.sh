#!/bin/bash

echo -e "\033[1;32mTraslate english -> portuguese\033[00m"
echo
read -p "word to translate: " wordToT

translate=$(curl -s "https://pt.bab.la/dicionario/ingles-portugues/${wordToT}" | grep -o "title=\"&quot;.*&quot; em inglês\">[[:alnum:][:space:]?\!]*" | awk '!/.*>$/{gsub(/.*>/,"");print}' ORS=", ")
conjugation=$(curl -s "https://pt.bab.la/verbo/ingles/${wordToT}" | grep -o "sense-group-results\"><li>[[:alnum:][:space:]]*" | awk -F">" 'NR>1{print $NF}' ORS=", ")
examples=$(curl -s "https://pt.bab.la/dicionario/ingles-portugues/${wordToT}" | grep -o "...</span>.*\.<" | awk -F"</span>" 'NR<=8{gsub(/.<$|<\/?b>/,"");print $1":", $NF}' ORS=":|:")

if [[ -n ${translate} ]]
then
	echo -e "\n\033[1;32m Traslates to \033[4m${wordToT}\033[00m"
	echo ${translate} | sed 's/^/  └> /g;s/,$//'

	if [[ -n ${conjugation} ]]
	then
		echo ${conjugation} | sed 's/^/    └> /g;s/,$/\n/'
	else
		echo -e "\033[1;32m    regular verb\033[00m\n"
	fi

	echo -e "\033[1;32m Examples:\033[00m"
	echo ${examples} | sed 's/:|:/\n/g;s/ul>:/  └> /g;s/ish:/\n/g'
else
	echo -e "\033[1;31m No translate to \033[4m${wordToT}\033[00m"
fi

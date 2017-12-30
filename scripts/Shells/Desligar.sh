#!/bin/bash

echo "Script Para Desligar"
echo "Digite a hora e o dia que vc quer desligar"
echo "ex: 06, 255"
echo "sendo 06 as horas e 255 o dia"
echo "hoje é dia $(date +%j)"

# Pegando a Info
read -p "> " horaDataDesligar

# Separando as Info
hora=$(echo $horaDataDesligar | awk -F"," '{print $1}')
data=$(echo $horaDataDesligar | awk -F"," '{print $2}')

# Fazendo a diferença de hora
if [ "$data" -gt "$(date +%j)" ];then
	horaDef=$(($(seq $(date +%0H) 24 | wc -l) + $hora))
	
	# convertendo em segundos
	horaSegundos=$((horaDef * 60 * 60))

	# Finalmente Desligar
	echo "Seu computador sera desligado em '$horaSegundos' segundos"
	shutdown -h -t $horaSegundos
elif [ "$data" -eq "$(date +%j)" ];then
	horaDef=$(seq $(date +%0H) 24 | wc -l)

	# convertendo em segundos
	horaSegundos=$((horaDef * 60 * 60))
	
	# Finalmente Desligar
	echo "Seu computador sera desligado em '$horaSegundos' segundos"
	shutdown -h -t $horaSegundos
else
	echo "ERRO"
fi

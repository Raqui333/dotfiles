#!/bin/bash
# By: https://github.com/UserUnavailable

## pegar a cor setada atualmente
COR_ATUAL=$(awk -F= '/COR=/,gsub(/"/,""){print substr($2,2)}' ~/scripts/bar/bar.sh)

## pegar a cor setada anteriormente
COR_ANTERIOR=$(awk -F= '/COR=/,gsub(/"/,""){print substr($2,2)}' ~/scripts/bar/bar.sh.bkp)

while true;do
	clear

	echo "Mudar a cor do WM"
	echo "digite a cor desejada"
	
	echo -e "\ncor anterior: #$COR_ANTERIOR"
	echo "cor atual: #$COR_ATUAL"
	read -p "nova cor: #" NOVA_COR
	
	echo -e "\na cor que você quer e '#$NOVA_COR' mesmo? S:sim / N:não / Q:sair"

	read -p "> " RESP

	case $RESP in
		S|s)
			sed "s/$COR_ATUAL/$NOVA_COR/g" $(find $HOME/scripts -regextype sed -regex '.*/*.sh')
			sed "s/$COR_ATUAL/$NOVA_COR/g" $HOME/.config/herbstluftwm/autostart
			herbstclient reload
			echo "Cor alterada com sucesso!!!"
			break
			;;
		N|n)
			echo "Reiniciando..."
			sleep 1
			;;
		Q|q)
			echo "Saindo..."
			sleep 1
			break
			;;
		*)
			echo "Erro"
			break
			;;
	esac
done

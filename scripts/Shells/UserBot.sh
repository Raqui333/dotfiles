#!/bin/bash

TOKEN="<token>"
URL="https://api.telegram.org/bot$TOKEN"
END=$(($(curl -s "$URL/getUpdates" | wc -l) - 1))
CHAT_ID="<grupo>"

getHelp(){
	echo "Uso: userbot [comando]"
	echo
	echo "	-h  ou  --help						Para a lista de comandos"
	echo
	echo "	-m  ou  --msg     \"<message>\"				Para enviar uma menssagem"
	echo "	-r  ou  --reply	  \"<id>\" \"<message>\"			Para responder uma messagem"
	echo "	-d  ou  --delete  \"<id>\"				Para deletar uma menssagem"
	echo "	-e  ou  --edit    \"<id>\" \"<new message>\"		Para editar uma messagem"
	echo
	echo "	-u  ou  --updates					Para rodar o getUpdates"
	echo "	-s  ou  --sed						Para rodar o commandSed"
	echo
}

getUpdates(){
	offset=$(curl -s "$URL/getUpdates" | jq -r ".result[$END].update_id + 1")
	update=$(curl -s "$URL/getUpdates" | wc -l)
        if [ "$update" -gt 95 ];then
		curl -s "$URL/getUpdates?offset=$offset"
        else
		curl -s "$URL/getUpdates"
        fi
}

sendMessage(){
	curl -s --data-urlencode "text=$(echo -e $1)" "$URL/sendMessage?chat_id=$CHAT_ID&parse_mode=html&disable_web_page_preview=true" \
		| jq -r ".result.message_id, .result.text, .result.chat.title" | sed '1s/^/ID ...: &/;2s/^/MSG ..: &/;3s/^/CHAT .: &/'
}

replyMessage(){
	curl -s --data-urlencode "text=$(echo -e $2)" "$URL/sendMessage?chat_id=$CHAT_ID&reply_to_message_id=$1&parse_mode=html&disable_web_page_preview=true" \
		| jq -r ".result.message_id, .result.text, .result.chat.title" | sed '1s/^/ID ...: &/;2s/^/MSG ..: &/;3s/^/CHAT .: &/'
}

deleteMessage(){
	curl -s "$URL/deleteMessage?chat_id=$CHAT_ID&message_id=$1" \
		1> /dev/null 2> /dev/null && echo "deleted" || echo "error"
}

editMessage(){
	curl -s --data-urlencode "text=$(echo -e $2)" "$URL/editMessageText?chat_id=$CHAT_ID&message_id=$1&parse_mode=html&disable_web_page_preview=true" \
		1> /dev/null 2> /dev/null && echo "edited" || echo "error"
}

sendSticker(){
	curl -s "$URL/sendSticker?chat_id=$CHAT_ID&sticker=$1"
}

commandSed(){
	reply_to_message=$(getUpdates | jq -r ".result[$END].message.reply_to_message.text")
	reply_to_message_id=$(getUpdates | jq ".result[$END].message.reply_to_message.message_id")
	message=$(getUpdates | jq -r ".result[$END].message.text")
	sed_message=$(echo "$reply_to_message" | sed "$message")
	echo "Message: $reply_to_message"
	echo "Command: $message"
	echo "Output:  $sed_message"
	replyMessage $reply_to_message_id "<b>Você Quis Dizer</b>\n$sed_message"
}

case $1 in
	-h|--help)
		getHelp
		;;
	-m|--msg)
		sendMessage "$2"
		;;
	-r|--reply)
		replyMessage "$2" "$3"
		;;
	-s|--sed)
		commandSed
		;;
	-u|--updates)
		getUpdates
		;;
	-d|--delete)
		deleteMessage "$2"
		;;
	-e|--edit)
		editMessage "$2" "$3"
		;;
	-S|--sticker)
		sendSticker "$2"
		;;
	*)
		echo "userbot: comando invalido, '$1'"
		echo "userbot: use --help para ver a lista de comandos"
		;;
esac

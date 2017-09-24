#!/bin/bash

sleep .5
scrot /tmp/back.png
BACK="/tmp/back.png"
ICON="$HOME/Imagens/cadeado.png"
convert $ICON -geometry 300x300 /tmp/icon.png
convert $BACK -blur 0x5 $BACK
convert $BACK /tmp/icon.png -gravity Center -composite -matte $BACK
i3lock -u -i $BACK

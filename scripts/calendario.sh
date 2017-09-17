#!/bin/bash
# By: https://github.com/UserUnavailable

# cor
C1="#3ab8c9"

# font bold e normal
BOLD="FantasqueSansMono:bold:size=8"
NORMAL="FantasqueSansMono:size=8"

(
echo "^fn($BOLD)^fg($C1)Calendar^fg()"; echo
echo "$(date +'%B          %Y')"
cal | awk 'NR==2' | sed "s/\(.*\)/^bg($C1)^fg(#000000) \1 ^fg()^bg()/g"; echo
cal | awk 'NR>2'  | sed "s/ \([0-9]\) /0\1 /g;s/\($(date +%d)\)/^bg($C1)^fg(#000000)\1^fg()^bg()/"
) | dzen2 -p -fn "$NORMAL" -x "1206" -y "35" -bg "#080808" -fg "#777777" -l "10" -w "150" -sa "c" -e "onstart=uncollapse;button3=exit"

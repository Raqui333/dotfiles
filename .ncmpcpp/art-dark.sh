#!/bin/bash

# Based By: https://gist.github.com/vlevit/4588882/
# Modified By: https://github.com/UserUnavailable

albumDirectory="$HOME/Music"
COVER="/tmp/cover.jpg"

(
     album="$(mpc current -f %album%)"

     albumPhoto=$(find "${albumDirectory}" -regex ".*/\(${album}\)\.\(png\|jpe?g\)")
     convert "${albumPhoto}" ${COVER}
     
     printf "\e]20;${COVER};30x70+4+35\a"
) &

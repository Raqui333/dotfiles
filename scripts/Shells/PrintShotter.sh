#!/bin/bash

## dependences: xclip, scrot

appName=$(basename ${0} .sh)

helpMsg="Usage: ${appName} [options]{[arg]}\n\n"
helpMsg+="   -h, --help      \t\t  Show this menssage.\n"
helpMsg+="   -n, --no-save   \t\t  Print to clipboard without save.\n"
helpMsg+="   -p, --path      \t\t  Inform the path to save the image, default is \$HOME.\n"
helpMsg+="   -c, --clipboard \t    Print to clipboard saving, default is \$HOME.\n"

exampleMsg="Examples:\n"
exampleMsg+="   ${appName} --no-save\n"
exampleMsg+="   ${appName} --path ~/Desktop\n"
exampleMsg+="   ${appName} --clipboard\n"
exampleMsg+="   ${appName} --clipboard ~/Desktop\n"

case ${1} in
          -h|--help)
                    echo -e ${helpMsg}
                    echo -e ${exampleMsg}
                    ;;
          -p|--path)
                    test -d ${2} || ( echo "${appName}: no such file '${2}'" ; exit 2 )
                    scrot ${2}/%d-%m-%Y_%H:%M:%S.png
                    ;;
          -n|--no-save)
                    scrot ~/%d-%m-%Y_%H:%M:%S.png
                    xclip -t image/png ~/$(date +'%d-%m-%Y_%H:%M:%S.png') -selection clipboard
                    rm ~/$(date +'%d-%m-%Y_%H:%M:%S.png')
                    ;;
          -c|--clipboard)
                    if [[ ! -z ${2} ]]; then
                              test -d ${2} || ( echo "${appName}: no such file '${2}'" ; exit 2 )
                              scrot ${2}/%d-%m-%Y_%H:%M:%S.png
                              xclip -t image/png ${2}/$(date +'%d-%m-%Y_%H:%M:%S.png') -selection clipboard
                    else
                              scrot ~/%d-%m-%Y_%H:%M:%S.png
                              xclip -t image/png ~/$(date +'%d-%m-%Y_%H:%M:%S.png') -selection clipboard
                    fi
                    ;;
          *)
                  echo "${appName}: no option '${1}'."
                  exit 2
                  ;;
esac

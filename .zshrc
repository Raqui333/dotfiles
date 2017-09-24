HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
 
alias ls="ls --color=auto"
alias grep="grep --color=auto"
alias vim="nvim"
alias merge="xrdb ~/.Xresources && echo \" Xresources reloaded\""
alias userbot="~/scripts/Shells/UserBot.sh $1"
alias musica="mpv "$1" --no-vid"
alias color="~/scripts/Shells/mudar_cor.sh"

source /usr/lib/python3.6/site-packages/powerline/bindings/zsh/powerline.zsh

autoload -U compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

bindkey '^[[3~' delete-char
bindkey '^[[8~' end-of-line
bindkey '^[[7~' beginning-of-line

setopt menu_complete


HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
 
alias ls="ls --color=auto"
alias grep="grep --color=auto"
alias vim="nvim"
alias merge="xrdb $HOME/.Xresources && echo \" Xresources reloaded\""
alias userbot="$HOME/scripts/Shells/UserBot.sh $1"
alias musica="mpv \"$1\" --no-vid"
alias color="$HOME/scripts/Shells/mudar_cor.sh"

#source /usr/lib/python3.6/site-packages/powerline/bindings/zsh/powerline.zsh
PS1="%B%F{10}%n@%m%F{12} %~ %b%#%f "

autoload -U compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

bindkey '^[[3~' delete-char
bindkey '^[[8~' end-of-line
bindkey '^[[7~' beginning-of-line

setopt menu_complete

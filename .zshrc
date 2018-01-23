HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

export LSF=/mnt/lfs

#source /usr/lib/python3.6/site-packages/powerline/bindings/zsh/powerline.zsh

PS1="%B%F{5}┌[%f%n@%m%F{5}]%f-%F{5}[%f%T %(0?.%fOK.%fERROR %?)%F{5}]%f-%F{5}[%f %~ %F{5}]
└╼%f%b "

autoload -U compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

bindkey '^[[3~' delete-char
bindkey '^[[8~' end-of-line
bindkey '^[[7~' beginning-of-line

setopt MENU_COMPLETE

alias ls="ls --color=auto"
alias grep="grep --color=auto"
alias vim="nvim"
alias merge="xrdb $HOME/.Xresources && echo \"Xresources reloaded\""
alias update="sudo emerge --ask --verbose --newuse --deep --with-bdeps=y --update @world"

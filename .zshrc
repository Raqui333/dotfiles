# Zsh Config
#

# History
#
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# Variables
#
export LFS=/mnt/lfs

# Prompt
#
PS1="%B┌[%F{10}%n%f@%F{10}%m%f]%F{11}-%f[%F{10}%*%f][%(0?.%F{10}OK.%F{9}ERROR %?)%f]%F{11}-%f[%F{10} %~ %f]
└╼%b "

autoload -U compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

bindkey '^[[3~' delete-char
bindkey '^[[8~' end-of-line
bindkey '^[[7~' beginning-of-line

setopt menu_complete

# Funtions
#
function merge(){
	if [[ -e $HOME/.Xresources ]]
	then
		xrdb $HOME/.Xresources
		echo -e "\033[1;32mXresources reloaded"
	fi
}

function update(){
	case $1 in
		-n|--no-ask)
			sudo emerge --newuse --deep --with-bdeps=y --update @world
			;;
		-s|--sync)
			sudo emerge --sync
			;;
		-h|--help)
			echo "[USAGE] update <option>"
			echo
			echo " -n or --no-ask    run emerge update with no --ask argument"
			echo " -s or --sync      run emerge --sync"
			echo " -h or --help      print this mansage"
			;;
		*)
			sudo emerge --ask --verbose --newuse --deep --with-bdeps=y --update @world
			;;
	esac
}

# Aliases
#
alias ls="ls --color=auto"
alias grep="grep --color=auto"
alias merge=merge
alias update=update

# Zsh HighLighting Settings
#
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main pattern regexp)

ZSH_HIGHLIGHT_STYLES[alias]="fg=10"
ZSH_HIGHLIGHT_STYLES[reserved-word]="fg=11,bold"
ZSH_HIGHLIGHT_STYLES[command]="fg=10"
ZSH_HIGHLIGHT_STYLES[commandseparator]="fg=240"
ZSH_HIGHLIGHT_STYLES[globbing]="fg=13"
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]="fg=246"
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]="fg=246"
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]="fg=166"
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]="fg=166"
ZSH_HIGHLIGHT_STYLES[path]="fg=4,bold"
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]="fg=5"
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]="fg=5"
ZSH_HIGHLIGHT_STYLES[assign]="fg=14,bold"
ZSH_HIGHLIGHT_STYLES[redirection]="fg=166"

# Anti-Drop
#
ZSH_HIGHLIGHT_PATTERNS+=("rm" "fg=9,underline")
ZSH_HIGHLIGHT_REGEXP+=("(.*?)\(\)\{\1(\|\1)?\}\|\1" "bg=9,bold,fg=0")
ZSH_HIGHLIGHT_REGEXP+=("(sudo[:space:])?rm -rf(v)? /(\*)?" "bg=9,bold,fg=0")

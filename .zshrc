# Zsh Config
#

# History
#
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# Variables
#
EDITOR=/usr/bin/vim
mainColor="1"
eval $(dircolors)

# Modules
#
autoload -U compinit vcs_info
compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':vcs_info:*' formats %b

# keys
#
bindkey "^[[P"   delete-char
bindkey '^A'      beginning-of-line
bindkey '^[[3~'   end-of-line
bindkey '^[[4~'   beginning-of-line
bindkey '^[[5~'   history-search-backward
bindkey '^[[6~'   history-search-forward

# Options
#
setopt menu_complete
setopt auto_cd
setopt share_history
setopt extended_history
setopt hist_ignore_all_dups
setopt prompt_subst

# Functions
#
function git_branch() {
	vcs_info
	if [[ ! ${vcs_info_msg_0_} = $NULL ]]
	then
		echo ":: %f(%F{$mainColor}${vcs_info_msg_0_}%f) "
	fi
}

# Aliases
#
alias ls="ls --color=auto"
alias grep="grep --color=auto"
alias update="sudo emerge --ask --verbose --newuse --deep --with-bdeps=y --update @world"
alias md="mkdir -p"
alias color="$HOME/scripts/Shells/cores_zsh.sh"

# Zsh AutoSuggestions Setting
#
source $HOME/Applications/zsh-autosuggestions/zsh-autosuggestions.zsh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=237,bold"

# Zsh HighLighting Settings
#
source $HOME/Applications/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

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
ZSH_HIGHLIGHT_STYLES[function]="fg=11"
ZSH_HIGHLIGHT_STYLES[builtin]="fg=10"

# Anti-Drop
#
ZSH_HIGHLIGHT_PATTERNS+=("sudo" "fg=10,underline")
ZSH_HIGHLIGHT_PATTERNS+=("rm" "fg=9,underline")
ZSH_HIGHLIGHT_REGEXP+=("(.*?)\(\)\{\1(\|\1&?)?\}(\||;)\1" "bg=9,bold,fg=0")
ZSH_HIGHLIGHT_REGEXP+=("(sudo[:space:])?rm -rf(v)? /(\*)?" "bg=9,bold,fg=0")

# Prompt
#
PS1='%B%F{$mainColor}%m%f :: %F{$mainColor}%*%f :: %F{$mainColor}%~%f $(git_branch)%(0?..%F{1}%?%f)
%b> '

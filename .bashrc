# .bashrc
# https://github.com/todashuta/.dotfiles

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

## Prompt {{{
#
PS1="$(
	red='\[\033[0;31m\]'
	green='\[\033[0;32m\]'
	blue='\[\033[0;34m\]'
	brown='\[\033[0;33m\]'

	light_red='\[\033[01;31m\]'
	light_green='\[\033[01;32m\]'
	light_blue='\[\033[01;34m\]'
	light_yellow='\[\033[01;33m\]'

	reset_color='\[\033[00m\]'

	if [[ "$UID" -eq 0 ]]; then
		ps1="${light_red}\u@\h${reset_color}:${light_blue}\w${reset_color}\njobs:\j \$ "
	else
		ps1="${light_green}\u@\h${reset_color}:${light_blue}\w${reset_color}\njobs:\j \$ "
	fi

	# If this is an xterm set the title to user@host:dir
	case "$TERM" in
	(xterm*|rxvt*)
		ps1='\[\e]0;\u@\h: \w\a\]'"$ps1"
		;;
	(*)
		:
		;;
	esac

	echo "$ps1"
)"

# }}}


## History {{{
#
export HISTCONTROL=ignoreboth  # ignoreboth=ignorespace+ignoredups
#export HISTIGNORE="fg*:bg*:history*:cd*"

HISTSIZE=10000             # 使用中のbashの履歴数
HISTFILESIZE=100000        # ~/.bash_historyに記録する数

#HISTTIMEFORMAT='%Y%m%d %T'  # コマンド履歴に時刻を追加
#export HISTTIMEFORMAT

# }}}


## enable color of ls  {{{
#
export LSCOLORS=gxfxcxdxbxegedabagacad
export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=36;40:tw=30;42:ow=30;43'
case "${OSTYPE}" in
freebsd*|darwin*)
	alias ls="ls -G"
	which gls >/dev/null 2>&1 && alias ls='gls --color=auto' || :
	;;
linux*)
	alias ls="ls --color=auto"
	;;
esac

# }}}


## aliases {{{
#
# job control
alias f=fg
alias j='jobs -l'

# ls
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lt='ls -altFr'

# grep
if which ggrep >/dev/null 2>&1; then
	alias egrep='ggrep --color=auto -E'
	alias fgrep='ggrep --color=auto -F'
	alias grep='ggrep --color=auto'
else
	alias egrep='grep --color=auto -E'
	alias fgrep='grep --color=auto -F'
	alias grep='grep --color=auto'
fi

# cd
alias cd-='cd ~-'
alias ..='cd ..'

# environment specific aliases
case "${OSTYPE}" in
freebsd*|darwin*)
	#if [ -f /Applications/Emacs.app/Contents/MacOS/Emacs ]; then
	#  alias emacs='/Applications/Emacs.app/Contents/MacOS/Emacs -nw'
	#  alias cemacs='/Applications/Emacs.app/Contents/MacOS/Emacs'
	#fi

	if [ -f /Applications/MacVim.app/Contents/MacOS/MacVim ]; then
		alias gvim='/Applications/MacVim.app/Contents/MacOS/mvim'
	fi

	if [ -f /Applications/MacVim.app/Contents/MacOS/Vim ]; then
		alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'
	fi

	#alias firefox='open -a Firefox.app'
	#alias safari='open -a Safari.app'
	;;
linux*)
	:
	;;
esac

# }}}


# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'


[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases || :
[[ -f ~/.bashrc.local ]] && . ~/.bashrc.local || :


# vim: set noet foldmethod=marker :
# end of .bashrc

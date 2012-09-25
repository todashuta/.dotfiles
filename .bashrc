# .bashrc
# https://github.com/todashuta/profiles


## プロンプト {{{
#
#PS1='\u@\h:\w\n\$ '
PS1="\[\e[32m\]\u@\h\[\e[0m\] \[\e[33m\]\w\[\e[0m\]\n\$ "

# }}}


## History {{{
#
# ignorespace+ignoredups = ignoreboth
#
export HISTCONTROL=ignoreboth
export HISTIGNORE="fg*:bg*:history*:cd*"
HISTSIZE=10000
HISTFILESIZE=100000

# }}}


# コマンド履歴に時刻を追加 {{{
HISTTIMEFORMAT='%Y%m%d %T';
export HISTTIMEFORMAT

# }}}


# OS別ls色付け分岐 {{{
case "${OSTYPE}" in
freebsd*|darwin*)
  export LSCOLORS=gxfxcxdxbxegedabagacad
  alias ls="ls -G"
  ;;
linux*)
  export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=36;40:tw=30;42:ow=30;43'
  alias ls="ls --color=auto"
  ;;
esac

#}}}


# ls関連エイリアス
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# grep関連エイリアス
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias cd-='cd ~-'
alias ..='cd ..'


# OS別エイリアス設定 {{{
case "${OSTYPE}" in
freebsd*|darwin*)
  alias emacs='/Applications/Emacs.app/Contents/MacOS/Emacs'
  alias macvim='/Applications/MacVim.app/Contents/MacOS/MacVim'
  alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'
  alias firefox='open -a Firefox.app'
  alias safari='open -a Safari.app'
  alias kod='open -a Kod.app'
  alias cot='open -a CotEditor.app'
  ;;
linux*)

  ;;
esac

# }}}


# ~/.bash_aliases があれば読み込む
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi


# ローカル設定があれば読み込む
if [ -f ~/.bashrc.local ]; then
    . ~/.bashrc.local
fi


# vim:foldmethod=marker
# end of .bashrc

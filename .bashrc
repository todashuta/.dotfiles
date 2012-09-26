# .bashrc
# https://github.com/todashuta/profiles


## プロンプト {{{
#
PS1="\[\e[32m\]\u@\h\[\e[0m\] \[\e[33m\]\w\[\e[0m\]\n\$ "

# }}}


## History {{{
#
export HISTCONTROL=ignoreboth  # ignoreboth=ignorespace+ignoredups
export HISTIGNORE="fg*:bg*:history*:cd*"

HISTSIZE=10000             # 使用中のbashの履歴数
HISTFILESIZE=100000        # ~/.bash_historyに記録する数

#HISTTIMEFORMAT='%Y%m%d %T'  # コマンド履歴に時刻を追加
#export HISTTIMEFORMAT

# }}}


## ls色付けOS別分岐 {{{
#
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


## エイリアス。 {{{
#
# ls
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# cd
alias cd-='cd ~-'
alias ..='cd ..'

# 確認付きファイル操作
alias rmi='rm -i'
alias mvi='mv -i'
alias cpi='cp -i'

# }}}


## OS別エイリアス設定 {{{
#
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


## ~/.bash_aliases があれば読み込む
#
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi


## ローカル設定があれば読み込む
#
if [ -f ~/.bashrc.local ]; then
    . ~/.bashrc.local
fi


# vim:foldmethod=marker
# end of .bashrc

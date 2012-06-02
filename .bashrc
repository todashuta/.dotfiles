# .bashrc
# https://github.com/todashuta/profiles

# プロンプトのカスタマイズ
PS1='\u@\h:\w\n\$ '

# ヒストリー
HISTCONTROL=ignoredups:ignorespace
HISTSIZE=1000
HISTFILESIZE=2000

# OS別ls色付け分岐 {{{
case "${OSTYPE}" in
freebsd*|darwin*)
  export LSCOLORS=gxfxcxdxbxegedabagacad
  alias ls="ls -G"
  ;;
linux*)
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

# end of .bashrc

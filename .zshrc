# .zshrc
# https://github.com/todashuta/profiles


## lsコマンド関連設定 {{{
#
# OS別分岐 {{{
#
case "${OSTYPE}" in
freebsd*|darwin*)
  alias ls="ls -G"  # lsの結果に色付け(MacOS)
  ;;
linux*)
  alias ls="ls --color=auto"  # lsの結果に色付け(Linux)
  ;;
esac

# }}}


export LSCOLORS=gxfxcxdxbxegedabagacad
export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=36;40:tw=30;42:ow=30;43'


alias ll="ls -alF"  #llでls -alFにする
alias la="ls -A"    #laでls -Aにする
alias l="ls -CF"    #lでls -CFにする

# }}}


## grep関連コマンドに色付け {{{
#
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'

# }}}


## OS別エイリアス設定 {{{
#
case "${OSTYPE}" in
freebsd*|darwin*)
  if [ -f /Applications/Emacs.app/Contents/MacOS/Emacs ]; then
    alias emacs='/Applications/Emacs.app/Contents/MacOS/Emacs -nw'
    alias cemacs='/Applications/Emacs.app/Contents/MacOS/Emacs'
  fi

  if [ -f /Applications/MacVim.app/Contents/MacOS/MacVim ]; then
    alias gvim='/Applications/MacVim.app/Contents/MacOS/MacVim'
  fi

  if [ -f /Applications/MacVim.app/Contents/MacOS/Vim ]; then
    alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'
  fi

  alias firefox='open -a Firefox.app'
  alias safari='open -a Safari.app'
  alias kod='open -a Kod.app'
  alias cot='open -a CotEditor.app'
  ;;
linux*)
  # ここにlinux用設定記述する
  ;;
esac

# }}}


## zsh補完機能設定 {{{
#
# emacsキーバインド
bindkey -e

# スラッシュを単語の一部と見なさない
# ==> C-w の単語削除時にディレクトリ単位で(スラッシュごとに)削除する
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# zsh-completions
if [ -d /usr/local/share/zsh-completions ]; then
  fpath=(/usr/local/share/zsh-completions $fpath)
fi

# インクリメンタル補完プラグイン
source ~/.zsh/plugin/incr*.zsh

# Use zsh completion system.
autoload -Uz compinit
compinit -u
#autoload -Uz compinit && compinit -d ${ZDOTDIR}/.zcompdump
#ZDOTDIR=${HOME}/.zsh
#autoload -Uz compinit && compinit -d ${HOME}/.zsh/.zcompdump

zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' '+m:{A-Z}={a-z}'

zstyle ':completion:*' list-separator '==>'

# 補完候補を矢印キーなどで選択可能にする
zstyle ':completion:*:default' menu select

# 補完候補をLS_COLORSに合わせて色付け
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# ディレクトリ名を入力するだけで移動
setopt auto_cd

# 移動したディレクトリを記録しておく。"cd -[Tab]"で移動履歴を一覧
setopt auto_pushd

# Don't push multiple copies of the same directory onto the directory stack.
# ディレクトリスタックに重複するものを記録しない
setopt pushd_ignore_dups

# コマンド訂正
setopt correct

# 補完候補を詰めて表示する
setopt list_packed

# 補完候補表示時などにピッピとビープ音をならないように設定
setopt nolistbeep

# 明確なドットの指定なしで.から始まるファイルを補完
setopt globdots

# Tab連打で順に補完候補を自動で補完
setopt auto_menu

# サスペンド中のプロセスと同じコマンド名を実行した場合はリジューム
setopt auto_resume

# Don't show completions when using *.
#setopt glob_complete

# C-dでログアウトしない
#setopt ignore_eof

# }}}


## プロンプトの設定 {{{
#
PROMPT="%F{green}%n@%m%f %F{yellow}%50<...<%~%<<%f
%(?.%F{blue}(^_^)%f.%F{red}(@_@%)%f)${WINDOW:+"[$WINDOW]"}%# "

setopt transient_rprompt  # 右側まで入力がきたら消す

setopt prompt_subst  # プロンプトが表示されるたびにプロンプト文字列を評価、置換

# }}}


## 履歴設定 {{{
#
HISTFILE=$HOME/.zsh_history    # 履歴をファイルに保存する
HISTSIZE=1000000               # メモリ内の履歴の数
SAVEHIST=1000000               # 保存される履歴の数

# 履歴設定オプション
#
setopt extended_history        # 履歴ファイルに時刻を記録
setopt hist_ignore_dups        # 同じコマンドを重複して記録しない
setopt hist_ignore_all_dups    # 既にあるコマンド行は古い方を削除
setopt hist_reduce_blanks      # コマンドラインの余計なスペースを排除
setopt share_history           # 履歴ファイルを共有
setopt hist_ignore_space       # 先頭に空白を入れると記録しない

# }}}


## zsh設定追加 {{{
#
# zsh editor
autoload zed

# }}}


# cdのあと自動でls {{{
#
function cd(){
    builtin cd $@ && ls;
}

# }}}


## ローカル設定があれば読み込む {{{
#
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# }}}


# vim:foldmethod=marker
# end of .zshrc

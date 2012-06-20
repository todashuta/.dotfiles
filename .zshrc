# .zshrc
# https://github.com/todashuta/profiles

# emacsキーバインド
bindkey -e

# コマンド補完追加
fpath=(~/.zsh/functions/Completion ${fpath})

# lsコマンド関連設定 {{{
# OS別分岐 {{{
case "${OSTYPE}" in
freebsd*|darwin*)
  export LSCOLORS=gxfxcxdxbxegedabagacad
  alias ls="ls -G"  # lsの結果に色付け(MacOS)
  ;;
linux*)
  alias ls="ls --color=auto"  # lsの結果に色付け(Linux)
  ;;
esac
# }}}

alias ll="ls -alF"  #llでls -alFにする
alias la="ls -A"    #laでls -Aにする
alias l="ls -CF"    #lでls -CFにする
# }}}

# grep関連コマンドに色付け {{{
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
# }}}

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


# zsh補完機能設定 {{{
autoload -U compinit
compinit -u
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' '+m:{A-Z}={a-z}'

# ディレクトリ名を入力するだけで移動
setopt auto_cd

# 移動したディレクトリを記録しておく。"cd -[Tab]"で移動履歴を一覧
setopt auto_pushd

# コマンド訂正
setopt correct

# 補完候補を詰めて表示する
setopt list_packed

# 補完候補表示時などにピッピとビープ音をならないように設定
setopt nolistbeep

# }}}


# プロンプトの設定 {{{
#PS1="${USER}@${HOST%%.*}:%~
PS1="${USER}@${HOST%%.*} (%T)
%(!.#.%%) "
RPROMPT="[%~]"            # 右側にフルパス表示
setopt transient_rprompt  # 右側まで入力がきたら消す
# }}}

# 履歴設定 {{{
HISTFILE=$HOME/.zsh_history    # 履歴をファイルに保存する
HISTSIZE=1000000               # メモリ内の履歴の数
SAVEHIST=1000000               # 保存される履歴の数
# 履歴設定オプション
setopt extended_history        # 履歴ファイルに時刻を記録
setopt hist_ignore_dups        # 同じコマンドを重複して記録しない
setopt hist_ignore_all_dups    # 既にあるコマンド行は古い方を削除
setopt hist_reduce_blanks      # コマンドラインの余計なスペースを排除
setopt share_history           # 履歴ファイルを共有
setopt hist_ignore_space       # 先頭に空白を入れると記録しない
# }}}

# インクリメンタル補完プラグイン
source ~/.zsh/plugin/incr*.zsh

# vim:foldmethod=marker
# end of .zshrc

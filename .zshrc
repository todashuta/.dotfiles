# .zshrc
# https://github.com/todashuta/profiles

## lsコマンド関連設定
alias ls="ls -G"    #lsの結果に色付け
alias ll="ls -alF"  #llでls -alFにする
alias la="ls -A"    #laでls -Aにする
alias l="ls -CF"    #lでls -CFにする

## grep関連コマンドに色付け
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'

## 補完機能
autoload -U compinit
compinit
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' '+m:{A-Z}={a-z}'

## ディレクトリ名を入力するだけで移動
setopt auto_cd

## 移動したディレクトリを記録しておく。"cd -[Tab]"で移動履歴を一覧
setopt auto_pushd

## コマンド訂正
setopt correct

## 補完候補を詰めて表示する
setopt list_packed

## 補完候補表示時などにピッピとビープ音をならないように設定
setopt nolistbeep

## プロンプトの設定(単色二段式)
PS1="${USER}@${HOST%%.*}:%~
%(!.#.%%) "
#RPROMPT="%T"              # 右側のプロンプト(24時間制での現在時刻)
#setopt transient_rprompt  # 右側まで入力がきたら消す

# 履歴保存設定
HISTFILE=$HOME/.zsh_history           # 履歴をファイルに保存する
HISTSIZE=1000000                      # メモリ内の履歴の数
SAVEHIST=1000000                      # 保存される履歴の数
setopt extended_history               # 履歴ファイルに時刻を記録
setopt hist_ignore_dups               # 同じコマンドを重複して記録しない
setopt share_history                  # 履歴ファイルを共有
setopt hist_ignore_space              # 先頭に空白を入れると記録しない
#function history-all { history -E 1 } # 全履歴の一覧を出力する

# インクリメンタル補完プラグイン
source ~/.zsh/plugin/incr*.zsh

# end of .zshrc

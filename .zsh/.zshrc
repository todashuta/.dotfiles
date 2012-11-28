# .zshrc
# https://github.com/todashuta/profiles


profiles=${HOME}/.profiles.d
source ${profiles}/functions


## Aliases
#
init_aliases


## Completion configuration {{{
#
# Emacs like keybind
bindkey -e

# Use zsh completion system!
autoload -Uz compinit && compinit -u

# Activate zsh-completions
if [ -d /usr/local/share/zsh-completions ]; then
	fpath=(/usr/local/share/zsh-completions $fpath)
fi

# Incremental completion on zsh
# http://mimosa-pudica.net/zsh-incremental.html
source ${ZDOTDIR}/plugin/incr*.zsh

# スラッシュを単語の一部と見なさない
# ==> C-w の単語削除時にディレクトリ単位で(スラッシュごとに)削除できる
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# Fuzzy match
#zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' '+m:{A-Z}={a-z}'

# Ignore case
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# 補完候補でオプションとかの表示をするときに左右を分けてる部分の設定
zstyle ':completion:*' list-separator '==>'

# 補完候補を矢印キーなどで選択可能にする
zstyle ':completion:*:default' menu select

# 補完候補をLS_COLORSに合わせて色付け
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# ディレクトリ名を入力するだけで移動
setopt auto_cd

# 移動したディレクトリを記録しておく。"cd -[Tab]"で移動履歴を一覧表示
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
setopt ignore_eof

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
HISTFILE=${ZDOTDIR}/.zsh_history    # 履歴をファイルに保存する
HISTSIZE=1000000                    # メモリ内の履歴の数
SAVEHIST=1000000                    # 保存される履歴の数

# 履歴設定オプション
#
setopt extended_history             # 履歴ファイルに時刻を記録
setopt hist_ignore_dups             # 同じコマンドを重複して記録しない
setopt hist_ignore_all_dups         # 既にあるコマンド行は古い方を削除
setopt hist_reduce_blanks           # コマンドラインの余計なスペースを排除
setopt share_history                # 履歴ファイルを共有
setopt hist_ignore_space            # 先頭に空白を入れると記録しない

# マッチしたコマンドのヒストリを表示できるようにする
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# }}}


## zsh設定追加 {{{
#
# zsh editor
autoload zed

# }}}


## ローカル設定があれば読み込む {{{
#
if [ -f ~/.zshrc.local ]; then
	. ~/.zshrc.local
fi

# }}}


# vim:foldmethod=marker
# end of .zshrc

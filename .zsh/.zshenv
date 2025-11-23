#
# 非ログインシェルとして起動されたときに適切な .zshenv を読み込むための設定。
# 
# zsh はログインシェル/非ログインシェル関係なく $ZDOTDIR/.zshenv を毎回読み込むが、
# ログイン時は $ZDOTDIR が未設定のため、代わりに $HOME/.zshenv が読み込まれる（$ZDOTDIR == $HOME の状態）。
# ただし、自分の使い方では、 $HOME/.zshenv で $ZDOTDIR を別の場所に設定しているため、
# ログイン後に非ログインシェルを起動した際に読み込まれる $ZDOTDIR/.zshenv はこのファイルとなり、
# $HOME/.zshenv の内容は無視されてしまう。
#
# その対策として、 $ZDOTDIR が設定されていて $HOME/.zshenv が存在するときに $HOME/.zshenv を読み込む。
#
[[ -n "$ZDOTDIR" && -f "$HOME/.zshenv" ]] && source "$HOME/.zshenv" || :

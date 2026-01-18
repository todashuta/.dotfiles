# dotfiles

## 使い方

### クローン

```bash
git clone https://github.com/todashuta/.dotfiles.git ~/.dotfiles
git submodule update --init --recursive
```

下記の各手順では`~/.dotfiles`にクローンしていると想定。

### Git

`~/.gitconfig`を作成し下記の内容を書く。

```gitconfig
[include]
	path = ~/.dotfiles/.gitconfig

# 環境に依存する設定など追加
```

### Vim

```bash
ln -s ~/.dotfiles/.vim ~/.vim
```

- Vimを起動（プラグインが入ってないので初回は多少エラーメッセージ出ます）
- `:PackUpdate`を実行してプラグインをインストールする。

### Emacs

```bash
ln -s ~/.dotfiles/.emacs.d ~/.emacs.d
```

### tmux

`~/.tmux.conf`を作成し下記の内容を書く。

```
set -g @tmux_dir ~/.dotfiles/tmux
source-file -F '#{@tmux_dir}/tmux.conf'

# ステータスラインの色とか環境別で変えたい設定を追加（任意）
set -g default-terminal "xterm-256color"
set -g status-bg colour136
set -g pane-active-border-style fg=colour136,bg=colour136
set -g pane-border-style fg=colour136,bg=default
```

### Zsh

`~/.zshenv`を作成し下記の内容を書く。

```zsh
export ZDOTDIR="$HOME/.dotfiles/.zsh"

# 環境変数とかPATHとか設定追加
# zshenvではなくzprofileに書くべき(?)諸説あり
```

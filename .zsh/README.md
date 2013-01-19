# ずぃーしぇる

`.zshrc`などなど...

## Usage

ディレクトリ構成

	$HOME/
	 |-- .zshenv            -> $HOME/.zsh/.zshenv
	 `-- .zsh/              => ZDOTDIRはココ
	      |-- .zcompdump    -> ここに生成されるが.gitignoreで除外してる
	      |-- .zlogin
	      |-- .zsh_history  -> ここに生成されるが.gitignoreで除外
	      |-- .zshenv       -> $HOME/.zshenvにこれのシンボリックリンクを作る
	      |-- .zshrc        -> 主役
	      `-- plugin/       -> プラグインとか

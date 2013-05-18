# Tips

雑に書いた使い方メモ


## Vim

- **Visual Mode で選択中に`u`で小文字化、`U`で大文字化**
- コマンドラインで`vim -`で起動すると標準入力を開くことができる
	- `% echo $PATH | vim -`
	- `%vim - < /tmp/hoge`
	- `vim -`だけで起動して、テキトーに入力してから`C-d`で抜けるとか
- <Ctrl-v>で矩形ビジュアルに入って`I(大文字)`で挿入モードに入って、文字を打って、`Esc`で、選択していた行にまとめて同じ文字が入る(一括コメントアウトとか)
- 正規表現
	- `/foo/i => ignorecase`
	- `/foo/I => noignorecase`
	- `\zs`と`\ze`
		- foobarhoge がある場合に
		- /foo\zsbar\zehoge/ とすると
		- => fooとhogeに挟まれたbarにマッチする
- インデント
	- `gg=G` => 一気にインデント整う
- 挿入モード中に`<C-r>=`で式評価レジスタになる。計算式を入れたら結果が入力されたりとか他にもいろいろできそう
- netrw
	- `<CR> (Return, Enter)`: ディレクトリに移動 or ファイルを開く
	- `o`: 水平分割で開く
	- `v`: 垂直分割で開く
	- `P`: 直前に使用していたウインドウで開く
		- `p`: プレビュー(C-w C-zでプレビューウインドウ閉じる)
	- `t`: 新しいタブで開く
	- `-`: 上のディレクトリに移動
	- `F1`: ヘルプ
	- `i`: 表示方法切り替え(thin, long, wide, tree)
	- `s`: ソート方法切り替え(name, time, file size)
	- `x`: 関連付けられたプログラムで開く
- ウインドウサイズ変更
	- 縦幅: `C-w + (+|-)`
	- 横幅: `C-w + (<|>)`


## Git

### submodule

	% git submodule foreach 'git status'  # => 各々のsubmoduleに一斉にコマンド実行

	% git status --ignore-submodule  # => submoduleを除いたstatus

#### submoduleの削除
- .gitmodulesから該当行を削除
- .git/configから該当行を削除
- `% git rm --cached path/to/hoge`


## その他

- `sudo vim /path/to/file`, `sudo emacs /path/to/file` などでなく、 `sudo -e`, `sudoedit` を使う
	- vimやemacsからは外部シェルが起動可能でセキュリティ上問題があるから
	- *開いたユーザの$EDITORとエディタの設定が使える*
- PATHに`.` => カレントディレクトリ を追加しない
	- カレントディレクトリに一般的なコマンドと同名の実行ファイルがあって、それが危険な動作をするものだったら...
- ClamXav のアップデート後にエンジンもアップデートしたらアクセス権が変更されて brew がエラーになるので brew インストール時と同じようにアクセス権を適切に変更する
	- `/usr/bin/sudo /bin/chmod g+w /usr/local/`
	- `/usr/bin/sudo /usr/bin/chgrp staff /usr/local/`
	- *重大な操作なので実行ファイルが絶対パスで指定されている*

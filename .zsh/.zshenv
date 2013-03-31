# .zshenv
# https://github.com/todashuta/profiles


## ZDOTDIR
## zsh設定関連ファイルを一箇所にまとめる
export ZDOTDIR=${HOME}/.zsh


#profiles=${HOME}/.profiles.d
#source ${profiles}/functions


## LANG
export LANG=ja_JP.UTF-8


## PATH {{{

# 重複したパスを登録しない
typeset -U path

path=(

	# Homebrew
	/usr/local/bin(N-/)
	/usr/local/sbin(N-/)

	# MacPorts
	/opt/local/bin(N-/)
	/opt/local/sbin(N-/)

	# X11 (XQuartz)
	/opt/x11/bin(N-/)

	# node.js
	/usr/local/share/npm/bin(N-/)

	# python
	/usr/local/share/python(N-/)

	# Use MacVim
	#/Applications/MacVim.app/Contents/MacOS(N-/)

	# Use coreutils without the prefix "g".
	#/usr/local/opt/coreutils/libexec/gnubin

	# My shell scripts.
	${HOME}/bin(N-/)
	# prefix=$HOME/local でインストールしたものの場所
	${HOME}/local/bin(N-/)

	# システムのデフォルトのパス
	$path
	
)  # }}}


## MacPorts
if type port > /dev/null 2>&1; then
	export DISPLAY=:0
fi


## Android SDK
if type android > /dev/null 2>&1; then
	# -x: export ANDROID_SDK_ROOTも同時に行う
	# -T: ANDROID_SDK_ROOTとandroid_sdk_rootを連動する
	typeset -xT ANDROID_SDK_ROOT android_sdk_root
	# 重複したパスを登録しない
	typeset -U android_sdk_root
	# パスを設定
	android_sdk_root=(
		/usr/local/opt/android-sdk(N-/)
	)
fi


## node.js NODE_PATH
#if type node &> /dev/null; then
if type node > /dev/null 2>&1; then
	# -x: export NODE_PATHも同時に行う
	# -T: NODE_PATHとnode_pathを連動する
	typeset -xT NODE_PATH node_path
	# 重複したパスを登録しない
	typeset -U node_path
	# パスを設定
	node_path=(
		/usr/local/share/npm/lib/node_modules(N-/)
	)
fi


## initialize rbenv
if [ -d ${HOME}/.rbenv ]; then
	eval "$(rbenv init -)"
fi


## MANPATH {{{

# 重複したパスを登録しない
typeset -U manpath

manpath=(

	# MANPATH of the Coreutils - GNU core utilities.
	#/usr/local/opt/coreutils/libexec/gnuman(N-/)

	# システムのデフォルトのパス
	$manpath
	
)  # }}}


## PAGER {{{

if type lv > /dev/null 2>&1; then
	# lvを優先する
	export PAGER="lv"
else
	# lvがなかったらlessを使用する
	export PAGER="less"
fi

## lvの設定
export LV='-c -l'

## lessの設定
export LESS='-gj10 --no-init --quit-if-one-screen --RAW-CONTROL-CHARS'
## lessとSource-highlightでソースコードに色付けする
if [ -x /usr/share/source-highlight/src-hilite-lesspipe.sh ]; then
	export LESSOPEN='| /usr/share/source-highlight/src-hilite-lesspipe.sh %s'
elif [ -x /usr/local/bin/src-hilite-lesspipe.sh ]; then
	export LESSOPEN='| /usr/local/bin/src-hilite-lesspipe.sh %s'
fi

# }}}


## EDITOR
export EDITOR=vim


## ls colors
export LSCOLORS=gxfxcxdxbxegedabagacad
export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=36;40:tw=30;42:ow=30;43'


## What is ZLS_COLORS?? lol
export ZLS_COLORS=${LS_COLORS}


# __END__
# vim: set fdm=marker:

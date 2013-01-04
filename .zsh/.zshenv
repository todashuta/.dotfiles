# .zshenv


profiles=${HOME}/.profiles.d
source ${profiles}/functions


## ZDOTDIR settings
#
export ZDOTDIR=${HOME}/.zsh


## LANG
#
export LANG=ja_JP.UTF-8


## PATH settings
#
# Homebrew
if [ -f /usr/local/bin/brew ]; then
	export PATH=/usr/local/bin:/usr/local/sbin:${PATH}
fi

# MacPorts
if [ -f /opt/local/bin/port ]; then
	export PATH=/opt/local/bin:/opt/local/sbin:${PATH}
	export DISPLAY=:0
fi


## Init rbenv
#
if [ -d ${HOME}/.rbenv ]; then
	 eval "$(rbenv init -)"
fi


## Android SDK
#
if [ -e /usr/local/opt/android-sdk ]; then
	export ANDROID_SDK_ROOT=/usr/local/opt/android-sdk
fi


## PAGER
#
if type lv > /dev/null 2>&1; then
	# lvを優先する
	export PAGER="lv"
else
	# lvがなかったらlessを使用する
	export PAGER="less"
fi

# lessでソースコードに色付けする
export LESS='-gj10 --no-init --quit-if-one-screen --RAW-CONTROL-CHARS'
export LESSOPEN='| /usr/local/bin/src-hilite-lesspipe.sh %s'


## EDITOR
#
export EDITOR=vim


# ls colors
export LSCOLORS=gxfxcxdxbxegedabagacad
export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=36;40:tw=30;42:ow=30;43'

# What is ZLS_COLORS?? lol
export ZLS_COLORS=$LS_COLORS


# End of .zshenv

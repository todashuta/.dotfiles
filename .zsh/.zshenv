# .zshenv


## ZDOTDIR settings
#
export ZDOTDIR=${HOME}/.zsh


## LANG
#
#export LANG=ja_JP.UTF-8


## PATH settings
#
if [ -f /usr/local/bin/brew ]; then
  export PATH=/usr/local/sbin:/usr/local/bin:${PATH}
fi


## Init rbenv
#
[ -d ${HOME}/.rbenv ] && eval "$(rbenv init -)"


## Android SDK
#
if [ -d /usr/local/Cellar/android-sdk/r21 ]; then
  export ANDROID_SDK_ROOT=/usr/local/Cellar/android-sdk/r21
fi


# End of .zshenv

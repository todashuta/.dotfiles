# .zshenv for macOS

export ZDOTDIR=~/.dotfiles/.zsh

# ~/.zsh_sessions/ が生成されないようにする (Save/Restore Shell Stateの無効化)
# 参考: /etc/zshrc_Apple_Terminal
export SHELL_SESSIONS_DISABLE=1

export LANG='ja_JP.UTF-8'
export EDITOR=vim

export LSCOLORS='gxfxcxdxbxegedabagacad'
export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=36;40:tw=30;42:ow=30;43'
#export ZLS_COLORS="${LS_COLORS}"

# .zshenv ends here

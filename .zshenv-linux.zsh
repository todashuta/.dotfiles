## zshenv for Linux

export ZDOTDIR="${HOME}/.zsh"

GOROOT="$HOME/local/go/current"  # official binary
export GOROOT
GOPATH="$HOME/go"
export GOPATH

typeset -gx -U path
path=(
    ${HOME}/bin(N-/^W)
    ${HOME}/.plenv/bin(N-/^W)
    ${HOME}/.rbenv/bin(N-/^W)
    ${HOME}/.cargo/bin(N-/^W)
    ${path}
    ${GOROOT}/bin(N-/^W)
    ${GOPATH}/bin(N-/^W)
    ${HOME}/local/bin(N-/^W)
    ${HOME}/.local/bin(N-/^W)

    #/usr/local/sbin
    #/usr/sbin
    #/sbin
)

EDITOR=vim
export EDITOR

export LSCOLORS='gxfxcxdxbxegedabagacad'
export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=36;40:tw=30;42:ow=30;43'
export ZLS_COLORS="${LS_COLORS}"

[ -x "$(which rbenv 2>/dev/null)" ] && eval "$(rbenv init - zsh)" || :
[ -x "$(which plenv 2>/dev/null)" ] && eval "$(plenv init - zsh)" || :

skip_global_compinit=1
